
/obj/effect/overmapobj/ship
	name = "starship"
	desc = "Space faring vessel."
	icon = 'code/modules/overmap/ships/corvette.dmi'
	icon_state = "base"
	hide_vehicles = 1

	var/fore_dir = NORTH
	var/list/ship_levels = list()
	var/list/ship_turfs = list()
	var/ship_name = "UNSC Test Ship Please Ignore"

	var/obj/effect/overmapobj/current_sector
	var/obj/machinery/computer/helm/nav_control
	var/obj/machinery/computer/engines/eng_control

	var/obj/effect/overlay/target_overlay
	var/icon/frigate_icon

	var/zlevel_stars_movedir = 0	//if a direction is set, space turf stars are moving in that direction
	var/vessel_mass = 60000 //tonnes
	var/mass_multiplier = 50
	var/highest_x_turf = 0
	var/lowest_x_turf = 0
	var/highest_y_turf = 0
	var/lowest_y_turf = 0
	var/center_x = 0
	var/center_y = 0

	var/datum/pixel_transform/pixel_transform

	var/move_mode_absolute = 0

	var/yaw_speed = 2	//degrees per tick
	var/max_pixel_speed = 5
	var/omni_acceleration = 0.1		//quick hack now to skip directional acceleration
	var/thrusting = 0
	var/orient_to_target = 0
	var/target_dir = 0

	var/main_update_start_time = -1
	var/update_interval = 5
	var/autobraking = 0

	sensor_icon_state = "gunboat_s"
	init_sensors = 1

	//var/list/loctrackers = list()

/*/obj/effect/overmapobj/ship/New(var/obj/effect/overmapobjinfo/data)
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

	/*if(data.landing_area)
		shuttle_landing = locate(data.landing_area)*/*/

/*
/obj/effect/overmapobj/ship/New()
	..()
	for(var/obj/machinery/computer/engines/E in machines)
		if (E.z in ship_levels)
			eng_control = E
			break
	/*for(var/obj/machinery/computer/helm/H in machines)
		if (H.z in ship_levels)
			nav_control = H
			break*/

	//uncomment this for airlock sprites following the capital ship around showing it's turf overlaps
	/*
	while(loctrackers.len < 16)
		var/obj/effect/loctracker = new /obj/effect(src)
		loctracker.name = "loctracker"
		loctracker.layer = MOB_LAYER
		loctracker.icon = 'icons/obj/inflatable.dmi'
		loctracker.icon_state = "door_opening"
		loctrackers.Add(loctracker)
		*/

	//processing_objects.Add(src)

	..()
	*/

/obj/effect/overmapobj/ship/initialize()
	overmap_controller.overmap_scanner_manager.add_ship(src)

/*
/obj/effect/overmapobj/ship/process()
	var/index = 1
	for(var/turf/T in locs)
		var/obj/effect/loctracker = loctrackers[index]
		loctracker.loc = T
		index++
		*/

/obj/effect/overmapobj/ship/overmap_init()
	..()

	pixel_transform = init_pixel_transform(src)
	pixel_transform.max_pixel_speed = max_pixel_speed
	pixel_transform.heading = dir2angle(src.dir)
	pixel_transform.my_observers = my_observers
	pixel_transform.icon_state_thrust = "thrust"
	pixel_transform.icon_state_brake = "brake"

	//don't bother doing physics based acceleration and turning
	//we'll just hardcode the values and tweak them as needed
	//recalculate_physics_properties()

/obj/effect/overmapobj/ship/proc/set_zlevel_stars_movedir(var/new_zlevel_stars_movedir = 1)
	var/old_movedir = new_zlevel_stars_movedir
	zlevel_stars_movedir = new_zlevel_stars_movedir
	if(old_movedir != zlevel_stars_movedir)
		update_zlevel_stars_movedir()

/obj/effect/overmapobj/ship/proc/update_zlevel_stars_movedir()
	var/is_still = is_still()
	if(zlevel_stars_movedir)
		if(is_still)
			for(var/shipz in ship_levels)
				overmap_controller.toggle_move_stars(shipz)
	else
		if(!is_still)
			for(var/shipz in ship_levels)
				overmap_controller.toggle_move_stars(shipz, zlevel_stars_movedir)

/obj/effect/overmapobj/ship/relaymove(var/mob/user, direction)
	thrust_toggle(user, direction)
	/*
	if(move_mode_absolute && (direction in cardinal))
		accelerate(user, direction)
	else
		var/rotate_angle = pixel_transform.turn_to_dir(direction, yaw_speed)
		if(rotate_angle != 0)
			//update the heading
			/*heading += rotate_angle
			while(heading > 360)
				heading -= 360
			while(heading < 0)
				heading += 360*/

			//world << "rotating [heading_change * rotate_speed] degrees from heading [heading] ([angle2dir(heading)]) to face heading [target_heading] ([angle2dir(target_heading)])"

			//inform our turrets we about the new heading so they can update their targetting overlays
			for(var/obj/machinery/overmap_turret/T in my_turrets)
				T.rotate_targetting_overlay(rotate_angle)
				*/

			//rotate the sprite
			/*var/icon/I = new (src.icon, src.icon_state)
			I.Turn(heading)
			src.icon = I*/
