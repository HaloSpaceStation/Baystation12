
/obj/machinery/overmap_vehicle/proc/can_use(var/mob/M)
	if(M.stat || M.restrained() || M.lying || !istype(M, /mob/living))
		return 0
	for(var/turf/T in range(1, M))
		if(T in src.locs)
			return 1
	return 0

/obj/machinery/overmap_vehicle/attack_hand(var/mob/user as mob)
	ui_interact(user)

/obj/machinery/overmap_vehicle/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)

	if(!can_use(user))
		if(ui)
			ui.close()
		return

	var/data[0]

	data["fighter_name"] = src.name
	data["user"] = "\ref[user]"

	data["mount_strings"] = mount_strings
	data["mount_sizes"] = mount_sizes
	data["mount_types"] = mount_types

	data["comp_strings"] = comp_strings
	data["comp_status"] = comp_status
	data["comp_status_req"] = comp_status_req


	ui = nanomanager.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "fighter_maintenance.tmpl", "[src.name] Maintenance Panel", 675, 650)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/machinery/overmap_vehicle/MouseDrop_T(atom/dropping, mob/user)
	switch(dropping.type)
		if(/obj/structure/vehicle_component)
			world << "NYI"
			//var/obj/structure/vehicle_component/component = dropping
			//var/list/empty_mounts = list()

	return ..()

/obj/machinery/overmap_vehicle/proc/tool_component(var/obj/structure/vehicle_component/vehicle_component, var/install_type, var/install_direction, var/mob/user)
	world << "/obj/machinery/overmap_vehicle/proc/tool_component([vehicle_component.type] [vehicle_component], install_type:[install_type], install_direction:[install_direction], [user] [user.type])"

	var/obj/item/held_item = user.get_active_hand()
	if(!held_item)
		user << "<span class='notice'>Equip the correct tool first!</span>"
		return

	var/tool_install_type
	if(install_direction)
		tool_install_type = tool_uninstalls_types[held_item.type]
	else
		tool_install_type = tool_installs_types[held_item.type]

	world << "	tool_install_type:[tool_install_type]"
	if(tool_install_type & install_type)

		//tool pre-checks
		switch(held_item.type)
			if(/obj/item/weapon/weldingtool)
				var/obj/item/weapon/weldingtool/weldingtool = held_item
				if(!weldingtool.welding)
					user << "<span class='notice'>You must turn [weldingtool] on first.</span>"
					return
				else if(weldingtool.get_fuel() < 2.5)
					user << "<span class='notice'>You don't have enough fuel left in [weldingtool].</span>"
					return

			if(/obj/item/stack/cable_coil)
				var/obj/item/stack/cable_coil/cable_coil = held_item
				if(!cable_coil.can_use(2))
					user << "<span class='notice'>You don't have enough cabling left in [cable_coil].</span>"
					return

			if(/obj/item/weapon/crowbar)
				//var/obj/item/weapon/crowbar/crowbar = held_item
				if(vehicle_component.install_status)
					user << "\icon[vehicle_component] <span class='notice'>[vehicle_component] cannot be removed from \icon[src] [src] [vehicle_component.my_mount] mount yet.</span>"
					return

		///proc/do_after(var/mob/user as mob, delay as num, var/numticks = 5, var/needhand = 1)
		//take 3 seconds to finish the action
		user << "<span class='info'>You begin [tooltype_action_desc[held_item.type]] the [vehicle_component] [install_direction ? "from" : "into"] [src]...</span>"
		if(!do_after(user, 30))
			return

		//tool post checks
		switch(held_item.type)
			if(/obj/item/weapon/weldingtool)
				var/obj/item/weapon/weldingtool/weldingtool = held_item
				weldingtool.remove_fuel(2.5, user)
				playsound(user.loc, 'sound/items/Welder2.ogg', 50, 1)

				if(install_type == INSTALL_PIPED)
					new /obj/item/pipe(user.loc)

			if(/obj/item/stack/cable_coil)
				var/obj/item/stack/cable_coil/cable_coil = held_item
				cable_coil.use(2)
				playsound(user.loc, pick(spark_sound), 50, 1)

			if(/obj/item/pipe)
				//var/obj/item/pipe/pipe = held_item
				user.drop_from_inventory(held_item, src)
				qdel(held_item)
				playsound(user.loc, 'sound/items/Deconstruct.ogg', 50, 1)

			if(/obj/item/weapon/wirecutters)
				//var/obj/item/weapon/wirecutters/wirecutters = held_item
				new /obj/item/stack/cable_coil(user.loc, 2)
				playsound(user.loc, 'sound/items/Wirecutter.ogg', 50, 1)

			if(/obj/item/weapon/crowbar)
				//var/obj/item/weapon/crowbar/crowbar = held_item
				if(remove_component(vehicle_component))
					user << "<span class='info'>You successfully uninstall \icon[vehicle_component] [vehicle_component] from \icon[src] [src] [vehicle_component.my_mount] mount.</span>"
				else
					testing("ERROR: Failed to uninstall component from [src] [src.type], [usr] [usr.client]")

				playsound(user.loc, 'sound/items/Crowbar.ogg', 50, 1)
				//we just removed the component so return early
				return

			if(/obj/item/weapon/wrench)
				playsound(user.loc, 'sound/items/Ratchet.ogg', 50, 1)

			if(/obj/item/weapon/screwdriver)
				playsound(user.loc, 'sound/items/Screwdriver.ogg', 50, 1)
	else
		user << "<span class='notice'>That is the wrong kind of tool.</span>"
		return

	if(vehicle_component.install_requires & install_type)
		var/old_enabled = (vehicle_component.install_status == vehicle_component.install_requires ? 1 : 0)
		if(vehicle_component.install_status & install_type)
			vehicle_component.install_status &= ~install_type
		else
			vehicle_component.install_status |= install_type
		var/new_enabled = (vehicle_component.install_status == vehicle_component.install_requires ? 1 : 0)

		if(new_enabled && !old_enabled)
			//enable the component and hud
			vehicle_component.screenpos_offsetx = vehicle_component.my_mount.screenpos_offsetx
			vehicle_component.screenpos_offsety = vehicle_component.my_mount.screenpos_offsety
			vehicle_component.update_screen()
			vehicle_component.my_mount.screen_sysmount.my_weapon = vehicle_component

		else if(old_enabled && !new_enabled)
			//disable the component and hud
			vehicle_component.my_mount.screen_sysmount.my_weapon = null

			//clear the hud
			if(pilot && pilot.client)
				pilot.client.screen -= vehicle_component.get_hud_objects()
				pilot.client.screen -= vehicle_component.my_mount.get_hud_objects()

			//clear out any weapon groups
			if(vehicle_component.my_component_group)
				var/datum/component_group/old_group = vehicle_component.my_component_group
				old_group.linked_components -= vehicle_component
				vehicle_component.my_component_group = null

				if(vehicle_component:screen_cyclegroup)
					vehicle_component:screen_cyclegroup.update_icon()

		user << "<span class='info'>You successfully [get_tool_actionverb(install_type, install_direction)] [vehicle_component] \
			[install_direction ? "from" : "into"] [src].</span>"
		comp_status[vehicle_component.my_mount.mount_index] = vehicle_component.install_status
	else
		testing("ERROR: invalid install_type:[install_type] ([usr] [usr.client]) [src] ([src.x],[src.y],[src.z]) \
		/obj/machinery/overmap_vehicle/proc/tool_component([vehicle_component.type] [vehicle_component], \
		install_type:[install_type], install_direction:[install_direction], [user] [user.type])")

