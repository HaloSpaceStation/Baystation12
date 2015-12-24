
/obj/effect/overmapobj/vehicle
	icon = 'code/modules/overmap/overmap_vehicles/overmap_vehicles.dmi'
	animate_movement = 0
	var/obj/machinery/overmap_vehicle/overmap_vehicle
	layer = 3.1

/obj/effect/overmapobj/vehicle/observe_space(var/mob/user)
	if(user.machine != overmap_vehicle)
		user.set_machine(src)
	my_observers.Add(user)
	check_eye(user)

/obj/effect/overmapobj/vehicle/check_eye(var/mob/user)
	//if the parent proc didn't succeed, check if the player is inside us (a vehicle)
	if(user && user.client && user in my_observers)
		if(user.client && user.client.eye != src)
			user.reset_view(src, 0)
			my_observers.Remove(user)		//so we can avoid doubleups
			my_observers.Add(user)
			user.client.perspective = EYE_PERSPECTIVE

		return 0

	return ..()
