
/obj/machinery/overmap_vehicle
	var/docking_on_approach = 1
	var/docking_route
	var/autopilot_speed = 8
	var/obj/machinery/autopilot_beacon/last_beacon
	//var/autopilot_targetx = 0
	//var/autopilot_targety = 0
	//var/is_autopilot_targetting_x = 1

/obj/machinery/overmap_vehicle/proc/autopilot_begin_approach(var/obj/effect/overmapobj/route_sector)
	if(docking_route)
		//current_dock_id = 1
		//if this isnt a valid dock route, then reset and forget it
		/*if(current_autopilot_beacon.z != src.z)
			current_dock_route = null
			return*/

		pilot << "\icon[src] <span class='info'>[src] beginning autodock sequence \'[docking_route]\' with [route_sector].</span>"

		//stop moving
		pixel_x = 0
		pixel_y = 0
		pixel_transform.pixel_speed_x = 0
		pixel_transform.pixel_speed_y = 0
		pixel_transform.recalc_speed()

		//work out which direction to take
		//we want to circle around the sector hugging the edges until we are in the right approach spot
		//autopilot_update_approach()

		//prototype: for now just jump to the approach position for the first beacon (hugging the edge of the map)
		//shuttle max dims are 15x15
		var/obj/machinery/autopilot_beacon/approach_beacon = route_sector.autopilot_routes[docking_route]
		if(!approach_beacon)
			usr << "<span class='warning'>ERROR: Unable to locate approach beacon</span>"
			return

		//TEST: just jump to the approach position for now, dont actually fly around the outside of the capship
		usr << "<span class='info'>DEBUG: Your ship has teleported directly to the approach vector.</span>"

		var/approach_dir = approach_beacon.get_approach_dir()
		switch(approach_dir)
			if(NORTH)
				src.x = approach_beacon.x
				src.y = 1
			if(SOUTH)
				src.x = approach_beacon.x
				src.y = world.maxy - 15
			if(EAST)
				src.x = 1
				src.y = approach_beacon.y
			if(WEST)
				src.x = world.maxx - 15
				src.y = approach_beacon.y

		//trigger the approach beacon manually
		var/turf/T = locate(src.x, src.y, src.z)
		var/olddir = src.dir
		T.Entered(src)
		src.dir = olddir
		. = 1

/*
/obj/machinery/overmap_vehicle/shuttle/autopilot_begin_approach(var/obj/effect/overmapobj/route_sector)
	if(..())
		move_dir = 0
		*/

/*
/obj/machinery/overmap_vehicle/proc/autopilot_update_approach()

	//are we on the right approach angle for it?
	var/approach_dir = starting_beacon.get_approach_dir()

	//first get the "side" of the map we are closest to
	if(src.x < world.maxx / 2)
		//left half of the map

	//we are on the right side now
	if(src.dir == approach_dir)
		if(abs(src.x - starting_beacon.x) > abs(src.y - starting_beacon.y))
		/*autopilot_targetx = 0
		autopilot_targety = 0
		is_autopilot_targetting_x = 1*/
*/

/obj/machinery/overmap_vehicle/proc/autopilot_beacon_face(var/target_dir)
	world << "/obj/machinery/overmap_vehicle/proc/autopilot_beacon_face([target_dir])"
	world << "	src.dir:[src.dir] before"
	//prototype: snap the direction
	pixel_transform.turn_to_dir(target_dir, 360)
	world << "	src.dir:[src.dir] after"
	return 1

/obj/machinery/overmap_vehicle/shuttle/autopilot_beacon_face(var/target_dir)
	world << "/obj/machinery/overmap_vehicle/shuttle/autopilot_beacon_face([target_dir])"
	var/turf/oldloc = src.loc
	move_dir = target_dir
	if(src.dir == target_dir)
		world << "	check1"
		return 1
	else if(turn_towards_dir(target_dir))
		world << "	turn_towards_dir([target_dir]) was successful, src.dir:[src.dir]"
		src.loc = oldloc
		//if we succeed with the first turn, we might still need to turn again
		//(ie we are facing 180 degrees away from targetdir)
		//turn_towards_dir(target_dir)

		//for the moment just turn on a dime to make autopilot simpler
		return 1

	else
		world << "	check3"
		//if we failed to turn and we arent already facing the right way, then our progress is being blocked
		pilot << "<span class='warning'>Alert: Unable to orient to next autopilot beacon, something is blocking it.</span>"
		return 0

