
/obj/vehicle_hud/ammo
	name = "Ammunition"
	panel_icon_state = "weapon_centre"

/obj/vehicle_hud/ammo/Click(location,control,params)
	usr << "\icon[my_vehicle]\icon[my_weapon] <span class='info'>[my_weapon] has: [my_weapon.ammo_spare] spare [my_weapon.ammo_name] in reserve.</span>"

/obj/vehicle_hud/ammo/update_icon()
	maptext = "<div style=\"[HUD_CSS_STYLE]\">[my_weapon.ammo_spare]</div>"
