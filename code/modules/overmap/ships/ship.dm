
/obj/effect/map/ship
	name = "generic ship"
	desc = "Space faring vessel."
	icon = 'code/modules/overmap/ships/ships.dmi'
	icon_state = "frigate"
	var/default_delay = 60
	var/list/speed = list(0,0)
	var/last_burn = 0
	var/list/last_movement = list(0,0)
	var/fore_dir = NORTH
	var/list/ship_levels = list()
	var/list/ship_turfs = list()
	var/sectorname = "Generic Space Vessel"

	var/obj/effect/map/current_sector
	var/obj/machinery/computer/helm/nav_control
	var/obj/machinery/computer/engines/eng_control

	var/obj/effect/overlay/target_overlay
	var/icon/frigate_icon
	var/is_thrusting = 0
	var/is_thrusting_exhaust = 0

	var/vessel_mass = 0 //tonnes
	var/mass_multiplier = 30
	var/highest_x_turf = 0
	var/lowest_x_turf = 0
	var/highest_y_turf = 0
	var/lowest_y_turf = 0
	var/center_x = 0
	var/center_y = 0

	var/last_update = 0
	var/pixel_x_progress = 0
	var/pixel_y_progress = 0
	var/max_speed = 4
	animate_movement = 0

/obj/effect/map/ship/initialize()
	for(var/obj/machinery/computer/engines/E in machines)
		if (E.z in ship_levels)
			eng_control = E
			break
	for(var/obj/machinery/computer/helm/H in machines)
		if (H.z in ship_levels)
			nav_control = H
			break
	processing_objects.Add(src)

	recalculate_physics_properties()

/obj/effect/map/ship/New(var/obj/effect/mapinfo/data)
	tag = "ship_[data.sectorname]"
	map_z = data.z

	name = data.name
	sectorname = data.sectorname
	always_known = data.known
	if (data.icon != 'icons/mob/screen1.dmi')
		icon = data.icon
		icon_state = data.icon_state
	if(data.desc)
		desc = data.desc
	var/new_x = data.mapx ? data.mapx : rand(OVERMAP_EDGE, world.maxx - OVERMAP_EDGE)
	var/new_y = data.mapy ? data.mapy : rand(OVERMAP_EDGE, world.maxy - OVERMAP_EDGE)
	loc = locate(new_x, new_y, OVERMAP_ZLEVEL)

	if(data.landing_area)
		shuttle_landing = locate(data.landing_area)

/obj/effect/map/ship/proc/recalculate_physics_properties()
	//calculate physics properties

	//first, loop over the zlevel and work out the dimensions and mass
	vessel_mass = 0

	for(var/curz in src.ship_levels)
		for(var/curx = 1 to world.maxx)
			for(var/cury = 1 to world.maxy)
				//we don't care about space turfs
				var/turf/T = locate(curx, cury, curz)

				if(istype(T, /turf/simulated/))
					//expand the dimensions
					if(curx > highest_x_turf)
						highest_x_turf = curx
					else if(curx < lowest_x_turf)
						lowest_x_turf = curx
					if(cury > highest_y_turf)
						highest_y_turf = curx
					else if(cury < lowest_y_turf)
						lowest_y_turf = curx

					//we'll only use turfs to calculate total mass
					if(istype(T, /turf/simulated/wall/r_wall))
						vessel_mass += 3 * mass_multiplier
					else if(istype(T, /turf/simulated/wall))
						vessel_mass += 2 * mass_multiplier
					else
						vessel_mass += 1 * mass_multiplier

	var/dif_x = highest_x_turf - lowest_x_turf
	var/dif_y = highest_y_turf - lowest_y_turf
	center_x = highest_x_turf - dif_x / 2
	center_y = highest_y_turf - dif_y / 2

	//a = angular acceleration
	//aT = linear tangential acceleration
	//let aT = engine force * vessel mass (pretend it's automatically oriented at a tangent)
	//r = distance from center
	//a = aT / r

/obj/effect/map/ship/proc/update_spaceturfs()
	set background = 1
	for(var/turf/space/S in world)
		if(S.z in src.ship_levels)
			ship_turfs.Add(S)

