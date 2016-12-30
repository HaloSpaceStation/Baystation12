
//Space stragglers go here

/obj/effect/overmapobj/temporary_sector
	name = "Deep Space"
	icon_state = "blank"
	//always_known = 0
	var/map_z
	//invisibility = 101	//leave "visible" but spriteless for testing

	var/list/objects_preventing_recycle = list()
	hide_vehicles = 0

/obj/effect/overmapobj/temporary_sector/New(var/nx, var/ny, var/nz)
	loc = locate(nx, ny, OVERMAP_ZLEVEL)
	map_z = nz
	map_sectors["[map_z]"] = src
	testing("Temporary sector at [x],[y] was created, corresponding zlevel is [map_z].")
	scanner_manager = new()

/*
/obj/effect/overmapobj/temporary_sector/Del()
	map_sectors["[map_z]"] = null
	testing("Temporary sector at [x],[y] was deleted.")
	if (can_die())
		testing("Associated zlevel disappeared.")
		world.maxz--
*/

/obj/effect/overmapobj/temporary_sector/proc/can_die(var/atom/movable/departing_atom)
	testing("Checking if sector at [map_z] can die...")
	for(var/atom/movable/A in objects_preventing_recycle)
		var/obj/effect/zlevelinfo/curz = locate("zlevel[A.z]")
		if(!(curz in linked_zlevelinfos))
			objects_preventing_recycle -= A
		else if(A == departing_atom)
			objects_preventing_recycle -= A

	if(objects_preventing_recycle.len)
		testing("	Objects blocking recycling")
		objects_preventing_recycle.Add(departing_atom)
		return 0
	testing("	Able to be recycled")
	//objects_preventing_recycle.Add(departing_atom)
	/*for(var/mob/M in player_list)
		if(M != observer && M.z == map_z)
			testing("There are people on it.")
			return 0*/
	return 1

/*
/proc/load_prepared_sector(var/name = input("Sector name: "), var/storname = input("Storage Name: "), var/xpos as num, var/ypos as num)
	if(cached_zlevels["[name]"])
		var/obj/effect/zlevelinfo/precreated/data = cached_zlevelspre["[name]"]
		/*data.mapx = xpos ? xpos : data.mapx
		data.mapy = ypos ? ypos : data.mapy*/
		map_sectors["[storname]"] = new /obj/effect/overmapobj(data)
		for(var/obj/machinery/computer/helm/H in machines)
			H.reinit()
		return TRUE
	else
		return FALSE
	return FALSE

/proc/unload_prepared_sector(var/name = input("Sector Name: "), var/storname = input("Storage Name: "))
	if(map_sectors["[storname]"] && cached_zlevelspre["[name]"])
		var/obj/effect/overmapobj/data = map_sectors["[storname]"]
		qdel(data)
		map_sectors -= storname
		for(var/obj/machinery/computer/helm/H in machines)
			H.reinit()
		return TRUE
	else
		return FALSE
	return FALSE
*/

/datum/controller/process/overmap/var/list/temp_sectors = list()
/datum/controller/process/overmap/var/cur_temp_sector_index = 0

/datum/controller/process/overmap/proc/process_temp_sectors()
	if(temp_sectors.len)
		cur_temp_sector_index++
		if(cur_temp_sector_index > temp_sectors.len)
			cur_temp_sector_index = 1
		attempt_recycle_temp_sector(temp_sectors[cur_temp_sector_index])

//when spacetravelling out of a temporary sector, it will automatically call this proc
/datum/controller/process/overmap/proc/attempt_recycle_temp_sector(var/obj/effect/overmapobj/temporary_sector/temp_sector, var/atom/movable/departing_atom)
	if(!istype(temp_sector))
		return

	if(temp_sector.can_die(departing_atom))
		testing("Catching [temp_sector] for future use")
		for(var/obj/effect/zlevelinfo/cur_level in temp_sector.linked_zlevelinfos)
			cached_zlevels += cur_level
			map_sectors -= "[cur_level.z]"
			cur_level.name = "undefined zlevel (recycled)"
		temp_sector.linked_zlevelinfos = list()
		qdel(temp_sector)
