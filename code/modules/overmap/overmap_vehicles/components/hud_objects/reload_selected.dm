
/obj/vehicle_hud/reload_selected
	name = "Reload Weapons"
	icon_state = "reload_needed"
	panel_icon_state = "weapon_right"
	var/im_reloading = 0

/obj/vehicle_hud/reload_selected/Click(location,control,params)

	//update the graphic only once every 6 seconds
	if(!im_reloading)
		usr << "\icon[my_vehicle] <span class='info'>Initiating vehicle weapon reload...</span>"
		icon_state = "reload"
		im_reloading = 1
		spawn(7)
			icon_state = "reload_needed"
			im_reloading = 0

	//reload all weapons as fast as we can click
	for(var/datum/vehicle_mount/mount in my_vehicle.system_mounts)
		var/obj/structure/vehicle_component/weapon/weapon = my_vehicle.system_mounts[mount]

		//blah why is this check necessary... fix it
		if(weapon && istype(weapon))
			weapon.reload_weapon(1)

/*
	if(!my_component.is_reloading && my_component.ammo_spare > 0 && my_component.mag < my_component.mag_size)
		usr << "\icon[my_component] <span class='info'>Reloading [my_component]...</span>"
		my_component.is_reloading = 1

		my_component.screen_mag.maptext = ""
		my_component.screen_mag.overlays -= "reload_needed"
		my_component.screen_mag.overlays += "reload"
		my_component.screen_mag_text.maptext = ""
		my_component.mag = 0	//so players cant shoot while reloading
		var/extra_ammo = my_component.mag

		spawn(my_component.reload_time * 10)
			my_component.screen_mag.overlays -= "reload"
			my_component.ammo_spare += extra_ammo
			var/new_mag = min(my_component.ammo_spare, my_component.mag_size)
			my_component.mag = new_mag
			my_component.ammo_spare -= new_mag
			update_maptext()
			if(my_component.mag < my_component.mag_size)
				my_component.screen_mag.overlays += "reload_needed"
			my_component.is_reloading = 0
*/