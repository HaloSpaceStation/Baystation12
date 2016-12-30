
/datum/waypoint_controller/proc/add_new_asteroidfields(var/list/asteroidlist)
	for(var/datum/asteroidfield/asteroidfield in asteroidlist)
		add_new_asteroidfield(asteroidfield)

/datum/waypoint_controller/proc/add_new_asteroidfield(var/datum/asteroidfield/asteroidfield)

	var/datum/waypoint/asteroidfield/new_waypoint = new()

	//just use static coords because asteroid fields dont move
	new_waypoint.overmap_x = asteroidfield.centre_x
	new_waypoint.overmap_y = asteroidfield.centre_y
	//
	all_waypoints.Add(new_waypoint)
	waypoints_by_source[asteroidfield] = new_waypoint
	for(var/datum/hud_waypoint_controller/hud_waypoint_controller in listening_huds)
		hud_waypoint_controller.add_waypoint(new_waypoint)
