
/obj/vehicle_hud/firemode
	name = "Cycle firemode"
	panel_icon_state = "weapon_right"

/obj/vehicle_hud/firemode/Click(location,control,params)
	//only do stuff if there is more than 1 firemode to choose from
	if(my_weapon.cycle_firemode())
		update_icon()
		usr << "\icon[my_vehicle]\icon[my_weapon] <span class='info'>[my_weapon] fire mode set to: [my_weapon.get_firemode_name()]</span>"

/obj/vehicle_hud/firemode/update_icon()
	src.maptext  = "<div style=\"[HUD_CSS_STYLE]\">[my_weapon.get_firemode_maptext()]</div>"
