
/obj/vehicle_hud/wep_dmg
	name = "Damage"
	icon_state = "cog_wrench"
	panel_icon_state = null

/obj/vehicle_hud/wep_dmg/Click(location,control,params)
	var/icon_frame = 1
	if(my_weapon.damage > 66)
		icon_frame = 3
	else if(my_weapon.damage > 33)
		icon_frame = 2
	var/icon_embed_text = "<IMG CLASS=icon SRC=\ref[src.icon] ICONSTATE='cog_wrench_colour' ICONFRAME=[icon_frame]>"
	usr << "\icon[my_vehicle] <span class='info'>[my_weapon] is: [my_weapon.damage]%[icon_embed_text] damaged and [my_weapon.damage >= 100 ? "non-functional" : "fully functional"]</span>"

/obj/vehicle_hud/wep_dmg/update_icon()
	if(my_weapon.damage <= 0)
		color = "#00ff00"
	else if(my_weapon.damage <= 25)
		color = "#ccee00"
	else if(my_weapon.damage <= 50)
		color = "#ffee00"
	else if(my_weapon.damage <= 75)
		color = "#ffaa00"
	else if(my_weapon.damage < 100)
		color = "#ff7700"
	else
		color = "#ff0000"
