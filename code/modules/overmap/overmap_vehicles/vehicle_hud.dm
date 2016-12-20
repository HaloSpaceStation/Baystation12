/obj/machinery/var/hud_type

/datum/hud/vehicle
	refresh_contents = 0
	var/obj/machinery/overmap_vehicle/my_vehicle

/datum/hud/vehicle/instantiate()
	if(!ismob(mymob)) return 0
	if(!mymob.client) return 0

	/*
	var/ui_style = ui_style2icon(mymob.client.prefs.UI_style)
	var/ui_color = mymob.client.prefs.UI_style_color
	var/ui_alpha = mymob.client.prefs.UI_style_alpha
	*/

	src.adding = list()
	src.other = list()

	mymob.client.screen = list()

	my_vehicle = mymob.machine
	if(my_vehicle && istype(my_vehicle))
		//force_update_all()

		//loop over all weapons and get the hud components for them
		for(var/datum/vehicle_mount/vehicle_mount in my_vehicle.system_mounts)
			adding += vehicle_mount.get_hud_objects()
			//mounts automatically return the hub objects for anything mounted in them
			/*var/obj/structure/vehicle_component/vehicle_component = my_vehicle.system_mounts[vehicle_mount]
			if(vehicle_component)
				adding += vehicle_component.get_hud_objects()*/

		//setup weapon group select buttons
		for(var/datum/component_group/component_group in my_vehicle.component_groups)
			adding += component_group.screen_button

		//other hud elements not directly tied to a component or weapon
		adding += my_vehicle.get_misc_hud_objects()

		my_vehicle.hud_waypoint_controller.add_hud_to_mob(mymob)

	else
		world << "WARNING: attempted to create a vehicle hud for [usr] [usr.type] but they were not detected as piloting a vehicle!"

	mymob.client.screen += src.adding// + src.other
	mymob.client.images += my_vehicle.get_misc_hud_images()

	return
