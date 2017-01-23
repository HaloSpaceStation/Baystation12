
/obj/machinery/overmap_vehicle/shuttle/enable_cruise(var/mob/user)
	if(is_maglocked())
		user << "<span class='info'>\icon[src] [src] cannot enable cruise while maglocked.</span>"
		return 0

	return ..()

/obj/machinery/overmap_vehicle/shuttle/disable_cruise()
	//world << "/obj/machinery/overmap_vehicle/shuttle/disable_cruise()"
	. = 0
	if(is_cruising())
		//as shuttles only turn in 90 increments but cruise mode allows them 360 degree rotation
		//lets snap the overmapobj to nearest cardinal direction then rotate the shuttle obj accordingly

		//work out nearest cardinal angle to the overmapobj's heading
		//todo: is there a helper for this? should there be?
		var/target_dir = 0
		if(overmap_object.pixel_transform.heading < 45)
			target_dir = NORTH
		else if(overmap_object.pixel_transform.heading < 135)
			target_dir = EAST
		else if(overmap_object.pixel_transform.heading < 225)
			target_dir = SOUTH
		else if(overmap_object.pixel_transform.heading < 315)
			target_dir = WEST
		else
			target_dir = NORTH
		//world << "	calculated snap dir: [target_dir]"

		//snap the heading to the calculated cardinal
		overmap_object.pixel_transform.turn_to_dir(target_dir, 360)

		return ..()

/obj/machinery/overmap_vehicle/shuttle/cruise_exit_orientation()
	var/target_dir = angle2dir(overmap_object.pixel_transform.heading)
	//multiple turns may be necessary as shuttle can only turn in 90 degree increments
	while(src.dir != target_dir)
		//world << "	turning..."
		src.turn_towards_dir(target_dir)

	return

/*
//some major bugs with this so leave it disabled for now
/obj/machinery/overmap_vehicle/shuttle/handle_auto_cruising()
	if(..())
		//automatically snap-turn the interior when we're cruising
		//restrict it to a cooldown
		if(time_last_maneuvre + maneuvre_cooldown < world.time)
			time_last_maneuvre = world.time
			//
			var/cruise_dir = angle2dir(overmap_object.vehicle.heading)
			var/turn_angle = -shortest_angle_to_dir(dir2angle(src.dir), cruise_dir, 90)
			src.interior.rotate_contents(turn_angle / 90)

			//todo: additional sprites for sn and we directions
			if(src.dir & (NORTH|SOUTH))
				transit_area.sprite_area_transit("ns")
			else
				transit_area.sprite_area_transit("ew")

		return 1

	return 0
*/