/obj/vehicle_hud/autobrake
	name = "Enable Autobrake"
	icon_state = "stop"

/obj/vehicle_hud/autobrake/Click(location, control, params)
	my_vehicle.enable_autobrake()

/obj/vehicle_hud/autobrake/update_icon()
	if(my_vehicle.autobraking)
		icon_state = "stop_flash"
		name = "Disable Autobrake"
	else
		icon_state = "stop"
		name = "Enable Autobrake"

/obj/machinery/overmap_vehicle/proc/enable_autobrake()
	/*set name = "Enable Autobrake"
	set category = "Vehicle"
	set src = usr.loc*/

	if(is_cruising())
		usr << "\icon[src] <span class='warning'>You must exit cruise before you can enable autobraking.</span>"
	else if(!autobraking)
		autobraking = 1
		move_forward = 0
		//usr << "\icon[src] <span class='info'>Autobraking...</span>"
		autobrake_button.update_icon()
	else
		autobraking = 0
		autobrake_button.update_icon()
