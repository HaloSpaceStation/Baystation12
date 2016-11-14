
/obj/machinery/overmap_vehicle/proc/autopilot_attempt_begin(var/obj/effect/overmapobj/route_sector)
	if(current_dock_route)
		current_autopilot_beacon = current_dock_route[1]
		//if this isnt a valid dock route, then reset and forget it
		if(current_autopilot_beacon.z != src.z)
			current_dock_route = null
			return

		pilot << "\icon[src] <span class='info'>[src] beginning autodock sequence \'[current_autopilot_beacon.route_id]\' with [route_sector].</span>"

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
		var/approach_dir = current_autopilot_beacon.get_approach_dir()
		switch(approach_dir)
			if(NORTH)
				src.x = current_autopilot_beacon.x
				src.y = world.maxy - TRANSITIONEDGE - 15
			if(SOUTH)
				src.x = current_autopilot_beacon.x
				src.y = TRANSITIONEDGE
			if(EAST)
				src.x = world.maxx - TRANSITIONEDGE - 15
				src.y = current_autopilot_beacon.y
			if(WEST)
				src.x = TRANSITIONEDGE
				src.y = current_autopilot_beacon.y
		//
		autopilot_beacon_face(approach_dir)
		autopilot_beacon_thrust(approach_dir)

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
	//prototype: snap the direction
	pixel_transform.turn_to_dir(target_dir, 360)

/obj/machinery/overmap_vehicle/proc/autopilot_beacon_thrust(var/target_dir)
	//prototype: snap to the target speed
	pixel_transform.add_pixel_speed_direction(32, target_dir)

/obj/machinery/overmap_vehicle/proc/autopilot_reach_target(var/obj/machinery/autopilot_beacon/triggering_beacon)
	//stop moving
	pixel_x = 0
	pixel_y = 0
	pixel_transform.pixel_speed_x = 0
	pixel_transform.pixel_speed_y = 0
	pixel_transform.recalc_speed()

	//get the next beacon
	var/outtext = "\icon[current_autopilot_beacon] <span class='info'>Reached [current_autopilot_beacon] #[current_autopilot_beacon.route_num]."
	current_autopilot_beacon = current_autopilot_beacon.get_next_beacon()
	if(current_autopilot_beacon)
		outtext += " Proceeding to next beacon..."

		//face and start moving out from this beacon
		autopilot_beacon_face(current_autopilot_beacon.dir_docking)
		autopilot_beacon_thrust(current_autopilot_beacon.dir_docking)

	else
		//done!
		outtext += " Completed autopilot route."
	outtext += "</span>"
	pilot << outtext

