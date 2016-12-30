
/datum/hud_waypoint_controller/proc/add_waypoints(var/list/waypoints)
	for(var/datum/waypoint/waypoint in waypoints)
		add_waypoint(waypoint)

/datum/hud_waypoint_controller/proc/add_waypoint(var/datum/waypoint/new_waypoint)
	//world << "/datum/hud_waypoint_controller/proc/add_waypoint([new_waypoint], [new_waypoint.type])"

	var/datum/hud_waypoint/new_hud_waypoint = new hud_waypoint_type(owner, new_waypoint, owner_faction = my_faction)

	/*
	if(new_waypoint.source)
		world << "	new_waypoint.source:[new_waypoint.source] [new_waypoint.source.type]"
		world << "	src.owner:[src.owner] [src.owner.type]"
		*/

	new_hud_waypoint.add_viewmobs(mobs_tracking)
	all_hud_waypoints[new_waypoint] = new_hud_waypoint
	if(!new_waypoint.dont_update)
		hud_waypoints_updating.Add(new_hud_waypoint)

/datum/hud_waypoint_controller/proc/clear_waypoint(var/datum/waypoint/old_waypoint, var/remove_from_lists = 1)
	//check if we have it already
	var/datum/hud_waypoint/old_hud_waypoint = all_hud_waypoints[old_waypoint]
	if(old_hud_waypoint)
		//we do, so lets clear it
		old_hud_waypoint.remove_viewmobs(mobs_tracking)
		hud_waypoints_updating.Remove(old_hud_waypoint)

		if(remove_from_lists)
			all_hud_waypoints.Remove(old_waypoint)

		qdel(old_hud_waypoint)

		return 1

	return 0

/datum/hud_waypoint_controller/proc/clear_all_hud_waypoints(var/stop_listening = 0)
	for(var/entry in all_hud_waypoints)
		clear_waypoint(entry, 0)

	//waypoint_controller manages the waypoints themselves, so we just dont bother referencing them
	all_hud_waypoints = list()

	if(stop_listening)
		//remove ourselves as listeners so we dont get waypoints readded
		for(var/datum/waypoint_controller/waypoint_controller in waypoint_controllers)
			waypoint_controller.remove_listening_hud(src)
