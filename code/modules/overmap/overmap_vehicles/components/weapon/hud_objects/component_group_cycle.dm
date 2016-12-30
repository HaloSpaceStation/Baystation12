
/obj/vehicle_hud/cycle_component_group
	name = "Cycle Weapon Group"
	panel_icon_state = "weapon_centre"

/obj/vehicle_hud/cycle_component_group/Click(location,control,params)
	//meh, lets make it cycle only one way for now
	//later maybe add right click to go backwards
	//var/list/paramslist = params2list(params)

	var/datum/component_group/old_group = my_weapon.my_component_group

	var/datum/component_group/new_group
	if(old_group)
		old_group.linked_components -= my_weapon
		new_group = old_group.next
	else
		if(!my_weapon.owned_vehicle)
			world << "WARNING: [usr] clicked on /obj/vehicle_hud/shortcut_group_cycle for a component without a vehicle!"
		new_group = my_weapon.owned_vehicle.component_groups[1]

	my_weapon.my_component_group = new_group
	update_icon()
	if(new_group)
		new_group.linked_components += my_weapon
		usr << "\icon[my_vehicle]\icon[my_weapon] <span class='info'>[my_weapon.component_name] set to Weapon Group [new_group.group_number]</span>"
	else
		usr << "\icon[my_vehicle]\icon[my_weapon] <span class='info'>[my_weapon.component_name] removed from Weapon Groups</span>"

/obj/vehicle_hud/cycle_component_group/update_icon()
	if(my_weapon.my_component_group)
		src.maptext  = "<div style=\"[HUD_CSS_STYLE]color:[my_weapon.my_component_group.group_colour];\">[my_weapon.my_component_group.group_number]</div>"
	else
		src.maptext  = "<div style=\"[HUD_CSS_STYLE]\">- -</div>"
