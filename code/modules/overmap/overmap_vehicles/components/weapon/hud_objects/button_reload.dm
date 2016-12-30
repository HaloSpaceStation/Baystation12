
/obj/vehicle_hud/reload
	name = "Magazine"
	panel_icon_state = "weapon_left"

/obj/vehicle_hud/reload/Click(location,control,params)
	my_weapon.reload_weapon()

/obj/vehicle_hud/reload/update_icon()
	if(my_weapon.is_reloading)
		maptext = null
		icon_state = "reload"
	else if(my_weapon.mag > 0)
		maptext = "<div style=\"[HUD_CSS_STYLE]\">[my_weapon.mag]/[my_weapon.mag_size]</div>"
		icon_state = "blank"
	else
		maptext = null
		icon_state = "reload_needed"
