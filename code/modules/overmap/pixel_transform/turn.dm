
/datum/pixel_transform/proc/turn_to_dir(var/target_dir, var/max_degrees)

	//world << "turn_to_dir([target_dir])"

	//proc/shortest_angle_to_dir(var/current_heading, var/target_dir, var/max_angle)
	var/rotate_angle = shortest_angle_to_dir(heading, target_dir, max_degrees)
	var/new_heading = heading + rotate_angle

	//world << "rotate_angle:[rotate_angle]"

	//world << "rotating [max_degrees] degrees from heading [heading] ([angle2dir(heading)]) to face heading [target_heading] ([angle2dir(target_heading)])"

	var/old_heading = heading

	//change the heading
	heading = new_heading
	while(heading >= 360)
		heading -= 360
	while(heading < 0)
		heading += 360

	//return the number of degrees travelled as a clockwise value
	var/degrees_travelled = new_heading - old_heading
	/*while(degrees_travelled < 0)
		degrees_travelled += 360*/

	//rotate the sprite
	if(control_object)

		var/matrix/M = matrix()
		M.Turn(heading)
		control_object.transform = M

		/*var/icon/I = new(icon_base, icon_state)
		I.Turn(heading)
		control_object.icon = I
		if(overlay_thrust_base && world.time - last_thrust <= 4)
			control_object.overlays.Remove(overlay_thrust)
			overlay_thrust = new(overlay_thrust_base)
			overlay_thrust.Turn(heading)
			control_object.overlays.Add(overlay_thrust)*/

		if(my_overmap_object)
			my_overmap_object.transform = M
			/*var/icon/C = new(overmap_icon_base, overmap_icon_state)
			C.Turn(heading)
			my_overmap_object.icon = C*/

	return degrees_travelled
