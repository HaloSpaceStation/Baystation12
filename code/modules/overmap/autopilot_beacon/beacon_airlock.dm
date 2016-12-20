
//this beacon waits for an airlock to cycle before proceeding

/obj/machinery/autopilot_beacon/airlock
	/*var/cycle_to_exterior = 1	//whether to cycle to space or hangar
	var/controller_id_tag
	var/door_id_tag*/

	/*
	var/frequency				//set to the radio frequency of any linked airlocks
	//only set one of these
	var/airlock_exterior_tag	//if this beacon is in space
	// - OR -
	var/airlock_interior_tag	//if this beacon is inside the ship or airlock
	*/

/obj/machinery/autopilot_beacon/airlock/vehicle_arrive(var/turf/triggered, var/obj/machinery/overmap_vehicle/V)
	if(V.docking_route == src.route_name && V.last_beacon != src)
		V.autopilot_beacon_reached(src, 0)

		if(datanet_airlock)
			datanet_airlock.enact_command("cycle_ext")
		/*
		//send signal for airlock to cycle
		var/datum/signal/signal = new
		signal.data["tag"] = controller_id_tag
		if(cycle_to_exterior)
			signal.data["command"] = "cycle_exterior"
		else
			signal.data["command"] = "cycle_interior"
		//world << "[src] #[route_num] sending signal [signal.data["command"]] on freq [frequency] with tag [controller_id_tag]"
		post_signal(signal, RADIO_AIRLOCK)
		*/

/obj/machinery/autopilot_beacon/airlock/proc/airlock_cycled_ext()
	for(var/obj/machinery/overmap_vehicle/V in src.loc)
		V.autopilot_beacon_reached(src, 1)

/*
/obj/machinery/autopilot_beacon/airlock/receive_signal(datum/signal/signal, receive_method, receive_param)
	//world << "[src] #[route_num] recieved door_status: [signal.data["door_status"]] on freq [frequency] with tag [signal.data["tag"]]"
	if(signal.data["tag"] == door_id_tag && signal.data["door_status"] == "open")
		for(var/obj/machinery/overmap_vehicle/V in src.loc)
			if(V.current_route_name == src.route_name)
				V.autopilot_beacon_proceed(src)
*/