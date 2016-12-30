
/obj/machinery/autopilot_beacon
	name = "Docking Beacon"
	desc = "A navigational beacon to guide shuttles and strike craft in for auto-docking."
	icon = 'code/modules/overmap/autopilot_beacon/autopilot_beacon.dmi'

	//datanets
	var/datum/datanet_logic/berth/datanet_berth
	var/datum/datanet_logic/airlock/datanet_airlock

	//icon state naming convention follows the same rules as cables with two dirs leading out of the tile
	//the lower number always goes first regardless of direction
	//the format here is "[first direction bitflag]-[second direction bitflag]-[first letter of the colour]"
	//as a placeholder i only put in the ones i needed so not all states have been done
	//check the icon and make sure the right icon state is present
	//note this is done using overlays to simplify sprite updates

	//to autoset the directional vars, change this icon state to eg "1-4" or "4-8"
	//otherwise it will load the mapset vars
	//only use cardinal directions! do not use subcardinals (diagonals)
	icon_state = "0-0-g"
	var/dir1 = 0
	var/dir2 = 0
	var/dir_inbound = 0		//set this to the dir of the next beacon towards the hangar

	//set the same route id for an autopilot route
	//each beacon should increment the route id by 1
	//the starting beacon for each route with route_num 1 should be the outermost one
	var/route_name = ""
	var/route_num = 1		//this can double up
	//var/list/my_route		//set by the overmapobj

/obj/machinery/autopilot_beacon/New()
	..()

	//straight copy of the code from cables
	var/dash = findtext(icon_state, "-")
	dir1 = text2num( copytext( icon_state, 1, dash ) )
	dir2 = text2num( copytext( icon_state, dash+1 ) )

/obj/machinery/autopilot_beacon/initialize()
	..()

	/*if(frequency)
		set_frequency(frequency)*/

	//tell the ship or station about us so they can record our route
	/*var/obj/effect/overmapobj/overmapobj = map_sectors["[src.z]"]
	overmapobj.add_route_beacon(src)*/

	init_turf_listeners()

/obj/machinery/autopilot_beacon/datanet_logic_linked(var/logic_module)
	if(istype(logic_module, /datum/datanet_logic/airlock))
		datanet_airlock = logic_module
	else if(istype(logic_module, /datum/datanet_logic/berth))
		datanet_berth = logic_module
/*
/obj/machinery/autopilot_beacon/proc/set_frequency(new_frequency)
	radio_controller.remove_object(src, frequency)
	frequency = new_frequency
	radio_connection = radio_controller.add_object(src, frequency, radio_filter)
*/
/obj/machinery/autopilot_beacon/proc/init_turf_listeners()
	var/turf/T = get_turf(src)
	T.entry_listeners.Add(src)

/obj/machinery/autopilot_beacon/proc/get_next_dir(var/is_docking = 1)
	if(is_docking)
		return dir_inbound

	return get_exit_dir()

/obj/machinery/autopilot_beacon/proc/get_exit_dir()
	if(dir1 == dir_inbound)
		return dir2
	else
		return dir1

/obj/machinery/autopilot_beacon/proc/get_approach_dir()
	return turn(get_exit_dir(), 180)

/*/obj/machinery/autopilot_beacon/proc/get_next_beacon()
	//returning null means no more valid beacons in the route. congratulations you reached the end!
	if(route_num < my_route.len)
		return my_route[route_num + 1]*/

/obj/machinery/autopilot_beacon/entry_triggered(var/turf/triggered, var/atom/movable/M)
	if(istype(M, /obj/machinery/overmap_vehicle))
		vehicle_arrive(triggered, M)

/obj/machinery/autopilot_beacon/proc/vehicle_arrive(var/turf/triggered, var/obj/machinery/overmap_vehicle/V)
	world << "/obj/machinery/autopilot_beacon/proc/vehicle_arrive([triggered.x]:[triggered.y], [V])"
	if(V.docking_route == src.route_name && V.last_beacon != src)
		V.last_beacon = src
		V.autopilot_beacon_reached(src, 1)
		return 1
	return 0
/*
/obj/machinery/autopilot_beacon/proc/post_signal(datum/signal/signal, var/filter = null)
	signal.transmission_method = TRANSMISSION_RADIO
	if(radio_connection)
		//use_power(radio_power_use)	//neat idea, but causes way too much lag.
		return radio_connection.post_signal(src, signal, filter)
	else
		qdel(signal)
*/
