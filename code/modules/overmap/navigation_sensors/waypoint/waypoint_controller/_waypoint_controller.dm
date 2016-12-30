
/datum/waypoint_controller
	var/list/all_waypoints = list()
	var/list/waypoints_by_source = list()
	//var/list/waypoints_visible = list()
	//var/list/waypoints_hidden = list()
	/*var/list/tracked_vehicles = list()
	var/list/tracked_ships = list()
	var/list/tracked_environment = list()
	var/list/tracked_nav = list()*/
	//
	//
	var/atom/movable/owner
	var/obj/effect/overmapobj/current_sector
	var/atom/movable/sector_source
	var/obj/effect/zlevelinfo/curz
	var/update_delay = 0
	var/time_next_update = 0

	var/list/listening_huds = list()

	//var/scanfor = 0
	//var/overmap_range = 1

/datum/waypoint_controller/New(var/atom/movable/myowner)
	owner = myowner
	processing_objects.Add(src)

/datum/waypoint_controller/proc/add_listening_hud(var/datum/hud_waypoint_controller/hud_waypoint_controller)
	listening_huds.Add(hud_waypoint_controller)
	hud_waypoint_controller.waypoint_controllers.Add(src)
	hud_waypoint_controller.add_waypoints(all_waypoints)

/datum/waypoint_controller/proc/remove_listening_hud(var/datum/hud_waypoint_controller/hud_waypoint_controller)
	listening_huds.Remove(hud_waypoint_controller)

/*
/datum/waypoint_controller/proc/get_waypoints()
	return all_waypoints
	*/

/datum/waypoint_controller/proc/process()
	if(world.time > time_next_update)
		time_next_update = world.time + update_delay

		//update_waypoints_visiblity()
		//locate_new_waypoints()

/*/datum/waypoint_controller/proc/update_waypoints_visiblity()
	var/list/new_waypoints_visible = list()
	var/list/new_waypoints_hidden = list()

	for(var/datum/waypoint/waypoint in waypoints_visible)
		if(get_waypoint_visiblity(waypoint))
			new_waypoints_visible.Add(waypoint)
		else
			new_waypoints_hidden.Add(waypoint)

	for(var/datum/waypoint/waypoint in waypoints_hidden)
		if(get_waypoint_visiblity(waypoint))
			new_waypoints_visible.Add(waypoint)
		else
			new_waypoints_hidden.Add(waypoint)

	waypoints_visible = new_waypoints_visible
	waypoints_hidden = new_waypoints_hidden*/

/*/datum/waypoint_controller/proc/get_waypoint_visiblity(var/datum/waypoint/waypoint)
	//check if we're in the same sector
	if(waypoint.curobj.loc != current_sector.loc)
		//check if it's in range
		if(get_dist(waypoint.curobj, current_sector) > overmap_range)
			return 0

	//custom detectability checks depending on type
	if(!check_waypoint_detectable(waypoint))
		return 0

	return 1*/

/*
/datum/waypoint_controller/proc/check_waypoint_detectable(var/datum/waypoint/waypoint)
	//override in children
	return 1
	*/
/*
/datum/waypoint_controller/proc/locate_new_waypoints()
	//override in children
	*/

/*
/datum/waypoint_controller/proc/enter_new_sector(var/obj/effect/overmapobj/newsector)
*/

/*
/datum/waypoint_controller/proc/start_tracking_vehicle(var/obj/machinery/overmap_vehicle/V)
	var/datum/hud_waypoint/S = PoolOrNew(/datum/hud_waypoint)
	/*S.my_faction = iff_faction_broadcast
	S.object_faction = V.iff_faction_broadcast
	S.use_faction_colours = iff_faction_colours*/
	S.create_images(object_icon_state = V.sensor_icon_state, S.get_colour(my_faction, use_faction_colours))

	//make sure all observing mobs have the image
	for(var/mob/M in mobs_tracking)
		S.add_viewmob(M)

	all_hud_waypoints.Add(S)
	tracked_vehicles[V] = S
	V.tracking_hud_controllers.Add(src)
*/

/*
/datum/waypoint_controller/proc/stop_tracking_vehicle(var/obj/machinery/overmap_vehicle/V)
	var/datum/hud_waypoint/S = tracked_vehicles[V]
	for(var/mob/M in mobs_tracking)
		S.remove_viewmob(M)

	tracked_vehicles[V] = null
	tracked_vehicles -= V
	all_hud_waypoints -= S

	PlaceInPool(S)
*/

/datum/waypoint_controller/proc/clear_all_waypoints()

	for(var/datum/waypoint/waypoint in all_waypoints)
		for(var/datum/hud_waypoint_controller/hud_waypoint_controller in listening_huds)
			hud_waypoint_controller.clear_waypoint(waypoint)
		qdel(waypoint)
	all_waypoints = list()

	for(var/entry in waypoints_by_source)
		waypoints_by_source.Remove(entry)
	waypoints_by_source = list()

/datum/waypoint_controller/Destroy()
	. = ..()
	processing_objects.Remove(src)

	clear_all_waypoints()
