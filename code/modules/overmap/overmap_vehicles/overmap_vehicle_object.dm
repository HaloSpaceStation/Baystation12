
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

/obj/effect/overmapobj/vehicle/spawn_overmap_meteor()
	//very low chance for it to actually hit the fighter
	if(prob(5))
		var/fulldamage = pick(10, 25, 50) * rand(5,10)
		overmap_vehicle.hull_remaining -= fulldamage / overmap_vehicle.armour
		overmap_vehicle.health_update()

		//shake camera around!
		spawn(0)
			for(var/mob/M in overmap_vehicle.crew)
				M.playsound_local(null, get_sfx("explosion"), 100, 1, get_rand_frequency(), falloff = 5)
				shake_camera(M, 5, 5)