/*
/obj/effect/overmapobj/ship/proc/accelerate(var/accel_dir)

	//an accel_heading of 0 represents right (EAST) on the overmap
	//here we adjust it by ship heading to get the actual dir on the ship zlevel
	var/adjusted_heading = dir2angle(accel_dir) - pixel_transform.heading
	if(adjusted_heading < 0)
		adjusted_heading += 360

	var/adjusted_dir = angle2dir(adjusted_heading)
	if(accel_dir & EAST)
		adjust_speed(get_acceleration_dir(adjusted_dir), 0)
	if(accel_dir & WEST)
		adjust_speed(-get_acceleration_dir(adjusted_dir), 0)
	if(accel_dir & NORTH)
		adjust_speed(0, get_acceleration_dir(adjusted_dir))
	if(accel_dir & SOUTH)
		adjust_speed(0, -get_acceleration_dir(adjusted_dir))

/obj/effect/overmapobj/ship/proc/adjust_speed(n_x, n_y)

	pixel_transform.add_pixel_speed(n_x, n_y)

	//toggle the stars "moving"
	for(var/shipz in ship_levels)
		if(is_still())
			overmap_controller.toggle_move_stars(shipz)
		else
			overmap_controller.toggle_move_stars(shipz, fore_dir)

	//heading = -Atan2(speed[1], speed[2]) - 90
*/
/obj/effect/overmapobj/ship/proc/toggle_autobrake()
	autobraking = !autobraking
	if(autobraking)
		thrusting = 0
		thrust_loop()

/obj/effect/overmapobj/ship/proc/thrust_toggle(var/mob/user, var/thrust_dir)
	if(thrusting != thrust_dir)
		thrusting = thrust_dir
		if(thrusting)
			autobraking = 0
			thrust_loop()
	else
		thrusting = 0

/*
/obj/effect/overmapobj/ship/proc/thrust_forward()
	//acceleration in meters per second
	//var/acceleration = eng_control.get_maneuvring_thrust() / vessel_mass

	//use pixels per microsecond instead
	pixel_transform.accelerate_forward(get_acceleration_dir(angle2dir(pixel_transform.heading)))
*/

/obj/effect/overmapobj/ship/proc/thrust_forward_toggle(var/mob/user)
	if(thrusting >= 0)
		thrusting = -1
		autobraking = 0
		thrust_loop()
	else
		thrusting = 0

/obj/effect/overmapobj/ship/proc/do_orient_to_dir(var/mob/user, var/new_dir)
	target_dir = new_dir
	orient_to_target = 1
	thrust_loop()

/obj/effect/overmapobj/ship/proc/cancel_orient_to_dir(var/mob/user)
	orient_to_target = 0
	target_dir = 0

//todo: should this be moved out to the vehicle_control datum?
/obj/effect/overmapobj/ship/proc/thrust_loop(var/my_update_start_time = -1)
	if(!src || !src.loc)
		main_update_start_time = -1
		return

	if(main_update_start_time < 0)
		my_update_start_time = world.time
		main_update_start_time = my_update_start_time
	else if(my_update_start_time != main_update_start_time)
		return

	if(thrusting < 0)
		//accelerate forward on the heading
		pixel_transform.add_pixel_speed_forward(get_acceleration_dir(-1))
	else if(thrusting > 0)
		//accelerate in absolute direction
		pixel_transform.add_pixel_speed_direction(get_acceleration_dir(thrusting), thrusting)

	if(autobraking)
		autobraking = brake()

	if(orient_to_target)
		if(!pixel_transform.turn_to_dir(target_dir, yaw_speed))
			orient_to_target = 0

	if(thrusting || autobraking || orient_to_target)
		spawn(update_interval)
			thrust_loop(my_update_start_time)

	else
		main_update_start_time = -1

/obj/effect/overmapobj/ship/proc/brake()
	var/reverse_angle = turn(pixel_transform.heading, 180)
	var/reverse_dir = angle2dir(reverse_angle)		//this will clamp it to cardinal directions so there is a slight acceptable loss of accuracy
	return pixel_transform.brake(get_acceleration_dir(reverse_dir))

/obj/effect/overmapobj/ship/proc/is_still()
	return pixel_transform.is_still()

/obj/effect/overmapobj/ship/proc/get_acceleration_dir(var/accel_dir)
	//return eng_control.get_maneuvring_thrust(accel_dir) / vessel_mass
	return omni_acceleration

/obj/effect/overmapobj/ship/proc/get_speed()
	return pixel_transform.get_speed()

/obj/effect/overmapobj/ship/proc/get_heading()
	return pixel_transform.heading

/obj/effect/overmapobj/ship/proc/update_spaceturfs()
	set background = 1
	for(var/obj/effect/zlevelinfo/zlevelinfo in src.ship_levels)
		for(var/curx = 1 to world.maxx)
			for(var/cury = 1 to world.maxy)
				//we don't care about space turfs
				var/turf/T = locate(curx, cury, zlevelinfo.z)
				ship_turfs.Add(T)

/obj/effect/overmapobj/ship/proc/recalculate_physics_properties()
	//calculate physics properties

	//first, loop over the zlevel and work out the dimensions and mass
	vessel_mass = 1
	var/curx = 0
	var/cury = 0

	for(var/turf/T in ship_turfs)

		//we don't care about space turfs
		if(istype(T, /turf/simulated/))
			if(!curx)
				curx = T.x
			if(!cury)
				cury = T.y

			//expand the dimensions
			if(curx > highest_x_turf)
				highest_x_turf = curx
			else if(curx < lowest_x_turf)
				lowest_x_turf = curx
			//
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
