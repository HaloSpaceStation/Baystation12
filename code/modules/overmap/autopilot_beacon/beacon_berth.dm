
/obj/machinery/overmap_vehicle
	var/obj/machinery/autopilot_beacon/berth/my_berth


/obj/machinery/autopilot_beacon/berth
	icon_state = "berth"

/obj/machinery/autopilot_beacon/berth/vehicle_arrive(var/turf/triggered, var/obj/machinery/overmap_vehicle/V)
	if(datanet_berth)
		datanet_berth.refresh_berthed_vehicle()
	if(datanet_airlock)
		datanet_airlock.enact_command("cycle_int")

	V.autopilot_beacon_reached(src, 0)

/obj/machinery/autopilot_beacon/berth/get_next_dir(var/is_docking = 1)
	//always return 0 to force us to finish here
	return 0

/obj/machinery/autopilot_beacon/berth/proc/airlock_cycled_int()
/*
/obj/machinery/autopilot_beacon/berth/proc/refresh_berthed_vehicle()
	berthed_vehicle = null

	for(var/obj/machinery/overmap_vehicle/overmap_vehicle in src.loc)
		berthed_vehicle = overmap_vehicle
		break

	if(!berthed_vehicle)
		for(var/dist = 1, dist < 5, dist++)
			for(var/obj/machinery/overmap_vehicle/overmap_vehicle in view(src, dist))
				berthed_vehicle = overmap_vehicle
				break
			if(berthed_vehicle)
				break
*/