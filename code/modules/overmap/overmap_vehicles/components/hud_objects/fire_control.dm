
/obj/vehicle_hud/firecontrolmode
	name = "Fire Control Mode Toggle"
	icon_state = "bullet_single"
	panel_icon_state = "weapon_left"
	var/state_overlay
	var/obj/vehicle_hud/fire/fire_button

/obj/vehicle_hud/firecontrolmode/Click(location,control,params)
	my_vehicle.fire_control_mode = !my_vehicle.fire_control_mode
	if(my_vehicle.fire_control_mode)
		icon_state = "bullet_multi"
	else
		icon_state = "bullet_single"

		//if we're in a fire loop, stop it now
		my_vehicle.continue_firing = 0
		fire_button.icon_state = "button"

	usr << "\icon[my_vehicle] <span class='info'>Fire control set to [get_mode_string()] mode</span>"

/obj/vehicle_hud/firecontrolmode/proc/get_mode_string()
	if(my_vehicle.fire_control_mode)
		return "continuous fire"
	else
		return "single fire"
