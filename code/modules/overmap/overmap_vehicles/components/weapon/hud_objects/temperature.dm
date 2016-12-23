/obj/vehicle_hud/wep_temp
	name = "Temperature"
	panel_icon_state = null

/obj/vehicle_hud/wep_temp/Click(location,control,params)
	usr << "\icon[my_vehicle] <span class='info'>[my_weapon] temperature is: [my_weapon.heat+273]K\icon[src] and cooling at a rate of 10 degrees per second when not in use</span>"

/obj/vehicle_hud/wep_temp/update_icon()
	if(my_weapon.heat <= 16)
		icon_state = "heat0"
	else if(my_weapon.heat <= 32)
		icon_state = "heat1"
	else if(my_weapon.heat <= 48)
		icon_state = "heat2"
	else if(my_weapon.heat <= 64)
		icon_state = "heat3"
	else if(my_weapon.heat <= 80)
		icon_state = "heat4"
	else
		icon_state = "heat5"
