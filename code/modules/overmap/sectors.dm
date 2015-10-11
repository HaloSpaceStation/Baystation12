
//===================================================================================
//Build overmap
//===================================================================================
//see code\controllers\Processes\overmap.dm

datum/controller/process/overmap/setup()

	/*if(!config.use_overmap)
		return kill()*/

	overmap_controller = src

	testing("Building overmap...")

	var/obj/effect/mapinfo/data
	for(var/level in 1 to world.maxz)
		data = locate("sector[level]")
		testing("Z-Level [level] is a sector")
		if(istype(data, /obj/effect/mapinfo/ship))							//First we'll check for ships, because they can occupy multiplie levels
			testing("Sector is a ship with tag [data.tag]!")
			var/obj/effect/map/ship/found_ship = locate("ship_[data.sectorname]")
			if(found_ship)													//If there is a ship with such a name...
				testing("Ship \"[data.sectorname]\" found at [data.mapx],[data.mapy] corresponding to zlevel [level]")
				found_ship.ship_levels += level								//Adding this z-level to the list of the ship's z-levels.
				map_sectors["[level]"] = found_ship
			else
				found_ship = new data.obj_type(data)	//If there is no ship with such name, we will create one.
				found_ship.ship_levels += level
				map_sectors["[level]"] = found_ship
				testing("Ship \"[data.sectorname]\" created \"[data.name]\" at [data.mapx],[data.mapy] corresponding to zlevel [level]")
		else if(istype(data, /obj/effect/mapinfo/precreated))
			testing("Adding precreated ship! Tag: [data.tag] Name: [data.name] at [data.mapx],[data.mapy] corresponding to z[level]")
			//map_sectors["[level]"] = new data.obj_type(data)
			cached_spacepre["[data.name]"] = data
		else if (data)
			testing("Sector is a normal sector")
			testing("Located sector \"[data.name]\" at [data.mapx],[data.mapy] corresponding to zlevel [level]")
			map_sectors["[level]"] = new data.obj_type(data)

	for(var/obj/effect/map/ship/S in world)
		S.update_spaceturfs()

	for(var/x in 1 to 3)
		load_prepared_sector("Meteor Shower", "MeteorShower[x]")

	callHook("customOvermap", list(overmap_controller))

	//to enable debugging of map_sectors
	map_sectors_reference = list() //just in case
	map_sectors_reference = map_sectors

	for(var/obj/machinery/computer/helm/H in machines)
		H.reinit()

	return 1

//===================================================================================
//Metaobject for storing information about sector this zlevel is representing.
//Should be placed only once on every zlevel.
//===================================================================================
/obj/effect/mapinfo/
	name = "map info metaobject"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	invisibility = 101
	var/obj_type		//type of overmap object it spawns
	var/landing_area 	//type of area used as inbound shuttle landing, null if no shuttle landing area
	var/zlevel
	var/mapx			//coordinates on the
	var/mapy			//overmap zlevel
	var/known = 1
	var/sectorname = "Generic Sector"

/obj/effect/mapinfo/New()
	tag = "sector[z]"
	zlevel = z

/obj/effect/mapinfo/sector
	name = "generic sector"
	obj_type = /obj/effect/map/sector

/obj/effect/mapinfo/ship
	name = "generic ship"
	obj_type = /obj/effect/map/ship
	var/ship_turfs
	var/ship_levels
	sectorname = "Generic Space Vessel"

//===================================================================================
//Overmap object representing zlevel
//===================================================================================

/obj/effect/map
	name = "map object"
	icon = 'icons/obj/items.dmi'
	icon_state = "sheet-plasteel"
	var/map_z = 0
	var/area/shuttle/shuttle_landing
	var/always_known = 1
	var/heading = 0
	dir = 1
	var/list/my_observers = list()
	var/list/my_turrets = list()

/obj/effect/map/New(var/obj/effect/mapinfo/data)
	map_z = data.zlevel
	name = data.name
	always_known = data.known
	if (data.icon != 'icons/mob/screen1.dmi')
		icon = data.icon
		icon_state = data.icon_state
	if(data.desc)
		desc = data.desc
	var/new_x = data.mapx ? data.mapx : rand(OVERMAP_EDGE, world.maxx - OVERMAP_EDGE)
	var/new_y = data.mapy ? data.mapy : rand(OVERMAP_EDGE, world.maxy - OVERMAP_EDGE)
	loc = locate(new_x, new_y, OVERMAP_ZLEVEL)

	if(data.landing_area)
		shuttle_landing = locate(data.landing_area)

/obj/effect/map/CanPass(atom/movable/A)
	//testing("[A] attempts to enter sector\"[name]\"")
	return 1

/obj/effect/map/Crossed(atom/movable/A)
	//testing("[A] has entered sector\"[name]\"")
	if (istype(A,/obj/effect/map/ship))
		var/obj/effect/map/ship/S = A
		S.current_sector = src

/obj/effect/map/Uncrossed(atom/movable/A)

	//testing("[A] has left sector\"[name]\"")
	if (istype(A,/obj/effect/map/ship))
		var/obj/effect/map/ship/S = A
		S.current_sector = null

/obj/effect/map/bullet_act(var/obj/item/projectile/P, def_zone)
	if(P.firer == src)
		world << "overmap projectile skipping source [src]"
		return PROJECTILE_CONTINUE

	world << "[src] has been hit by [P]"

/obj/effect/map/sector
	name = "generic sector"
	desc = "Sector with some stuff in it."
	anchored = 1

//Space stragglers go here

/obj/effect/map/sector/temporary
	name = "Deep Space"
	icon_state = ""
	always_known = 0

/obj/effect/map/sector/temporary/New(var/nx, var/ny, var/nz)
	loc = locate(nx, ny, OVERMAP_ZLEVEL)
	map_z = nz
	map_sectors["[map_z]"] = src
	testing("Temporary sector at [x],[y] was created, corresponding zlevel is [map_z].")

/obj/effect/map/sector/temporary/Del()
	map_sectors["[map_z]"] = null
	testing("Temporary sector at [x],[y] was deleted.")
	if (can_die())
		testing("Associated zlevel disappeared.")
		world.maxz--

/obj/effect/map/sector/temporary/proc/can_die(var/mob/observer)
	testing("Checking if sector at [map_z] can die.")
	for(var/mob/M in player_list)
		if(M != observer && M.z == map_z)
			testing("There are people on it.")
			return 0
	return 1


/proc/load_prepared_sector(var/name = input("Sector name: "), var/storname = input("Storage Name: "), var/xpos as num, var/ypos as num)
	if(cached_spacepre["[name]"])
		var/obj/effect/mapinfo/precreated/data = cached_spacepre["[name]"]
		data.mapx = xpos ? xpos : data.mapx
		data.mapy = ypos ? ypos : data.mapy
		map_sectors["[storname]"] = new data.obj_type(data)
		for(var/obj/machinery/computer/helm/H in machines)
			H.reinit()
		return TRUE
	else
		return FALSE
	return FALSE

/proc/unload_prepared_sector(var/name = input("Sector Name: "), var/storname = input("Storage Name: "))
	if(map_sectors["[storname]"] && cached_spacepre["[name]"])
		var/obj/effect/map/data = map_sectors["[storname]"]
		qdel(data)
		map_sectors -= storname
		for(var/obj/machinery/computer/helm/H in machines)
			H.reinit()
		return TRUE
	else
		return FALSE
	return FALSE
