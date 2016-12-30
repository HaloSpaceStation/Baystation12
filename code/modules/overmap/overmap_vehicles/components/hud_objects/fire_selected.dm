
/obj/vehicle_hud/fire
	name = "Fire Selected Weapons"
	icon = 'code/modules/overmap/overmap_vehicles/icons/fire.dmi'
	icon_state = "button"

/obj/vehicle_hud/fire/Click(location,control,params)
	//my_vehicle.reset_bursts()

	if(my_vehicle.continue_firing)
		my_vehicle.continue_firing = 0
		icon_state = "button"
	else
		if(!my_vehicle.fire_control_mode)
			flick("button_fireonce", src)
			my_vehicle.fire_weapon(location, params)
		else
			icon_state = "button_fire"
			my_vehicle.continue_firing = world.time
			fire_loop(my_vehicle.continue_firing)

/obj/vehicle_hud/proc/fire_loop(var/start_time)
	set background = 1
	spawn(0)
		while(my_vehicle.continue_firing)
			if(my_vehicle.continue_firing != start_time)
				break

			my_vehicle.fire_weapon(reset_bursts = 0)
			sleep(1)
