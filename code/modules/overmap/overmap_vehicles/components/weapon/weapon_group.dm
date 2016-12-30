/datum/component_group
	var/group_number = -1
	var/list/linked_components = list()
	var/datum/component_group/previous
	var/datum/component_group/next
	var/group_colour
	var/obj/vehicle_hud/select_component_group/screen_button
	var/obj/machinery/overmap_vehicle/my_vehicle
	var/sole_selected = 0

/datum/component_group/New(var/obj/machinery/overmap_vehicle/overmap_vehicle, var/group_num = COMPONENT_GROUP_MIN)
	my_vehicle = overmap_vehicle
	group_number = group_num
	switch(group_number)
		if(0)
			group_colour = "#8A2BE2"//BlueViolet//too dark
		if(1)
			group_colour = "#FF0000"//Red
		if(2)
			group_colour = "#33FF00"//Bright Green
		if(3)
			group_colour = "#FFA500"//Orange
		if(4)
			group_colour = "#00FFFF"//Cyan
		if(5)
			group_colour = "#FFFF00"//Yellow
		if(6)
			group_colour = "#DA70D6"//Orchid
		if(7)
			group_colour = ""
		if(8)
			group_colour = ""
		if(9)
			group_colour = ""
//obj/vehicle_hud/New(var/obj/machinery/overmap_vehicle/overmap_vehicle, var/obj/structure/vehicle_component/vehicle_component, var/datum/vehicle_mount/vehicle_mount)
	screen_button = new(my_vehicle, component_group = src, group_num = group_number)
	screen_button.maptext  = "<div style=\"[HUD_CSS_STYLE]color:[group_colour];\">[group_num]</div>"

/datum/component_group/proc/select()
	//world << "[src] [src.type] /datum/component_group/proc/select()"
	for(var/obj/structure/vehicle_component/vehicle_component in linked_components)
		//world << "	selecting [vehicle_component] [vehicle_component.type]"
		my_vehicle.selected_components |= vehicle_component
		vehicle_component.select()
