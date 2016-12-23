//var/obj/structure/vehicle_component/vehicle_component
/obj/machinery/overmap_vehicle/proc/position_mount_hud(var/datum/vehicle_mount/vehicle_mount, var/hud_bar, var/index)
	//world << "	vehicle_mount.mount_type:[vehicle_mount.mount_type]"
	switch(hud_bar)
		if(HUD_BAR_TOP)
			vehicle_mount.screenpos_offsetx = client_screen_size * 2 - 3
			vehicle_mount.screenpos_offsety = client_screen_size * 2 - 1 - (index - 1) * 2

		if(HUD_BAR_LEFT)
			vehicle_mount.screenpos_offsetx = 0
			vehicle_mount.screenpos_offsety = (index - 1) * 2

		/*if(MOUNT_CREW)	//HUD_BAR_RIGHT
			vehicle_component.screenpos_offsetx = client_screen_size * 2 - index.len * 4
			vehicle_component.screenpos_offsety = client_screen_size * 2 - 1*/

	if(vehicle_mount.my_component)
		vehicle_mount.my_component.screenpos_offsetx = vehicle_mount.screenpos_offsetx
		vehicle_mount.my_component.screenpos_offsety = vehicle_mount.screenpos_offsety
	vehicle_mount.update_screen()
