
/obj/machinery/overmap_vehicle/proc/component_init_all()

	//external components
	for(var/mount_type in external_loadout)
		component_init(mount_type, external_loadout[mount_type])

	//internal components
	for(var/component_type in internal_loadout)
		component_init(/datum/vehicle_mount/internal, component_type)

	//crew components
	/*for(var/component_type in crew_loadout)
		init_component(/datum/vehicle_mount/crew, component_type)*/

	//initialise activation shortcut groups
	var/datum/component_group/previous
	var/datum/component_group/current
	while(component_groups.len < COMPONENT_GROUP_MAX)
		previous = current
		current = new /datum/component_group(src, component_groups.len+COMPONENT_GROUP_MIN)
		if(previous)
			previous.next = current
			current.previous = previous
		component_groups.Add(current)

		//uncomment this for circular linkages
		//we want players able to disable group selection for a weapon tho
		/*if(component_groups.len == COMPONENT_GROUP_MAX)
			var/datum/component_group/first = component_groups[1]
			first.previous = current
			current.next = first*/

	//putting this here because its not the worst place for it to go rn
	//the heirarchy for components weapons & huds is a lil screwy, its not that easy to grasp (todo: reorder it?)

	//component_groups
	//var/obj/vehicle_hud/shortcut_group_activate/screen_activategroup
