
/obj/machinery/overmap_vehicle/relaymove(mob/user, direction)
	if(user == pilot)
		vehicle_controls.relay_move(user, direction)
		autobraking = 0
		autobrake_button.update_icon()
	else
		user << "<span class='warning'>You are not the pilot of [src]!</span>"

/obj/machinery/overmap_vehicle/relayface(mob/user, direction)
	if(user == pilot)
		vehicle_controls.relay_face(user, direction)
	else
		user << "<span class='warning'>You are not the pilot of [src]!</span>"

/obj/machinery/overmap_vehicle/proc/thrust_forward(var/mob/user)
	if(user == pilot)
		vehicle_controls.move_vehicle_forward()
		autobraking = 0
		move_forward = 0
		autobrake_button.update_icon()
	else
		user << "<span class='warning'>You are not the pilot of [src]!</span>"

/obj/machinery/overmap_vehicle/proc/thrust_forward_toggle(var/mob/user)
	if(user == pilot)
		move_forward = !move_forward
		autobraking = 0
		autobrake_button.update_icon()
		update()
	else
		user << "<span class='warning'>You are not the pilot of [src]!</span>"

/obj/machinery/overmap_vehicle/proc/make_pilot(var/mob/living/H)
	if(pilot)
		if(pilot == H)
			H << "\icon[src] <span class='info'>You already control [src].</span>"
		else
			H << "\icon[src] <span class='info'>[src] is already being piloted by [pilot]</span>"
	else
		pilot = H
		usr << "\icon[src] <span class='info'>You are now the pilot!</span>"

		H.client.screen = list()				//remove hud items just in case
		if(H.hud_used)	qdel(H.hud_used)		//remove the hud objects
		//check if we're in a vehicle
		var/hudtype = /datum/hud
		if(H.machine && H.machine.hud_type)
			hudtype = H.machine.hud_type
		H.hud_used = new hudtype(H)
		return 1

/obj/machinery/overmap_vehicle/proc/clear_pilot(var/mob/living/H)
	if(pilot == H)
		pilot.unset_machine()
		hud_waypoint_controller.remove_hud_from_mob(pilot)
		overmap_object.hud_waypoint_controller.remove_hud_from_mob(pilot)

		pilot.client.screen = null				//remove hud items just in case
		pilot.client.images -= get_misc_hud_images()
		if(pilot.hud_used)	qdel(pilot.hud_used)		//remove the hud objects

		//reset the ordinary mob hud
		pilot.hud_used = new /datum/hud(pilot)
		pilot.update_hud()

		pilot = null
		pilot << "\icon[src] <span class='info'>You are no longer the pilot!</span>"
		return 1

/obj/machinery/overmap_vehicle/proc/get_absolute_directional_thrust(var/direction)
	//north = north on the map

	//if we're thrusting offcenter, reduce thrust proportionately
	/*
	var/angular_offset = abs(shortest_angle_to_dir(pixel_transform.heading, direction, 180))
	var/thrust_modifier = 1 - ((angular_offset + 45) / 225)		//minimum 25% speed
	*/

	var/thrust_modifier = 1
	var/ideal_angle = angle2dir(pixel_transform.heading)
	if(direction != ideal_angle)
		thrust_modifier = 0.25		//25% speed

	return thrust_modifier * get_relative_directional_thrust(direction)

/obj/machinery/overmap_vehicle/proc/get_relative_directional_thrust(var/direction)
	//north = front of the shuttle

	var/accel = max_speed
	/*if(hovering || no_grav())
		accel = thruster.rate
	else
		accel = wheels.rate*/
	accel /= accel_duration

	return accel

/obj/machinery/overmap_vehicle/proc/enable_engines()
	if(!engines_cycling)
		if(!engines_active)
			engines_cycling = 1

			//play sound for occupants
			for(var/mob/M in occupants)
				M.playsound_local_custom(M.loc, 'sound/machines/Spacecraft_Start_Engines_SE.ogg', 100, 1, 3, 5)

			//play sound for people nearby
			playsound_custom(src, 'sound/machines/Spacecraft_Start_Engines_SE.ogg', 100, 1, 3, 5)

			//5 second powerup sequence (15 sec played at 3x speed)
			spawn(50)
				engines_active = 1
				overmap_controller.overmap_scanner_manager.add_overmap_vehicle(overmap_object)
				engines_cycling = 0
			return 1

	return 0

/obj/machinery/overmap_vehicle/proc/disable_engines()
	if(!engines_cycling)
		if(engines_active)
			engines_cycling = 1

			//play sound for occupants
			for(var/mob/M in occupants)
				M.playsound_local_custom(M.loc, 'sound/machines/Spacecraft_Start_Engines_SE.ogg', 100, 1, -3, 5)

			//play sound for people nearby
			playsound_custom(src, 'sound/machines/Spacecraft_Start_Engines_SE.ogg', 100, 1, -3, 5)

			//5 second powerdown sequence (15 sec played at 3x speed)
			spawn(50)
				engines_active = 0
				overmap_controller.overmap_scanner_manager.remove_overmap_vehicle(overmap_object)
				engines_cycling = 0
				return 1

	return 0
