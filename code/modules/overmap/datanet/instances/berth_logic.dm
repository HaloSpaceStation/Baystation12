
/datum/datanet_logic/berth
	var/obj/machinery/autopilot_beacon/berth/berth_beacon
	var/obj/machinery/overmap_vehicle/berthed_vehicle

	var/prefer_status = DOCK_IFF
	var/current_status = DOCK_IFF
	var/dock_passcode = ""

/datum/datanet_logic/berth/link_atom(var/atom/A)
	..()

	var/success = 0

	//so we know about the actual spot for the ships
	if(istype(A, /obj/machinery/autopilot_beacon/berth))
		berth_beacon = A
		success = 1
		refresh_berthed_vehicle()

	//these still need to be told when they're linked
	else if(istype(A, /obj/machinery/datanet_berth_console))
		success = 1

	if(success)
		A.datanet_logic_linked(src)

/datum/datanet_logic/berth/proc/refresh_berthed_vehicle()
	berthed_vehicle = null
	if(berth_beacon)
		for(var/obj/machinery/overmap_vehicle/overmap_vehicle in berth_beacon.loc)
			berthed_vehicle = overmap_vehicle
			break

		if(!berthed_vehicle)
			for(var/dist = 1, dist < 5, dist++)
				for(var/obj/machinery/overmap_vehicle/overmap_vehicle in view(dist, berth_beacon))
					berthed_vehicle = overmap_vehicle
					break
				if(berthed_vehicle)
					break

	if(berthed_vehicle)
		current_status = DOCK_NONE
	else
		current_status = prefer_status
