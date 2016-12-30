
//override in children if necessary
/obj/machinery/overmap_vehicle/proc/handle_auto_turning()
	//world << "/obj/machinery/overmap_vehicle/shuttle/handle_auto_turning() turn_dir:[turn_dir]"
	if(turn_dir)
		vehicle_controls.turn_vehicle(pilot, turn_dir)
		var/datum/pixel_transform/target_transform = pixel_transform
		if(is_cruising())
			target_transform = overmap_object.pixel_transform

		if(target_transform.heading == dir2angle(turn_dir))
			turn_dir = 0
		else
			return 1
	return 0

//override in children if necessary
/obj/machinery/overmap_vehicle/proc/handle_auto_cruising()
	if(is_cruising())
		overmap_object.pixel_transform.accelerate_forward(cruise_speed)
		return 1

	return 0

//override in children if necessary
/obj/machinery/overmap_vehicle/proc/handle_auto_moving()
	if(move_forward)
		vehicle_controls.move_vehicle_forward(pilot)
	else if(move_dir)
		vehicle_controls.move_vehicle(pilot, move_dir)
		return 1
	return 0
