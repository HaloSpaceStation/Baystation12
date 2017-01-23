
/datum/waypoint_controller/proc/add_new_ships(var/list/shiplist)
	for(var/obj/effect/overmapobj/ship/ship in shiplist)
		add_new_ship(ship)

/datum/waypoint_controller/proc/add_new_ship(var/obj/effect/overmapobj/ship/ship)

	//dont create a waypoint on ourself!
	if(ship == owner)
		return

	var/datum/waypoint/new_waypoint = new()
	new_waypoint.overmapobj = ship
	//
	all_waypoints.Add(new_waypoint)
	waypoints_by_source[ship] = new_waypoint
	for(var/datum/hud_waypoint_controller/hud_waypoint_controller in listening_huds)
		hud_waypoint_controller.add_waypoint(new_waypoint)
