
/obj/structure/vehicle_component/weapon/process()
	var/continue_processing = 0

	if(is_heating)
		is_heating = max(is_heating - 1, 0)
		continue_processing = 1
	else if(heat > 0)
		heat = max(heat - 10, 0)
		if(heat <= 0)
			overheat = 0
			screen_heat.overlays -= "overheat"
		continue_processing = 1
		screen_heat.update_icon()

	if(!continue_processing)
		is_processing = 0
		processing_objects.Remove(src)
		return PROCESS_KILL
