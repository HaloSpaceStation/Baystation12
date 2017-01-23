
/obj/machinery/overmap_vehicle/proc/fall()
	//fall!
	visible_message("<span class='warning'><b>[src] drops out of the air!</b></span>")

	//process() will handle destruction checks
	//todo: actually move the vehicle down zlevels if it is high above the ground
	//todo: scale damage with number of zlevels fallen
	hull_remaining -= 10

/obj/machinery/overmap_vehicle/proc/no_grav()
	//just check if we're in space or not
	var/turf/T = get_turf(src)
	if(T.is_space())
		return 1

	return 0

//so passengers dont asphyxiate or die of pressure loss
/obj/machinery/overmap_vehicle/return_air()
	return internal_atmosphere
