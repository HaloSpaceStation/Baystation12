
/obj/machinery/overmap_vehicle/proc/component_init(var/mount_type, var/component_type)

	//todo: handle empty mounts
	//world << "/obj/machinery/overmap_vehicle/proc/init_component([mount_type], [component_type])"

	//create the mount point
	var/datum/vehicle_mount/vehicle_mount = new mount_type(src)
	vehicle_mount.mount_index = system_mounts.len + 1
	mount_strings.Add(vehicle_mount.name)
	mount_types.Add(vehicle_mount.mount_type)
	mount_sizes.Add(vehicle_mount.mount_size)

	//create this as one of our spawning weapons
	var/obj/structure/vehicle_component/vehicle_component
	if(component_type)
		vehicle_component = new component_type(src, vehicle_mount)
		vehicle_mount.set_vehicle_component(vehicle_component)
		//vehicle_component.mount_index = vehicle_mount.mount_index
		vehicle_component.install_status = vehicle_component.install_requires
		comp_strings.Add(vehicle_component.component_name)
		comp_status.Add(vehicle_component.install_requires)
		comp_status_req.Add(vehicle_component.install_requires)
	else
		comp_strings.Add(0)
		comp_status.Add(0)
		comp_status_req.Add(0)

	system_mounts[vehicle_mount] = vehicle_component

	switch(vehicle_mount.mount_type)
		if(MOUNT_INT)
			hud_bar_top.Add(vehicle_mount)
			position_mount_hud(vehicle_mount, HUD_BAR_TOP, hud_bar_top.len)

		if(MOUNT_EXT)
			hud_bar_left.Add(vehicle_mount)
			position_mount_hud(vehicle_mount, HUD_BAR_LEFT, hud_bar_left.len)

		/*if(MOUNT_CREW)
			crew_bar.Add(vehicle_component)
			position_component(vehicle_component, crew_bar.len)*/