/obj/machinery/overmap_vehicle/proc/remove_component(var/obj/structure/vehicle_component/vehicle_component)
	var/datum/vehicle_mount/old_mount = vehicle_component.my_mount
	old_mount.my_component = null
	system_mounts[old_mount] = null

	comp_strings[old_mount.mount_index] = 0
	comp_status[old_mount.mount_index] = 0
	comp_status_req[old_mount.mount_index] = 0

	//eject the component
	vehicle_component.loc = src.loc
	return 1

/obj/machinery/overmap_vehicle/proc/add_component(var/obj/structure/vehicle_component/vehicle_component, var/datum/vehicle_mount/vehicle_mount, var/mob/user)
	user << "<span class='info'>You begin installing the [vehicle_component.component_name]...</span>"
	if(!do_after(user, 30))
		return

	system_mounts[vehicle_mount] = vehicle_component
	vehicle_mount.my_component = vehicle_component
	vehicle_component.my_mount = vehicle_mount
	vehicle_component.set_vehicle(src)

	comp_strings[vehicle_mount.mount_index] = vehicle_component.component_name
	comp_status[vehicle_mount.mount_index] = 0
	comp_status_req[vehicle_mount.mount_index] = vehicle_component.install_requires

	vehicle_component.loc = src

	playsound(src.loc, 'sound/items/Deconstruct.ogg', 50, 1)

	user << "<span class='info'>You successfully insert [vehicle_component.component_name] into the [vehicle_mount.name] mount. \
	The component is not yet fully installed however so check the dialog to see what still needs to be done.</span>"

	return 1
