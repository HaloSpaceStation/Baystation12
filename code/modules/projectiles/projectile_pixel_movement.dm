
/obj/item/projectile/proc/launch_heading(var/heading, var/target_zone, var/pixel_speed = world.icon_size)
	var/turf/curloc = get_turf(src)
	if (!istype(curloc))
		return 1

	spawn()
		setup_trajectory_heading(curloc, heading) //plot the initial trajectory

		//modify the pioxel speed if we want to use a different one from the standard projectile speed
		if(pixel_speed != world.icon_size)

			trajectory.offset_x /= world.icon_size
			trajectory.offset_x *= pixel_speed
			trajectory.offset_y /= world.icon_size
			trajectory.offset_y *= pixel_speed

		process_heading()

	return 0

/obj/item/projectile/proc/setup_trajectory_heading(turf/startloc, var/heading)
	// setup projectile state
	starting = startloc
	current = startloc

	// trajectory dispersion
	var/offset = 0
	if(dispersion)
		var/radius = round(dispersion*9, 1)
		offset = rand(-radius, radius)

	// plot the initial trajectory
	trajectory = new()
	trajectory.setup_heading(starting, heading + offset, pixel_x, pixel_y)

	// generate this now since all visual effects the projectile makes can use it
	effect_transform = new()
	effect_transform.Scale(trajectory.return_hypotenuse(), 1)
	effect_transform.Turn(heading)//-trajectory.return_angle())		//no idea why this has to be inverted, but it works

	transform = turn(transform, heading)//-(trajectory.return_angle() + 90)) //no idea why 90 needs to be added, but it works

/*/obj/item/projectile/overmap/setup_trajectory(turf/startloc, turf/targloc, var/x_offset = 0, var/y_offset = 0)
	..()

	//change back to pixel speed
	trajectory.offset_x /= world.icon_size
	trajectory.offset_x *= pixel_speed
	trajectory.offset_y /= world.icon_size
	trajectory.offset_y *= pixel_speed
	*/

/obj/item/projectile/proc/process_heading()
	var/first_step = 1

	//kill_count = turf_range//round(overmap_range * (world.icon_size / pixel_speed))
	//world << "launching overmap projectile with time to kill [kill_count]"

	spawn while(src && src.loc)
		if(kill_count < 1)
			on_impact(src.loc) //for any final impact behaviours
			qdel(src)
			return
		/*if((!( current ) || loc == current))
			current = locate(min(max(x + xo, 1), world.maxx), min(max(y + yo, 1), world.maxy), z)*/
		if((x == 1 || x == world.maxx || y == 1 || y == world.maxy))
			qdel(src)
			return

		trajectory.increment()	// increment the current location
		location = trajectory.return_location(location)		// update the locally stored location data

		if(!location)
			qdel(src)	// if it's left the world... kill it
			return

		//grab the updated the pixel offsets from the vector
		pixel_x = location.pixel_x
		pixel_y = location.pixel_y

		before_move()
		var/turf/oldloc = src.loc
		Move(location.return_turf())
		if(src.loc != oldloc)
			kill_count -= 1

		if(!bumped && !isturf(original))
			//world << "checke"
			if(loc == get_turf(original))
				if(!(original in permutated))
					if(Bump(original))
						return

		if(first_step)
			muzzle_effect(effect_transform)
			first_step = 0
		else if(!bumped)
			tracer_effect(effect_transform)

		if(!hitscan)
			sleep(step_delay)	//add delay between movement iterations if it's not a hitscan weapon
