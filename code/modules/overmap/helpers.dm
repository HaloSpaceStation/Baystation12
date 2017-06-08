
/proc/shortest_angle_to_dir(var/current_heading, var/target_dir, var/max_angle)

	var/target_heading = dir2angle(target_dir)
	if(current_heading == target_heading)
		return 0

	//hardcode the expected values, until someone can work out a general solution
	var/heading_change = 0
	switch(target_dir)
		if(NORTH)
			if(current_heading < 180)
				heading_change = -1
			else
				heading_change = 1
		if(NORTHEAST)
			if(current_heading > 225 || current_heading < 45)
				heading_change = 1
			else
				heading_change = -1
		if(EAST)
			if(current_heading < 90 || current_heading > 270)
				heading_change = 1
			else
				heading_change = -1
		if(SOUTHEAST)
			if(current_heading < 135 || current_heading > 315)
				heading_change = 1
			else
				heading_change = -1
		if(SOUTH)
			if(current_heading < 180)
				heading_change = 1
			else
				heading_change = -1
		if(SOUTHWEST)
			if(current_heading > 225 || current_heading < 45)
				heading_change = -1
			else
				heading_change = 1
		if(WEST)
			if(current_heading < 90 || current_heading > 270)
				heading_change = -1
			else
				heading_change = 1
		if(NORTHWEST)
			if(current_heading < 135 || current_heading > 315)
				heading_change = -1
			else
				heading_change = 1

	var/rotate_angle = 0
	if(heading_change)

		rotate_angle = heading_change * max_angle

		//update the heading
		var/new_heading = current_heading + rotate_angle
		if(abs(target_heading - new_heading) < max_angle)
			rotate_angle = target_heading - current_heading

	return rotate_angle

/proc/atom_center_turf(var/atom/movable/source)
	var/turf/T
	if(istype(source))
		var/centre_pixel_x = source.bound_width / 2
		var/centre_pixel_y = source.bound_height / 2
		T = locate(source.x + (centre_pixel_x / 32), source.y + (centre_pixel_y / 32), source.z)
	return T

/proc/get_center_pixel_offsetx(var/atom/movable/source)
	if(source)
		switch(source.bound_width)
			if(64)
				return 16
			if(96)
				return 32
			if(128)
				return 48
	return 0

/proc/get_center_pixel_offsety(var/atom/movable/source)
	if(source)
		switch(source.bound_height)
			if(64)
				return 16
			if(96)
				return 32
			if(128)
				return 48
	return 0

/proc/get_overmap_sector(var/atom/A)
	//aggressive coding: dont do safety checks and rely on runtimes to tell you when you have an unintended edge case
	/*if(istype(A, /obj/effect/overmapobj))
		return A*/
	var/obj/effect/overmapobj/sector

	var/turf/T = get_turf(A)
	if(!T)
		return
	sector = map_sectors["[T.z]"]
	if(!sector)
		//special handling
		var/obj/machinery/overmap_vehicle/craft

		//check if we are in a shuttle
		if(istype(T, /turf/simulated/shuttle/hull))
			var/turf/simulated/shuttle/hull/H = T
			craft = H.my_shuttle
		else
			//check if we are in a cruising fighter etc
			//this should only loop perhaps 2-4 times at most
			var/atom/container = A
			while(container && !istype(container, /turf) && !istype(container, /area))
				container = container.loc
				if(istype(container, /obj/machinery/overmap_vehicle))
					craft = container
					break

		if(craft)
			sector = craft.get_sector()

	//that should cover all the edge cases here. it's possible there will be zlevels
	return sector
