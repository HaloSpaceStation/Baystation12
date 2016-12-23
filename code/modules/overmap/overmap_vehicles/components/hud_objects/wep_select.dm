
/obj/vehicle_hud/wep_select
	name = "Select component"
	panel_icon_state = "weapon"

/obj/vehicle_hud/wep_select/New()
	..()
	name = "Select [my_weapon.component_name]"
	icon_state = my_weapon.hud_icon_state

/obj/vehicle_hud/wep_select/Click(location,control,params)
	//world << "[src] [src.type] /obj/vehicle_hud/wep_select/Click()"
	//if we selected an individual weapon then show we have "broken up" a group selection
	if(my_vehicle.sole_selected_group)
		//world << "	check1"
		my_vehicle.sole_selected_group.screen_button.overlays -= "select_box"
		//my_vehicle.sole_selected_group.screen_button

		my_vehicle.sole_selected_group = null

	my_weapon.select_deselect()
