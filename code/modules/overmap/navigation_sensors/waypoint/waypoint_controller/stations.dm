
/datum/waypoint_controller/proc/add_new_stations(var/list/stationlist)
	for(var/obj/effect/overmapobj/station in stationlist)
		add_new_station(station)

/datum/waypoint_controller/proc/add_new_station(var/obj/effect/overmapobj/station)

	/*
	//dont create a waypoint on ourself!
	if(station == owner)
		return
		*/

	var/datum/waypoint/new_waypoint = new()
	new_waypoint.overmapobj = station
	//
	all_waypoints.Add(new_waypoint)
	waypoints_by_source[station] = new_waypoint
	for(var/datum/hud_waypoint_controller/hud_waypoint_controller in listening_huds)
		hud_waypoint_controller.add_waypoint(new_waypoint)
