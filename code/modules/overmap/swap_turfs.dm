
//used by shuttles and virtual areas
//i thought i'd make this a global seeing as it seems generically useful, ther's just a little bit of edge case handling i couldn't shake
//warning: make sure the stuff getting swapped can handle it in their logic! results might be unpredictable otherwise
/proc/swap_turfs(var/turf/interior, var/turf/destination, var/leave_underlay = 0)
	. = 0

	//save a copy of destination's turf data
	//todo: there is an easier way to do this using var/list/vars
	var/old_type = destination.type
	var/old_dir1 = destination.dir
	var/old_icon_state1 = destination.icon_state
	var/old_icon1 = destination.icon
	var/old_overlays = destination.overlays.Copy()
	var/old_underlays = destination.underlays.Copy()
	var/old_opacity = destination.opacity
	//var/list/oldvars = destination.vars.Copy()
	//
	var/datum/gas_mixture/old_air
	if(destination.air)
		old_air = new()
		old_air.copy_from(destination.air)
	. = 1
	//
	var/obj/machinery/overmap_vehicle/shuttle/shuttle
	if(istype(interior, /turf/simulated/shuttle/hull))
		var/turf/simulated/shuttle/hull/S = interior
		if(S.my_shuttle)
			shuttle = S.my_shuttle
	else if(istype(destination, /turf/simulated/shuttle/hull))
		var/turf/simulated/shuttle/hull/S = destination
		if(S.my_shuttle)
			shuttle = S.my_shuttle

	//remember the areas and swap them too
	var/area/destination_area = destination.loc
	var/area/interior_area = interior.loc

	//replace destination with interior
	var/turf/new_interior = destination.ChangeTurf(interior.type)

	//copy vars across
	/*for(var/V in new_interior.vars)
		if(!(V in list("type","loc","locs","vars", "parent", "parent_type","verbs","ckey","key","x","y","z","gender","contents")))
			new_interior.vars[V] = interior.vars[V]*/
	new_interior.set_dir(interior.dir)
	new_interior.icon_state = interior.icon_state
	new_interior.icon = interior.icon //Shuttle floors are in shuttle.dmi while the defaults are floors.dmi
	new_interior.overlays = interior.overlays.Copy()
	new_interior.underlays = interior.underlays.Copy()
	new_interior.opacity = interior.opacity

	//update areas
	if(destination_area)
		destination_area.contents -= new_interior
	if(interior_area)
		interior_area.contents += new_interior
	. = 2
	//
	var/turf/simulated/simulated_new_interior = new_interior
	if(istype(simulated_new_interior) && interior.air)
		simulated_new_interior.air = new()
		simulated_new_interior.air.copy_from(interior.air)
		air_master.mark_for_update(simulated_new_interior)
		. = 2.5

	//replace interior with destination
	var/turf/new_virtual = interior.ChangeTurf(old_type)
	new_virtual.set_dir(old_dir1)
	new_virtual.icon_state = old_icon_state1
	new_virtual.icon = old_icon1 //Shuttle floors are in shuttle.dmi while the defaults are floors.dmi
	new_virtual.overlays = old_overlays
	new_virtual.underlays = old_underlays
	new_virtual.opacity = old_opacity
	/*for(var/V in new_virtual.vars)
		if(!(V in list("type","loc","locs","vars", "parent", "parent_type","verbs","ckey","key","x","y","z","gender","contents")))
			new_virtual.vars[V] = oldvars.vars[V]*/
	if(interior_area)
		interior_area.contents -= new_virtual
	if(destination_area)
		destination_area.contents += new_virtual
	. = 3
	//
	var/turf/simulated/simulated_new_virtual = new_virtual
	if(istype(simulated_new_virtual))
		simulated_new_virtual.air = old_air
		air_master.mark_for_update(simulated_new_virtual)
		. = 3.5

	//remember the old turf contents
	var/list/old_contents = list()
	for(var/atom/movable/AM in new_virtual)
		if(istype(AM, /obj/effect/virtual_area))
			continue
		old_contents.Add(AM)

	//swap the turf contents
	for(var/atom/movable/AM in new_interior)
		if(istype(AM, /obj/effect/virtual_area))
			continue
		if(istype(AM, /obj/machinery/overmap_vehicle))
			continue
		if(istype(AM, /atom/movable/lighting_overlay))
			//qdel(AM)
			continue
		AM.loc = new_virtual
	//
	for(var/atom/movable/AM in old_contents)
		if(istype(AM, /obj/effect/virtual_area))
			continue
		if(istype(AM, /obj/machinery/overmap_vehicle))
			continue
		if(istype(AM, /atom/movable/lighting_overlay))
			//qdel(AM)
			continue
		AM.loc = new_interior

	. = 4

	//make sure the shuttle hull keeps track of us
	if(istype(new_interior, /turf/simulated/shuttle/hull))
		var/turf/simulated/shuttle/hull/S = new_interior
		S.my_shuttle = shuttle
	if(istype(new_virtual, /turf/simulated/shuttle/hull))
		var/turf/simulated/shuttle/hull/S = new_virtual
		S.my_shuttle = shuttle

	//grab an underlay of the old turf to prevent some visual glitches with sprite transparency
	if(leave_underlay)
		new_interior.underlays.Cut()
		new_interior.underlays += new_virtual

	. = 5

	//warning: there's some weird behaviour with lighting overlays, they seem to get moved around a little bit and stacking up on certain turfs
	//i should probably check what's happening there
