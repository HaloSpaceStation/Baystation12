
var/list/contents_to_ignore = list(\
/atom/movable/lighting_overlay,\
/obj/machinery/overmap_vehicle,\
/obj/effect/virtual_area,\
)

//used by shuttles and virtual areas
//i thought i'd make this a global seeing as it seems generically useful, ther's just a little bit of edge case handling i couldn't shake
//warning: make sure the stuff getting swapped can handle it in their logic! results might be unpredictable otherwise
//source and destination are arbitrary (i hope) it shouldn't matter which turf is which they only represent the order things are processed in the proc
/proc/swap_turfs(var/turf/source_turf, var/turf/destination_turf, var/leave_underlay = 0)
	. = 0

	//save a copy of destination's turf data
	//todo: there is an easier way to do this using var/list/vars
	var/old_destination_type = destination_turf.type
	var/old_destination_dir = destination_turf.dir
	var/old_destination_icon_state = destination_turf.icon_state
	var/old_destination_icon = destination_turf.icon
	var/old_destination_overlays = destination_turf.overlays.Copy()
	var/old_destination_underlays = destination_turf.underlays.Copy()
	var/old_destination_opacity = destination_turf.opacity
	//var/list/oldvars = destination.vars.Copy()
	//
	var/datum/gas_mixture/old_destination_air
	if(destination_turf.air)
		old_destination_air = new()
		old_destination_air.copy_from(destination_turf.air)
	. = 1
	//
	var/obj/machinery/overmap_vehicle/shuttle/shuttle
	if(istype(source_turf, /turf/simulated/shuttle/hull))
		var/turf/simulated/shuttle/hull/S = source_turf
		if(S.my_shuttle)
			shuttle = S.my_shuttle
	else if(istype(destination_turf, /turf/simulated/shuttle/hull))
		var/turf/simulated/shuttle/hull/S = destination_turf
		if(S.my_shuttle)
			shuttle = S.my_shuttle

	//remember the areas and swap them too
	var/area/destination_area = destination_turf.loc
	var/area/source_area = source_turf.loc



	//replace destination with source
	var/turf/new_destination_turf = destination_turf.ChangeTurf(source_turf.type)

	//copy vars across
	/*for(var/V in new_interior.vars)
		if(!(V in list("type","loc","locs","vars", "parent", "parent_type","verbs","ckey","key","x","y","z","gender","contents")))
			new_interior.vars[V] = interior.vars[V]*/
	new_destination_turf.set_dir(source_turf.dir)
	new_destination_turf.icon_state = source_turf.icon_state
	new_destination_turf.icon = source_turf.icon //Shuttle floors are in shuttle.dmi while the defaults are floors.dmi
	new_destination_turf.overlays = source_turf.overlays.Copy()
	new_destination_turf.underlays = source_turf.underlays.Copy()
	new_destination_turf.opacity = source_turf.opacity

	//update areas
	if(destination_area)
		destination_area.contents -= new_destination_turf
	if(source_area)
		source_area.contents += new_destination_turf
	. = 2
	//
	var/turf/simulated/new_destination_turf_simulated = new_destination_turf
	if(istype(new_destination_turf_simulated) && source_turf.air)
		new_destination_turf_simulated.air = new()
		new_destination_turf_simulated.air.copy_from(source_turf.air)
		air_master.mark_for_update(new_destination_turf_simulated)
		. = 2.5



	//replace source with destination
	var/turf/new_source_turf = source_turf.ChangeTurf(old_destination_type)
	new_source_turf.set_dir(old_destination_dir)
	new_source_turf.icon_state = old_destination_icon_state
	new_source_turf.icon = old_destination_icon //Shuttle floors are in shuttle.dmi while the defaults are floors.dmi
	new_source_turf.overlays = old_destination_overlays
	new_source_turf.underlays = old_destination_underlays
	new_source_turf.opacity = old_destination_opacity
	/*for(var/V in new_virtual.vars)
		if(!(V in list("type","loc","locs","vars", "parent", "parent_type","verbs","ckey","key","x","y","z","gender","contents")))
			new_virtual.vars[V] = oldvars.vars[V]*/
	if(source_area)
		source_area.contents -= new_source_turf
	if(destination_area)
		destination_area.contents += new_source_turf
	. = 3
	//
	var/turf/simulated/new_source_turf_simulated = new_source_turf
	if(istype(new_source_turf_simulated) && old_destination_air)
		new_source_turf_simulated.air = old_destination_air
		air_master.mark_for_update(new_source_turf_simulated)
		. = 3.5



	//remember the old turf contents
	var/list/old_contents = list()
	for(var/atom/movable/AM in new_source_turf)
		if(is_type_in_list(AM, contents_to_ignore))
			continue
		//multi-tile airlock hopping bug fix
		if(AM.loc != new_source_turf)
			continue
		old_contents.Add(AM)

	//swap the turf contents
	for(var/atom/movable/AM in new_destination_turf)
		if(is_type_in_list(AM, contents_to_ignore))
			continue
		//multi-tile airlock hopping bug fix
		if(AM.loc != new_destination_turf)
			continue
		AM.loc = new_source_turf
	//
	for(var/atom/movable/AM in old_contents)
		if(is_type_in_list(AM, contents_to_ignore))
			continue
		AM.loc = new_destination_turf

	. = 4

	//make sure the shuttle hull keeps track of us
	if(istype(new_source_turf, /turf/simulated/shuttle/hull))
		var/turf/simulated/shuttle/hull/S = new_source_turf
		S.my_shuttle = shuttle
	if(istype(new_destination_turf, /turf/simulated/shuttle/hull))
		var/turf/simulated/shuttle/hull/S = new_destination_turf
		S.my_shuttle = shuttle

	//grab an underlay of the old turf to prevent some visual glitches with sprite transparency
	if(leave_underlay)
		new_destination_turf.underlays.Cut()
		new_destination_turf.underlays += new_source_turf

	. = 5

	//warning: there's some weird behaviour with lighting overlays, they seem to get moved around a little bit and stacking up on certain turfs
	//i should probably check what's happening there
