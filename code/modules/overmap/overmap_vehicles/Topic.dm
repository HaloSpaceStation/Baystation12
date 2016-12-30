
#define INSTALL_WELDED 1
#define INSTALL_CABLED 2
#define INSTALL_BOLTED 4
#define INSTALL_SCREWED 8
#define INSTALL_PIPED 16

/obj/machinery/overmap_vehicle/Topic(href, href_list)

/*
	var/list/mount_strings = list()
	var/list/comp_strings = list()
	var/list/comp_status = list()
	var/list/comp_status_req = list()
	*/

	if (href_list["search"])
		var/mount_index = text2num(href_list["mount_index"]) + 1
		var/datum/vehicle_mount/system_mount = system_mounts[mount_index]
		var/obj/structure/vehicle_component/vehicle_component = system_mount.my_component
		var/mob/user = locate(href_list["user"])
		var/out_text = "<span class='info'>This is a [system_mount.name] \
			([system_mount.name_abbr], \
			[vehicle_component_type_string(system_mount.mount_type)], \
			[vehicle_component_size_string(system_mount.mount_size)]) slot.</span>"
		if(vehicle_component)
			var/list/req_action_strings = list()
			for(var/action_desc in action_desc_tool)
				var/action_type = action_desc_tool[action_desc]
				if(action_type & vehicle_component.install_requires)
					if(!(action_type & vehicle_component.install_status))
						req_action_strings += action_desc
			var/req_action_phrase = "is"
			if(req_action_strings.len)
				req_action_phrase = "requires <span class='warning'>[english_list(req_action_strings)]</span> to be"
			out_text += " Installed here is \icon[vehicle_component] [vehicle_component]. \
				It is [vehicle_component.damage]% damaged \
				and [req_action_phrase] fully installed."
		else
			out_text += " There is currently nothing installed in it."

		user << out_text

	if (href_list["tool"])
		var/mount_index = text2num(href_list["mount_index"]) + 1
		var/tool_name = href_list["tool"]
		var/datum/vehicle_mount/system_mount = system_mounts[mount_index]
		var/obj/structure/vehicle_component/vehicle_component = system_mount.my_component
		var/install_direction = text2num(href_list["install_direction"])
		var/mob/user = locate(href_list["user"])

		var/install_type = 0
		if(install_direction)
			install_type = tool_uninstalls[tool_name]
		else
			install_type = tool_installs[tool_name]

		tool_component(vehicle_component, install_type, install_direction, user)

	/*
	if (href_list["crowbar"])
		//final step in removing a component... handle crowbars slightly differently
		var/mount_index = text2num(href_list["mount_index"]) + 1
		var/datum/vehicle_mount/system_mount = system_mounts[mount_index]
		var/obj/structure/vehicle_component/vehicle_component = system_mount.my_component
		var/mob/user = locate(href_list["user"])

		tool_component(vehicle_component, INSTALL_CROWBAR, 1, user)

		/*
		//world << "crowbarring [vehicle_component] from [system_mount]... vehicle_component.install_status:[vehicle_component.install_status]"
		if(vehicle_component.install_status)
			user << "\icon[vehicle_component] <span class='notice'>[vehicle_component] cannot be removed from \icon[src] [src] [system_mount] mount yet.</span>"
		else if(remove_component(vehicle_component))
			user << "<span class='info'>You successfully uninstall \icon[vehicle_component] [vehicle_component] from \icon[src] [src] [system_mount] mount.</span>"
		else
			testing("ERROR: Failed to uninstall component from [src] [src.type], [usr] [usr.client]")
			*/
			*/

	if (href_list["install_comp"])
		var/mount_index = text2num(href_list["mount_index"]) + 1
		var/datum/vehicle_mount/system_mount = system_mounts[mount_index]
		var/mob/user = locate(href_list["user"])
		var/list/valid_mounts = list()
		for(var/obj/structure/vehicle_component/vehicle_component in range(1, user))
			if(vehicle_component.mount_type == system_mount.mount_type && \
			vehicle_component.mount_size == system_mount.mount_size)
				valid_mounts += vehicle_component
		var/obj/structure/vehicle_component/install_component
		if(valid_mounts.len == 0)
			user << "<span class='warning'>There are no valid components installabe here. This mount only allows a \
			[vehicle_component_size_string(system_mount.mount_size)] [vehicle_component_type_string(system_mount.mount_type)] component</span>"
		else if(valid_mounts.len == 1)
			install_component = valid_mounts[1]
		else
			valid_mounts += "Cancel"
			install_component = input(user, "Choose a component to install", "Install component", null) in valid_mounts
			if(!istype(install_component))
				install_component = null

		if(install_component)
			add_component(install_component, system_mount, user)

	/*
	if (href_list["wrench"])
		var/index = text2num(href_list["wrench"]) + 1
		var/obj/structure/vehicle_component/removing_component = ext_comps[index]
		if(removing_component.install_requires & INSTALL_BOLTED)
			var/actionverb = "unwrench"
			if(removing_component.install_status & INSTALL_BOLTED)
				removing_component.install_status &= ~INSTALL_BOLTED
			else
				removing_component.install_status |= INSTALL_BOLTED
				actionverb = "wrench"
			usr << "<span class='info'>You successfully [actionverb] \icon[removing_component] [removing_component] from \icon[src] [src].</span>"
		else
			usr << "\icon[removing_component] <span class='warning'>[removing_component] does not need to be wrenched into \icon[src] [src].</span>"
			*/

	/*
	if (href_list["eject_int"])
		//uninstall an internal component
		var/index = text2num(href_list["eject_int"]) + 1
		var/obj/structure/vehicle_component/removing_component = int_comps[index]
		if(remove_component(removing_component, index))
			usr << "<span class='info'>You successfully uninstall \icon[removing_component] [removing_component] from \icon[src] [src].</span>"
		else
			testing("ERROR: Failed to uninstall component from [src] [src.type], [usr] [usr.client]")
		return
		*/

	if (href_list["forceUpdate"])
		var/mob/user = locate(href_list["user"])
		ui_interact(user)

	return ..()
