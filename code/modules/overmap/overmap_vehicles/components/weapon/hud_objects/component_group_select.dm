
/obj/vehicle_hud/select_component_group
	var/datum/component_group/my_component_group

/obj/vehicle_hud/select_component_group/New(var/obj/machinery/overmap_vehicle/overmap_vehicle, var/datum/component_group/component_group, var/group_num)

	name = "Select Weapon Group [group_num]"
	screen_loc = "5 + [group_num],1"
	my_component_group = component_group
	if(group_num == COMPONENT_GROUP_MIN)
		panel_icon_state = "weapon_left"
	else if(group_num == COMPONENT_GROUP_MAX)
		panel_icon_state = "weapon_right"
	else
		panel_icon_state = "weapon_centre"

	//not really necessary (that functionality could easily be here) but its nice practice
	..()

/obj/vehicle_hud/select_component_group/Click(location,control,params)
	//world << "[src] [src.type] /obj/vehicle_hud/select_component_group/Click()"
	//meh, lets make it cycle only one way for now
	//later maybe add right click to go backwards
	//var/list/paramslist = params2list(params)

	//deselect any currently activate components
	my_vehicle.deselect_all_components()
	var/selectme = 0
	if(my_vehicle.sole_selected_group)
		//world << "	check1"
		//this component group is the only one selected, so deselect it
		my_vehicle.sole_selected_group.screen_button.overlays -= "select_box"

		if(my_vehicle.sole_selected_group == my_component_group)
			my_vehicle.sole_selected_group = null
			//world << "	check2"
		else
			selectme = 1
			//world << "	check3"
	else
		selectme = 1
		//world << "	check4"

	if(selectme)

		//world << "	check5"
		//select this component group in the vehicle
		my_component_group.select()
		my_vehicle.sole_selected_group = my_component_group

		//show we selected this group only
		overlays |= "select_box"
/*
	var/datum/component_shortcut_group/cur_group = my_component.shortcut_group
	if(cur_group)
		my_component.shortcut_group = cur_group.next
	else
		if(!my_component.owned_vehicle)
			world << "WARNING: [usr] clicked on /obj/vehicle_hud/shortcut_group_cycle for a component without a vehicle!"
		my_component.shortcut_group = my_component.owned_vehicle.component_shortcut_groups[1]

	update_maptext()
*/
