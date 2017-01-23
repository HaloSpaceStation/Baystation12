
/obj/machinery/overmap_vehicle/var/last_sector

/obj/machinery/overmap_vehicle/proc/leaving_sector(var/obj/effect/overmapobj/oldsector, var/obj/effect/overmapobj/newsector)
	last_sector = oldsector
	message_viewers("<span class='info'>[src] departs in the direction of [newsector].</span>", "<span class='info'>You depart from [oldsector].</span>")

	if(oldsector)
		oldsector.scanner_manager.remove_sector_vehicle(src)
		oldsector.scanner_manager.remove_generic_scanner(waypoint_controller)

	waypoint_controller.clear_all_waypoints()

/obj/machinery/overmap_vehicle/proc/enter_new_sector(var/obj/effect/overmapobj/newsector, var/obj/effect/zlevelinfo/entryz)
	var/viewer_message
	if(last_sector)
		viewer_message = "<span class='info'>[src] arrives from the direction of [last_sector]</span>"
	var/pilot_message = "<span class='info'>You arrive at [newsector]</span>"
	var/num_levels = src.GetNumLevels()
	if(num_levels > 1)
		pilot_message += "<span class='info'> on level [src.GetLevelNum()]/[num_levels]</span>"
	pilot_message += "."
	message_viewers(viewer_message, pilot_message)

	waypoint_controller.set_current_sector(newsector, entryz.z)

	newsector.scanner_manager.add_sector_scanner(waypoint_controller)
	newsector.scanner_manager.add_sector_vehicle(src)

	hud_waypoint_controller.enter_new_zlevel(entryz)

	//force an immediate update to prevent jitter
	pixel_transform.update()
/*
/obj/machinery/overmap_vehicle/proc/enter_new_zlevel(var/obj/effect/zlevelinfo/entryz)
	hud_waypoint_controller.enter_new_zlevel(entryz)
*/