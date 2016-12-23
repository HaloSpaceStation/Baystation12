//misc procs

/obj/machinery/overmap_vehicle/proc/deselect_all_components()
	while(selected_components.len)
		var/obj/structure/vehicle_component/selected_component = selected_components[1]
		selected_component.deselect()
		selected_components -= selected_component
