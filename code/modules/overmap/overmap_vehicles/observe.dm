
/obj/machinery/overmap_vehicle/proc/observe_space(var/mob/user)
	var/obj/effect/overmapobj/target_observing_from = overmap_object
	if(overmap_object.loc == src)
		//user << "<span class='warning'>Cannot observe space right now!</span>"
		target_observing_from = get_overmap_sector(src)
	target_observing_from.observe_space(user)
	if(user.client)
		user.client.view = client_screen_size

/obj/machinery/overmap_vehicle/cancel_camera(var/mob/user)
	//if the player is inside a fighter and calls cancel_camera() verb
	//this override will prevent them from losing control of the vehicle
	overmap_object.my_observers.Remove(user)
	if(!(user in my_observers))
		my_observers.Add(user)
	user.set_machine(src)
	user.reset_view(src, 0)

	if(overmap_object.hud_waypoint_controller.remove_hud_from_mob(user))
		hud_waypoint_controller.add_hud_to_mob(user)

	return 1//overmap_object.cancel_camera(user)

/obj/machinery/overmap_vehicle/check_eye(var/mob/user)
	//make sure we're updating their pixel offsets correctly
	if(user.loc == src)
		if(!(user in my_observers))
			my_observers.Add(user)

		if(user in overmap_object.my_observers)
			overmap_object.my_observers.Remove(user)

		if(user.client && user.client.eye != src)
			user.reset_view(src, 0)

		return 0

	//warning("[src] /obj/machinery/overmap_vehicle/check_eye([user]) reset view unexpectedly")
	return -1