/obj/effect/map/ship/relaymove(mob/user, direction)
	//accelerate forward and apply torque towards desired direction
	if(direction in cardinal)
		accelerate(direction)
	else
		//first, work out which direction we want to rotate in
		var/target_heading = 0
		var/heading_change = 0
		switch(direction)
			if(NORTHEAST)
				target_heading = 0
				if(heading < 180)
					heading_change = -1
				else
					heading_change = 1
			if(SOUTHEAST)
				target_heading = 90
				if(heading < 90 || heading > 270)
					heading_change = 1
				else
					heading_change = -1
			if(SOUTHWEST)
				target_heading = 180
				if(heading < 180)
					heading_change = 1
				else
					heading_change = -1
			if(NORTHWEST)
				target_heading = 270
				if(heading < 90 || heading > 270)
					heading_change = -1
				else
					heading_change = 1

		if(heading_change && heading != target_heading)

			//update the heading
			var/rotate_speed = 10
			var/new_heading = heading + heading_change * rotate_speed
			if(abs(target_heading - new_heading) < rotate_speed)
				new_heading = target_heading

			//world << "rotating [heading_change * rotate_speed] degrees from heading [heading] ([angle2dir(heading)]) to face heading [target_heading] ([angle2dir(target_heading)])"

			//inform our turrets we about the new heading so they can update their targetting overlays
			for(var/obj/machinery/overmap_turret/T in my_turrets)
				T.rotate_targetting_overlay(new_heading - heading)

			//change the heading
			heading = new_heading
			while(heading > 360)
				heading -= 360
			while(heading < 0)
				heading += 360

			//rotate the sprite
			var/icon/I = new /icon('code/modules/overmap/ships/ships.dmi', src.icon_state)
			I.Turn(heading)
			src.icon = I

/obj/effect/map/ship/proc/is_still()
	return !(speed[1] || speed[2])

/obj/effect/map/ship/proc/get_acceleration(var/accel_dir)
	return eng_control.get_maneuvring_thrust(accel_dir) / vessel_mass

/obj/effect/map/ship/proc/get_speed()
	return sqrt(speed[1]*speed[1] + speed[2]*speed[2])

/obj/effect/map/ship/proc/get_heading()
	return heading

	//return heading in increments of 45
	/*var/res = 0
	if(speed[1])
		if(speed[1] > 0)
			res |= EAST
		else
			res |= WEST
	if(speed[2])
		if(speed[2] > 0)
			res |= NORTH
		else
			res |= SOUTH
	return res*/

/obj/effect/map/ship/proc/adjust_speed(n_x, n_y)
	speed[1] = Clamp(speed[1] + n_x, -default_delay, default_delay)
	speed[2] = Clamp(speed[2] + n_y, -default_delay, default_delay)
	for(var/shipz in ship_levels)
		if(is_still())
			overmap_controller.toggle_move_stars(shipz)
		else
			overmap_controller.toggle_move_stars(shipz, fore_dir)

	heading = -Atan2(speed[1], speed[2]) - 90

/obj/effect/map/ship/proc/can_burn()
	if (!eng_control)
		return 0
	if (world.time < last_burn + 10)
		return 0
	if (!eng_control.burn())
		return 0
	return 1

/obj/effect/map/ship/proc/get_brake_path()
	if(!get_acceleration(SOUTH))
		return INFINITY
	return max(abs(speed[1]),abs(speed[2]))/get_acceleration(SOUTH)

#define SIGN(X) (X == 0 ? 0 : (X > 0 ? 1 : -1))
/obj/effect/map/ship/proc/decelerate()
	if(!is_still() && can_burn())
		if (speed[1])
			adjust_speed(-SIGN(speed[1]) * min(get_acceleration(),abs(speed[1])), 0)
		if (speed[2])
			adjust_speed(0, -SIGN(speed[2]) * min(get_acceleration(),abs(speed[2])))
		last_burn = world.time

