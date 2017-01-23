
//this puts a waypoint in the center of the zlevel for the current sector
/datum/waypoint_controller/proc/set_current_sector(var/obj/effect/overmapobj/new_sector, var/entryz_number)

	//clear out old sector waypoint
	if(current_sector)
		var/datum/waypoint/old_waypoint = waypoints_by_source[current_sector]
		if(old_waypoint)
			waypoints_by_source.Remove(current_sector)
			all_waypoints.Remove(old_waypoint)

			for(var/datum/hud_waypoint_controller/hud_waypoint_controller in listening_huds)
				hud_waypoint_controller.clear_waypoint(old_waypoint)

			qdel(old_waypoint)

	current_sector = new_sector

	//don't bother creating a waypoint in the middle of the sector if we're in deepspace
	if(istype(new_sector, /obj/effect/overmapobj/temporary_sector))
		return

	var/datum/waypoint/sector/new_waypoint = new()
	new_waypoint.overmapobj = new_sector
	if(entryz_number)
		new_waypoint.coords_z = entryz_number
	else
		new_waypoint.coords_z = owner.z
	if(istype(new_sector, /obj/effect/overmapobj/asteroidsector))
		new_waypoint.sensor_icon_state = "asteroid"
		new_waypoint.colour_override = "#87CEEB"
	//
	all_waypoints.Add(new_waypoint)
	waypoints_by_source[new_sector] = new_waypoint
	for(var/datum/hud_waypoint_controller/hud_waypoint_controller in listening_huds)
		hud_waypoint_controller.add_waypoint(new_waypoint)
