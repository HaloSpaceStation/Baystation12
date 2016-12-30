
/datum/hud_waypoint_controller
	var/list/all_hud_waypoints = list()				//indexed by waypoint
	var/list/hud_waypoints_updating = list()
	//var/list/hudwaypoints_by_waypoint = list()
	//
	var/list/mobs_tracking = list()
	var/expected_screen_width = 7
	//
	var/list/waypoint_controllers = list()
	//
	var/my_faction
	var/use_faction_colours = 1
	var/hud_waypoint_type = /datum/hud_waypoint
	//
	//var/atom/movable/interface				//what mobs interact with to enable this HUD
	//var/obj/effect/overmapobj/cursector				//the sector that the interface is located in

	var/atom/movable/owner
	//
	var/time_next_update = 0
	var/update_delay = 0

	var/use_megamap = 0

	var/list/trackable_types_strings = list(
		/obj/machinery/overmap_vehicle = "Fighter/Shuttle craft",
		/obj/effect/overmapobj/ship = "Capital ship class",
		/datum/hud_waypoint = "Navigation Waypoints",		//misc or anomalous, todo: this wont work
		/obj/effect/overmapobj = "System objects",			//asteroids, planets etc
		//todo: space stations/satellites etc
	)

/datum/hud_waypoint_controller/New(var/atom/movable/myowner)
	owner = myowner
	processing_objects.Add(src)

/datum/hud_waypoint_controller/proc/process()
	//dont bother updating if we dont have any viewers
	if(mobs_tracking.len)
		if(world.time >= time_next_update)
			time_next_update = world.time + update_delay
			update_overlays()

/datum/hud_waypoint_controller/proc/update_overlays()
	//update hud overlays for waypoints
	if(use_megamap)
		for(var/datum/hud_waypoint/hud_waypoint in hud_waypoints_updating)
			hud_waypoint.update_overlay_megamap(expected_screen_width)
	else
		for(var/datum/hud_waypoint/hud_waypoint in hud_waypoints_updating)
			hud_waypoint.update_overlay(expected_screen_width)

/datum/hud_waypoint_controller/proc/add_hud_to_mob(var/mob/M)
	mobs_tracking |= M
	//world << "/datum/hud_waypoint_controller/proc/add_hud_to_mob([M] [M.type])"
	//world << "	all_hud_waypoints.len:[all_hud_waypoints.len]"

	for(var/entry in all_hud_waypoints)
		var/datum/hud_waypoint/hud_waypoint = all_hud_waypoints[entry]
		//var/datum/hud_waypoint/entry_wp = entry
		//world << "		[entry_wp] [entry_wp:type] : [hud_waypoint] [hud_waypoint.type]"
		hud_waypoint.add_viewmob(M)

/datum/hud_waypoint_controller/proc/remove_hud_from_mob(var/mob/M)
	var/success = mobs_tracking.Remove(M)
	if(success)
		for(var/entry in all_hud_waypoints)
			var/datum/hud_waypoint/hud_waypoint = all_hud_waypoints[entry]
			hud_waypoint.remove_viewmob(M)

	return success

/datum/hud_waypoint_controller/proc/cycle_iff_colours()
	use_faction_colours = !use_faction_colours

	for(var/entry in all_hud_waypoints)
		var/datum/hud_waypoint/hud_waypoint = all_hud_waypoints[entry]
	//for(var/obj/machinery/overmap_vehicle/V in tracked_vehicles)
		hud_waypoint.update_colour(my_faction, use_faction_colours)

	//reset all tracking images
	/*var/list/checked_vehicles = list()
	for(var/obj/machinery/overmap_vehicle/V in tracked_vehicles)
		stop_tracking_vehicle(V)
		checked_vehicles.Add(V)
	for(var/obj/machinery/overmap_vehicle/V in checked_vehicles)
		start_tracking_vehicle(V)*/

	var/status_text
	if(use_faction_colours)
		status_text = "\icon[src] Identify friend/foe sensor colours cycled to <span class='info'>FACTION</span> colours"
	else
		status_text = "\icon[src] Identify friend/foe sensor colours cycled to <span class='info'>FRIEND/FOE</span> colours"
	return status_text

/datum/hud_waypoint_controller/Destroy()
	. = ..()
	processing_objects.Remove(src)
	clear_all_hud_waypoints(1)

/datum/hud_waypoint_controller/proc/cycle_sensor_mode()
	use_megamap = !use_megamap
	for(var/entry in all_hud_waypoints)
		var/datum/hud_waypoint/hud_waypoint = all_hud_waypoints[entry]
		hud_waypoint.hud_object.set_megamap_mode(use_megamap)
