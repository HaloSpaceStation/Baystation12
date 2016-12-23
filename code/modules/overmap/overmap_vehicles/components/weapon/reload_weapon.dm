
/obj/structure/vehicle_component/weapon/proc/reload_weapon(var/silent = 0)

	if(!is_reloading && mag < mag_size && ammo_spare > 0)
		is_reloading = 1
		if(!silent)
			usr << "\icon[owned_vehicle] \icon[src] <span class='info'>Reloading [src]...</span>"


		//update the hud
		screen_mag.update_icon()

		mag = 0	//so players cant shoot while reloading
		var/extra_ammo = mag

		reset_burst()

		spawn(reload_time * 10)
			ammo_spare += extra_ammo
			var/new_mag = min(ammo_spare, mag_size)
			mag = new_mag
			ammo_spare -= new_mag
			is_reloading = 0

			screen_ammo.update_icon()
			screen_mag.update_icon()
