
/obj/effect/overmapobj/vehicle
	icon = 'code/modules/overmap/overmap_vehicles/icons/overmap_vehicles.dmi'
	animate_movement = 0
	var/obj/machinery/overmap_vehicle/overmap_vehicle
	layer = 3.1
	var/datum/pixel_transform/pixel_transform

/obj/effect/overmapobj/vehicle/New(var/obj/machinery/overmap_vehicle/my_vehicle)
	overmap_vehicle = my_vehicle

	pixel_transform = init_pixel_transform(src)
	//pixel_transform.my_observers = my_observers
	pixel_transform.heading = dir2angle(dir)
	pixel_transform.my_observers = my_observers
	//pixel_transform.max_pixel_speed = max_speed

	hud_waypoint_controller = new(src)
	hud_waypoint_controller.expected_screen_width = overmap_vehicle.client_screen_size
	waypoint_controller = new(src)
	waypoint_controller.add_listening_hud(hud_waypoint_controller)

	..()

/obj/effect/overmapobj/vehicle/initialize()
	overmap_controller.overmap_scanner_manager.add_ship_scanner(waypoint_controller)
	overmap_controller.overmap_scanner_manager.add_station_scanner(waypoint_controller)
	overmap_controller.overmap_scanner_manager.add_asteroid_scanner(waypoint_controller)
	overmap_controller.overmap_scanner_manager.add_overmap_vehicle_scanner(waypoint_controller)

/obj/effect/overmapobj/vehicle/observe_space(var/mob/user)
	//stop the vehicle from taking back control
	overmap_vehicle.my_observers.Remove(user)

	//regularly update the pixel offset
	my_observers.Add(user)

	//get mob/life code to check up on us periodically via check_eye(mob/user) to make sure everything is ok
	user.set_machine(src)

	//call it immediately to speed things up
	check_eye(user)

	//enable overmap sensors if the user has them enabled
	if(overmap_vehicle.hud_waypoint_controller.remove_hud_from_mob(user))
		hud_waypoint_controller.add_hud_to_mob(user)

/obj/effect/overmapobj/vehicle/check_eye(var/mob/user)
	//if the parent proc didn't succeed, check if the player is inside us (a vehicle)
	if(user && user in my_observers)
		if(user.client && user.client.eye != src)
			user.reset_view(src, 0)

		return 0

	warning("[src] /obj/effect/overmapobj/vehicle/check_eye([user]) reset view unexpectedly")
	return -1

/obj/effect/overmapobj/vehicle/cancel_camera(var/mob/user)
	return overmap_vehicle.cancel_camera(user)

/obj/effect/overmapobj/vehicle/relaymove(mob/user, direction)
	overmap_vehicle.relaymove(user, direction)

/obj/effect/overmapobj/vehicle/spawn_overmap_meteor()
	//very low chance for it to actually hit the fighter
	if(prob(5))
		overmap_vehicle.impact_occupants_major("\icon[src] <span class='warning'>You have been hit by a meteor!</span>")

		var/fulldamage = pick(10, 25, 50) * rand(5,10)
		overmap_vehicle.hull_remaining -= fulldamage / overmap_vehicle.armour
		overmap_vehicle.health_update()

//override in children
/obj/effect/overmapobj/vehicle/machineClickOn(var/atom/A, var/params)
	return overmap_vehicle.machineClickOn(A, params)
