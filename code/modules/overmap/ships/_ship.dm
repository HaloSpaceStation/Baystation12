
/obj/effect/overmapobj/ship
	name = "starship"
	desc = "Space faring vessel."
	icon = 'code/modules/overmap/ships/corvette.dmi'
	icon_state = "base"

	var/fore_dir = NORTH
	var/list/ship_levels = list()
	var/list/ship_turfs = list()
	var/ship_name = "UNSC Test Ship Please Ignore"

	var/obj/effect/overmapobj/current_sector
	var/obj/machinery/computer/helm/nav_control
	var/obj/machinery/computer/engines/eng_control

	var/obj/effect/overlay/target_overlay
	var/icon/frigate_icon

	var/vessel_mass = 60000 //tonnes
	var/mass_multiplier = 50
	var/highest_x_turf = 0
	var/lowest_x_turf = 0
	var/highest_y_turf = 0
	var/lowest_y_turf = 0
	var/center_x = 0
	var/center_y = 0

	var/datum/vehicle_transform/vehicle_transform

	var/move_mode_absolute = 0

	var/yaw_speed = 2	//degrees per tick
	var/max_pixel_speed = 5
	var/forward_acceleration = 0.1
	var/thrusting = 0

	var/main_update_start_time = -1
	var/update_interval = 5
	var/autobraking = 0

	var/list/loctrackers = list()

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

/obj/effect/overmapobj/ship/New()
	for(var/obj/machinery/computer/engines/E in machines)
		if (E.z in ship_levels)
			eng_control = E
			break
	/*for(var/obj/machinery/computer/helm/H in machines)
		if (H.z in ship_levels)
			nav_control = H
			break*/

	while(loctrackers.len < 16)
		var/obj/effect/loctracker = new /obj/effect(src)
		loctracker.name = "loctracker"
		loctracker.layer = MOB_LAYER
		loctracker.icon = 'icons/obj/inflatable.dmi'
		loctracker.icon_state = "door_opening"
		loctrackers.Add(loctracker)

	processing_objects.Add(src)

/obj/effect/overmapobj/ship/process()
	var/index = 1
	for(var/turf/T in locs)
		var/obj/effect/loctracker = loctrackers[index]
		loctracker.loc = T
		index++

/obj/effect/overmapobj/ship/overmap_init()
	vehicle_transform = init_vehicle_transform(src)
	vehicle_transform.max_pixel_speed = max_pixel_speed
	vehicle_transform.heading = dir2angle(src.dir)
	vehicle_transform.my_observers = my_observers
	vehicle_transform.icon_state_thrust = "thrust"
	vehicle_transform.icon_state_brake = "brake"

	//don't bother doing physics based acceleration and turning
	//we'll just hardcode the values and tweak them as needed
	//recalculate_physics_properties()

/obj/effect/overmapobj/ship/relaymove(mob/user, direction)
	if(move_mode_absolute && (direction in cardinal))
		accelerate(user, direction)
	else
		var/rotate_angle = vehicle_transform.turn_to_dir(direction, yaw_speed)
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

			//rotate the sprite
			/*var/icon/I = new (src.icon, src.icon_state)
			I.Turn(heading)
			src.icon = I*/

/obj/effect/overmapobj/ship/proc/accelerate(var/accel_dir)

	//an accel_heading of 0 represents right (EAST) on the overmap
	//here we adjust it by ship heading to get the actual dir on the ship zlevel
	var/adjusted_heading = dir2angle(accel_dir) - vehicle_transform.heading
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

/obj/effect/overmapobj/ship/proc/adjust_speed(n_x, n_y)

	vehicle_transform.add_pixel_speed(n_x, n_y)

	//toggle the stars "moving"
	for(var/shipz in ship_levels)
		if(is_still())
			overmap_controller.toggle_move_stars(shipz)
		else
			overmap_controller.toggle_move_stars(shipz, fore_dir)

	//heading = -Atan2(speed[1], speed[2]) - 90

/obj/effect/overmapobj/ship/proc/toggle_autobrake()
	autobraking = !autobraking
	thrusting = 0
	thrust_loop()

/obj/effect/overmapobj/ship/proc/thrust_forward_toggle()
	thrusting = !thrusting
	autobraking = 0
	thrust_loop()

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

	if(thrusting)
		thrust_forward()

		spawn(update_interval)
			thrust_loop(my_update_start_time)

	else if(autobraking)
		brake()

		spawn(update_interval)
			thrust_loop(my_update_start_time)

	else
		main_update_start_time = -1

/obj/effect/overmapobj/ship/proc/thrust_forward()
	//acceleration in meters per second
	//var/acceleration = eng_control.get_maneuvring_thrust() / vessel_mass

	//use pixels per microsecond instead
	vehicle_transform.accelerate_forward(get_acceleration(NORTH))

/obj/effect/overmapobj/ship/proc/brake()
	vehicle_transform.brake(get_acceleration(SOUTH))

/obj/effect/overmapobj/ship/proc/is_still()
	return vehicle_transform.is_still()

/obj/effect/overmapobj/ship/proc/get_acceleration(var/accel_dir)
	//return eng_control.get_maneuvring_thrust(accel_dir) / vessel_mass
	return forward_acceleration

/obj/effect/overmapobj/ship/proc/get_speed()
	return vehicle_transform.get_speed()

/obj/effect/overmapobj/ship/proc/get_heading()
	return vehicle_transform.heading

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