/obj/effect/map/ship/proc/accelerate(var/accel_dir)
	if(can_burn())
		last_burn = world.time

		//an accel_heading of 0 represents right (EAST) on the overmap
		//here we adjust it by ship heading to get the actual dir on the ship zlevel
		var/adjusted_heading = dir2angle(accel_dir) - heading
		if(adjusted_heading < 0)
			adjusted_heading += 360

		var/adjusted_dir = angle2dir(adjusted_heading)
		if(accel_dir & EAST)
			adjust_speed(get_acceleration(adjusted_dir), 0)
		if(accel_dir & WEST)
			adjust_speed(-get_acceleration(adjusted_dir), 0)
		if(accel_dir & NORTH)
			adjust_speed(0, get_acceleration(adjusted_dir))
		if(accel_dir & SOUTH)
			adjust_speed(0, -get_acceleration(adjusted_dir))

/obj/effect/map/ship/process()
	//if there's a 3 second delay, start a new update loop
	if(world.time - last_update > 30)
		update()

	/*if(!is_still())
		src.pixel_x += speed[1]
		src.pixel_y += speed[2]*/

		/*var/list/deltas = list(0,0)
		for(var/i=1, i<=2, i++)
			if(speed[i] && world.time > last_movement[i] + default_delay - speed[i])
				deltas[i] = speed[i] > 0 ? 1 : -1
				last_movement[i] = world.time
		var/turf/newloc = locate(x + deltas[1], y + deltas[2], z)
		if(newloc)
			dir = get_dir(src, newloc)
			Move(newloc)*/

/obj/effect/map/ship/proc/update(var/start_time = 0)
	last_update = world.time
	if(!start_time)
		start_time = world.time

	pixel_x_progress += speed[1]
	pixel_y_progress += speed[2]

	//apply speed
	pixel_x += round(pixel_x_progress)
	pixel_x_progress -= round(pixel_x_progress)
	pixel_y += round(pixel_y_progress)
	pixel_y_progress -= round(pixel_y_progress)

	//move a turf on the x axis
	var/newx = src.x
	while(pixel_x > 16)
		newx += 1
		pixel_x -= 32
	while(pixel_x < -16)
		newx -= 1
		pixel_x += 32

	//move a turf on the y axis
	var/newy = src.y
	while(pixel_y > 16)
		newy += 1
		pixel_y -= 32
	while(pixel_y < -16)
		newy -= 1
		pixel_y += 32

	if(newy != src.y || newx != src.x)
		var/turf/newloc = locate(newx, newy, src.z)
		if(newloc)
			src.loc = newloc

	//smooth out client movement so the screen isn't constantly jumping around the place
	for(var/mob/M in my_observers)
		if(M.client && M.client.eye == src)
			M.client.pixel_x = src.pixel_x
			M.client.pixel_y = src.pixel_y
		else
			my_observers -= M

	spawn(1)
		update(start_time)

/obj/effect/map/ship/proc/thrust_forward()
	var/acceleration = eng_control.get_maneuvring_thrust() / vessel_mass

	//work out the x and y components according to our heading
	var/x_accel = sin(heading) * acceleration
	var/y_accel = cos(heading) * acceleration

	/*world << "accelerating for [acceleration] pixels/sec on heading [heading]"
	world << "	x acceleration: [x_accel] pixels/sec"
	world << "	y acceleration: [y_accel] pixels/sec"*/

	//accelerate
	speed[1] += x_accel
	speed[2] += y_accel

	//work out if we're getting close to max speed
	var/total_speed = get_speed()

	if(total_speed > max_speed)
		//we're over max speed, so normalise then cap the speed
		speed[1] /= total_speed
		speed[1] *= max_speed
		speed[2] /= total_speed
		speed[2] *= max_speed

	//cap speed at 10 turfs per second for now
	speed[1] = min(speed[1], max_speed)
	speed[1] = max(speed[1], -max_speed)
	speed[2] = min(speed[2], max_speed)
	speed[2] = max(speed[2], -max_speed)

	if(!is_thrusting)
		is_thrusting = 1
		var/icon_state_original = icon_state
		var/icon/I = new /icon('code/modules/overmap/ships/ships.dmi', "[icon_state]_thrust")
		I.Turn(heading)
		src.icon = I

		spawn(4)
			is_thrusting = 0
			I = new /icon('code/modules/overmap/ships/ships.dmi', "[icon_state_original]")
			I.Turn(heading)
			src.icon = I
