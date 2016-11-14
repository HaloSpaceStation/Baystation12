
/obj/machinery/autopilot_beacon
	name = "Docking Beacon"
	desc = "A navigational beacon to guide shuttles and strike craft in for auto-docking."
	icon = 'code/modules/overmap/autopilot_beacon.dmi'

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
	var/dir_docking = 0		//set this to the dir of the next beacon towards the hangar

	//set the same route id for an autopilot route
	//each beacon should increment the route id by 1
	//the starting beacon for each route with route_num 1 should be the outermost one
	var/route_id = ""
	var/route_num = 1
	var/list/my_route		//set by the overmapobj

/obj/machinery/autopilot_beacon/New()
	..()

/obj/machinery/autopilot_beacon/initialize()
	..()

	//straight copy of the code from cables
	var/dash = findtext(icon_state, "-")
	dir1 = text2num( copytext( icon_state, 1, dash ) )
	dir2 = text2num( copytext( icon_state, dash+1 ) )

	//tell the ship or station about us so they can record our route
	var/obj/effect/overmapobj/overmapobj = map_sectors["[src.z]"]
	overmapobj.add_route_beacon(src)

/obj/machinery/autopilot_beacon/proc/get_approach_dir()
	if(dir1 == dir_docking)
		return dir2
	else
		return dir1

/obj/machinery/autopilot_beacon/proc/get_next_beacon()
	//returning null means no more valid beacons in the route. congratulations you reached the end!
	if(route_id < my_route.len)
		return my_route[route_id + 1]

/obj/machinery/autopilot_beacon/entry_triggered(var/turf/triggered, var/atom/movable/M)
	if(istype(M, /obj/machinery/overmap_vehicle))
		var/obj/machinery/overmap_vehicle/overmap_vehicle = M
		if(overmap_vehicle.current_autopilot_beacon == src)
			overmap_vehicle.autopilot_reach_target(src)
