
//===================================================================================
//Overmap object representing a zlevel or other notable object
//===================================================================================

/obj/effect/overmapobj
	name = "undefined overmapobj"				//the display name for everybody
	var/true_name = "undefined overmapobj"		//the hidden name for people who know what it is (mainly just occupants)
	icon = 'code/modules/overmap/ships/sector_icons.dmi'
	icon_state = ""		//default warning signal to show a missing sprite
	dir = 1
	var/area/shuttle/shuttle_landing
	var/always_known = 1
	var/list/my_observers = list()
	var/list/my_turrets = list()
	var/faction = ""
	var/list/obj_turfs = list()
	var/list/linked_zlevelinfos = list()

	var/in_meteor_sector = 0

	var/initialised = 0
	var/max_turf_dimx = 1	//for cross-sector travel if this object is travelling faster than 1 turf at a time
	var/max_turf_dimy = 1

//override in children if necessary (used by ships)
/obj/effect/overmapobj/proc/overmap_init()

/obj/effect/overmapobj/proc/start_meteors()
	if(!in_meteor_sector)
		processing_objects += src
		in_meteor_sector = 1

/obj/effect/overmapobj/proc/stop_meteors()
	if(in_meteor_sector)
		processing_objects -= src
		in_meteor_sector = 0
		time_next_meteor = world.time

/*
/obj/effect/overmapobj/New(var/obj/effect/zlevelinfo/data)
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
*/

/obj/effect/overmapobj/CanPass(atom/movable/A)
	//testing("[A] attempts to enter sector\"[name]\"")
	return 1

/obj/effect/overmapobj/Crossed(atom/movable/A)
	//testing("[A] has entered sector\"[name]\"")
	if (istype(A,/obj/effect/overmapobj/ship))
		var/obj/effect/overmapobj/ship/S = A
		S.current_sector = src

/obj/effect/overmapobj/Uncrossed(atom/movable/A)

	//testing("[A] has left sector\"[name]\"")
	if (istype(A,/obj/effect/overmapobj/ship))
		var/obj/effect/overmapobj/ship/S = A
		S.current_sector = null

/obj/effect/overmapobj/bullet_act(var/obj/item/projectile/P, def_zone)
	if(P.firer == src)
		world << "overmap projectile skipping source [src]"
		return PROJECTILE_CONTINUE

	world << "[src] has been hit by [P]"

/obj/effect/overmapobj/proc/get_offedge_turf(var/atom/movable/source_atom, var/movedir)
	var/turf/inner_edge = src.loc
	if(source_atom.loc in locs)
		inner_edge = source_atom.loc

	for(var/turf/T in locs)
		//if we're heading in the right direction and this turf lines up, check it

		if(movedir & NORTH)
			if(T.y < inner_edge.y)
				continue
			if(T.y > inner_edge.y || T.x == inner_edge.x)
				inner_edge = T

		if(movedir & SOUTH)
			if(T.y > inner_edge.y)
				continue
			if(T.y < inner_edge.y || T.x == inner_edge.x)
				inner_edge = T

		if(movedir & EAST)
			if(T.x > inner_edge.x)
				continue
			if(T.x < inner_edge.x || T.y == inner_edge.y)
				inner_edge = T

		if(movedir & WEST)
			if(T.x < inner_edge.x)
				continue
			if(T.x > inner_edge.x || T.y == inner_edge.y)
				inner_edge = T

	var/turf/outer_edge = get_step(inner_edge, movedir)
	//check for nulls (edge of map)
	if(!outer_edge)
		outer_edge = inner_edge

	return outer_edge
