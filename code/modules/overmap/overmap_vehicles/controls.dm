
/obj/machinery/overmap_vehicle/relaymove(mob/user, direction)
	if(user == pilot)
		vehicle_controls.relay_move(user, direction)
		autobraking = 0
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
	else
		user << "<span class='warning'>You are not the pilot of [src]!</span>"

/obj/machinery/overmap_vehicle/proc/thrust_forward_toggle(var/mob/user)
	if(user == pilot)
		move_forward = !move_forward
		autobraking = 0
		update()
	else
		user << "<span class='warning'>You are not the pilot of [src]!</span>"

/obj/machinery/overmap_vehicle/proc/make_pilot(var/mob/living/H)
	if(pilot && pilot.machine == src)
		if(pilot == H)
			H << "\icon[src] <span class='info'>You already control [src].</span>"
		else
			H << "\icon[src] <span class='info'>[src] is already being piloted by [pilot]</span>"
	else
		pilot = H
		usr << "\icon[src] <span class='info'>You are now the pilot!</span>"
		hud_waypoint_controller.add_hud_to_mob(H)
		enable_engines()

/obj/machinery/overmap_vehicle/proc/get_absolute_directional_thrust(var/direction)
	//north = north on the map

	return get_relative_directional_thrust(direction)

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
	if(!engines_active)
		engines_active = 1
		overmap_controller.overmap_scanner_manager.add_overmap_vehicle(overmap_object)
		return 1

	return 0

/obj/machinery/overmap_vehicle/proc/disable_engines()
	if(engines_active)
		engines_active = 0
		overmap_controller.overmap_scanner_manager.remove_overmap_vehicle(overmap_object)
		return 1

	return 0
