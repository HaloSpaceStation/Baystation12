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