/obj/machinery/overmap_vehicle/proc/autopilot_beacon_thrust(var/target_dir)
	//prototype: snap to the target speed

	pixel_transform.add_pixel_speed_direction(autopilot_speed, target_dir)

/obj/machinery/overmap_vehicle/shuttle/autopilot_beacon_thrust(var/target_dir)
	//prototype: snap to the target speed

	move_dir = 0
	if(target_dir == src.dir)
		pixel_transform.add_pixel_speed_direction(autopilot_speed, target_dir)

/obj/machinery/overmap_vehicle/proc/autopilot_beacon_reached(var/obj/machinery/autopilot_beacon/triggering_beacon, var/proceed = 1)
	world << "/obj/machinery/overmap_vehicle/proc/autopilot_beacon_reached([triggering_beacon] [triggering_beacon.type], [proceed])"
	world << "	src.dir:[src.dir]"

	//stop moving
	pixel_x = 0
	pixel_y = 0
	pixel_transform.pixel_speed_x = 0
	pixel_transform.pixel_speed_y = 0
	pixel_transform.recalc_speed()

	//tell the player we reacehd the beacon
	pilot << "\icon[triggering_beacon] <span class='info'>Reached [triggering_beacon] #[triggering_beacon.route_num] ([triggering_beacon.route_name]).</span>"

	//check what the next dir to move in is
	var/next_dir = triggering_beacon.get_next_dir(docking_route ? 1 : 0)
	world << "	next_dir:[next_dir]"
	if(next_dir)
		if(proceed)
			//start moving to the next beacon
			autopilot_beacon_proceed(triggering_beacon)
			. = 1
		else
			//orient to face the next beacon and wait
			//make sure we can turn (required for shuttles)
			//if there isn't room to turn, we can't proceed with the dock
			if(!autopilot_beacon_face(next_dir))
				pilot << "<span class='warning'>Alert, turn failed at beacon[triggering_beacon.route_name] #[triggering_beacon.route_num]. Halting autopilot.</span>"
				docking_route = null
				//
				. = 0

			else
				//wait for this beacon (cycling airlock)
				pilot << "\icon[triggering_beacon] <span class='info'>Waiting for the beacon to signal readiness to proceed...</span>"
				. = -1
	else
		//no next dir = no more beacons, we are done!
		pilot << "\icon[triggering_beacon] <span class='info'>Completed autopilot route.</span>"
		docking_route = null
		. = 2

	//world << "	is_docking:[is_docking] next_dir:[next_dir]"

/obj/machinery/overmap_vehicle/proc/autopilot_beacon_proceed(var/obj/machinery/autopilot_beacon/triggering_beacon)
	world << "/obj/machinery/overmap_vehicle/proc/autopilot_beacon_proceed([triggering_beacon] [triggering_beacon.type])"
	if(triggering_beacon.route_name == docking_route)
		pilot << "\icon[triggering_beacon] <span class='info'>Proceeding to next beacon.</span>"

		var/next_dir = triggering_beacon.get_next_dir(docking_route ? 1 : 0)
		world << "next_dir:[next_dir]"
		world << "src.dir:[src.dir] before"
		autopilot_beacon_face(next_dir)
		autopilot_beacon_thrust(next_dir)
		world << "src.dir:[src.dir] after"

/obj/machinery/overmap_vehicle/shuttle/autopilot_beacon_reached(var/obj/machinery/autopilot_beacon/triggering_beacon, var/proceed = 1)
	world << "/obj/machinery/overmap_vehicle/shuttle/autopilot_beacon_reached([triggering_beacon], [proceed])"
	//check if we've finished docking
	if(..() == 2)
		init_maglock(src.pilot)
