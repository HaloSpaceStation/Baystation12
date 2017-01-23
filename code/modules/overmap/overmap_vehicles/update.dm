
/obj/machinery/overmap_vehicle/process()

	if(z_move)
		//quick and dirty delay, this should trigger on the second process() loop after pressing the button
		z_move *= 2
		if(z_move * z_move >= 8)
			var/target_dir = z_move
			spawn(0)
				handle_zmove(target_dir)
			z_move = 0

	/*var/delta_time = world.time - time_last_process
	time_last_process = world.time*/

	//if(hovering)
		//check fuel

	//if(move_dir from gravity turfs to nongravity turfs)
	//	lose control unless we have space capable thrusters

	//if(move_dir from nongravity turfs to nongravity turfs)
		//if(check to see if we fall 1 or more zlevels)
			//move down zlevels
			//take falling damage when we eventually hit
			//unless it's space, in which case transfer to overmap and start drifting away from the ship
		//else if(if we are stationary)
			//just settle nice and gently onto the ground

		//if(abs(O.pixel_speed_x) + abs(O.pixel_speed_y) <= 32)

/obj/machinery/overmap_vehicle/proc/update(var/my_update_start_time = -1)

	if(!src || !src.loc)
		main_update_start_time = -1
		return

	if(main_update_start_time < 0)
		my_update_start_time = world.time
		main_update_start_time = world.time
	else if(my_update_start_time != main_update_start_time)
		return

	var/continue_update = 0

	//apply thrust if we've got it toggled on
	if(handle_auto_moving())
		continue_update = 1

	//if we are cruising, force auto-accelerate forwards
	if(handle_auto_cruising())
		continue_update = 1

	//if the player wants us to automatically orient to face a direction
	if(handle_auto_turning())
		continue_update = 1

	//apply brake otherwise
	if(autobraking)
		if(pixel_transform.is_still())
			autobraking = 0
		else
			pixel_transform.brake(get_relative_directional_thrust(NORTH))
			continue_update = 1

	//update the sprite
	if(pixel_transform.update(update_interval))
		continue_update = 1

	//only spawn another update if there's something that needs updating
	if(continue_update)
		spawn(update_interval)
			update(my_update_start_time)
	else
		main_update_start_time = -1
