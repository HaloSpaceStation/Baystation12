
//some slightly different handling for the initial approach beacon

/obj/machinery/autopilot_beacon/approach/init_turf_listeners()
	//project a line of turfs so we can "catch" ships flying around the outside of the ship
	var/turf/T = get_turf(src)
	var/exit_dir = get_exit_dir()
	while(T)
		T.entry_listeners.Add(src)
		T = get_step(T, exit_dir)

/obj/machinery/autopilot_beacon/approach/vehicle_arrive(var/turf/triggered, var/obj/machinery/overmap_vehicle/V)
	world << "/obj/machinery/autopilot_beacon/approach/vehicle_arrive([triggered.x]:[triggered.y], [V])"
	if(V.docking_route == src.route_name)
		world << "	correct route..."

		if(src.loc == V.loc)
			world << "	arrived at beacon"
			V.last_beacon = src

			//just to make sure
			V.docking_on_approach = 0

			//we've reached this beacon so continue the route as normal
			V.autopilot_beacon_reached(src, 1)

		else if(V.docking_on_approach)
			world << "	setting initial approach"
			//V.autopilot_begin_autodock(src)
			var/approach_dir = src.get_approach_dir()
			V.autopilot_beacon_face(approach_dir)
			V.autopilot_beacon_thrust(approach_dir)
			world << "	src.dir:[src.dir] after"
			V.docking_on_approach = 0

/*
/obj/machinery/overmap_vehicle/proc/autopilot_begin_autodock(var/obj/machinery/autopilot_beacon/approach_beacon)
	world << "/obj/machinery/overmap_vehicle/proc/autopilot_begin_autodock([approach_beacon] [approach_beacon.type])"
	world << "	src.dir:[src.dir] before"

	var/approach_dir = approach_beacon.get_approach_dir()
	autopilot_beacon_face(approach_dir)
	autopilot_beacon_thrust(approach_dir)
	world << "	src.dir:[src.dir] after"
	docking_on_approach = 0
	*/

/obj/machinery/autopilot_beacon/approach/initialize()
	..()
	//tell the ship or station about us so they can record our route
	var/obj/effect/overmapobj/overmapobj = map_sectors["[src.z]"]
	overmapobj.add_route_beacon(src)
