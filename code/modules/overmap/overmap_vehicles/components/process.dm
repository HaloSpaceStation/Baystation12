
/obj/structure/vehicle_component/process()
	if(is_processing)
		is_processing = 0
		processing_objects.Remove(src)

	return PROCESS_KILL

/obj/structure/vehicle_component/proc/set_processing()
	if(!is_processing)
		is_processing = 1
		processing_objects.Add(src)
