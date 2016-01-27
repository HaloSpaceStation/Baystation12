
/proc/init_vehicle_transform(var/atom/movable/new_mover)
	var/datum/vehicle_transform/vehicle_transform = new()
	vehicle_transform.control_object = new_mover
	vehicle_transform.heading = dir2angle(new_mover.dir)
	new_mover.animate_movement = 0

	vehicle_transform.icon_base = new(new_mover.icon)
	vehicle_transform.icon_state = new_mover.icon_state
	vehicle_transform.icon_state_original = vehicle_transform.icon_state

	return vehicle_transform

/datum/vehicle_transform
	var/atom/movable/control_object

	var/icon/icon_base

	var/icon_state
	var/icon_state_original
	var/icon_state_thrust
	var/icon_state_brake

	var/icon/overlay_thrust_base
	var/icon/overlay_thrust

	var/obj/effect/overmapobj/vehicle/my_overmap_object
	var/icon/overmap_icon_base
	var/overmap_icon_state

	var/obj/effect/loctracker

	var/pixel_speed_x = 0
	var/pixel_speed_y = 0
	var/pixel_progress_x = 0
	var/pixel_progress_y = 0

	var/omap_pixel_x = 0
	var/omap_pixel_y = 0

	var/heading = 180

	var/pixel_speed = 0
	var/max_pixel_speed = 10

	var/list/my_observers = list()
	var/last_thrust = 0

	var/update_interval = 1
	var/main_update_start_time = -1

/datum/vehicle_transform/New()
	loctracker = new /obj/effect(src)
	loctracker.name = "loctracker"
	loctracker.layer = MOB_LAYER
	loctracker.icon = 'icons/obj/inflatable.dmi'
	loctracker.icon_state = "door_opening"

//unused for now
/*
/datum/vehicle_transform/proc/set_pixel_speed(var/new_speed_x, var/new_speed_y)
	pixel_speed_x = new_speed_x
	pixel_speed_y = new_speed_y

	if(!is_still())
		update()
		*/

/datum/vehicle_transform/proc/accelerate_forward(var/acceleration)
	add_pixel_speed_angle(acceleration, heading)

/datum/vehicle_transform/proc/brake(var/acceleration)

	//can we take a shortcut here?
	if(pixel_speed <= acceleration)
		pixel_speed_x = 0
		pixel_speed_y = 0
		pixel_speed = 0
	else
		//calculate the exact speed loss
		var/target_speed = pixel_speed - acceleration
		var/speed_multiplier = target_speed / pixel_speed

		var/accel_x = pixel_speed_x * speed_multiplier - pixel_speed_x
		var/accel_y = pixel_speed_y * speed_multiplier - pixel_speed_y

		add_pixel_speed(accel_x, accel_y)

/datum/vehicle_transform/proc/add_pixel_speed_direction(var/acceleration, var/direction)
	add_pixel_speed_angle(acceleration, dir2angle(direction))

/datum/vehicle_transform/proc/add_pixel_speed_direction_relative(var/acceleration, var/relative_direction)
	add_pixel_speed_angle(acceleration, dir2angle(relative_direction) + heading)

/datum/vehicle_transform/proc/add_pixel_speed_angle(var/acceleration, var/angle)
	//work out the x and y components according to our heading
	var/x_accel = sin(angle) * acceleration
	var/y_accel = cos(angle) * acceleration

	add_pixel_speed(x_accel, y_accel)

	if(angle == heading)
		spawn_thrust()

/datum/vehicle_transform/proc/add_pixel_speed(var/accel_x, var/accel_y)
	pixel_speed_x += accel_x
	pixel_speed_y += accel_y

	recalc_speed()
	limit_speed()

	if(!is_still())
		try_update()

/datum/vehicle_transform/proc/limit_speed()
	//work out if we're getting close to max speed
	if(max_pixel_speed > 0)
		var/total_speed = get_speed()
		//world << "current speed: [total_speed]/[max_pixel_speed]"

		//we're over max speed, so normalise then cap the speed
		if(total_speed > max_pixel_speed)
			pixel_speed_x /= total_speed
			pixel_speed_x *= max_pixel_speed
			pixel_speed_y /= total_speed
			pixel_speed_y *= max_pixel_speed
			//world << "normalised down to: [get_speed()]"

			recalc_speed()

/datum/vehicle_transform/proc/set_new_maxspeed(var/new_max_speed)
	var/total_speed = get_speed()
	max_pixel_speed = new_max_speed

	if(total_speed)
		pixel_speed_x /= total_speed
		pixel_speed_x *= max_pixel_speed
		pixel_speed_y /= total_speed
		pixel_speed_y *= max_pixel_speed
		recalc_speed()

/datum/vehicle_transform/proc/try_update()
	//world << "try_update() 1"
	//if our control_object has a custom update loop, use that
	if(istype(control_object, /obj/machinery/overmap_vehicle))
		//world << "try_update() 2"
		var/obj/machinery/overmap_vehicle/overmap_vehicle = control_object
		overmap_vehicle.update()
	else
		//world << "try_update() 3"
		//otherwise just use our internal one
		update_loop()

/datum/vehicle_transform/proc/update_loop(var/my_update_start_time = -1)

	if(main_update_start_time < 0)
		my_update_start_time = world.time
		main_update_start_time = my_update_start_time
	else if(my_update_start_time != main_update_start_time)
		return

	if(update(update_interval))
		spawn(update_interval)
			update_loop(my_update_start_time)
	else
		main_update_start_time = -1

/datum/vehicle_transform/proc/update(var/delta_time)

	if(!control_object || !control_object.loc)
		return 0

	if(is_still())
		return 0

	pixel_progress_x += pixel_speed_x * delta_time
	pixel_progress_y += pixel_speed_y * delta_time

	//apply speed
	control_object.pixel_x += round(pixel_progress_x)
	control_object.pixel_y += round(pixel_progress_y)

	//clear out old progress
	pixel_progress_x -= round(pixel_progress_x)
	pixel_progress_y -= round(pixel_progress_y)

	//move a turf on the x axis
	var/newx = control_object.x
	while(control_object.pixel_x > 16)
		newx += 1
		control_object.pixel_x -= 32
	while(control_object.pixel_x < -16)
		newx -= 1
		control_object.pixel_x += 32

	//move a turf on the y axis
	var/newy = control_object.y
	while(control_object.pixel_y > 16)
		newy += 1
		control_object.pixel_y -= 32
	while(control_object.pixel_y < -16)
		newy -= 1
		control_object.pixel_y += 32

	//if we have a separate overmap object, update it's location
	if(my_overmap_object)
		my_overmap_object.pixel_x = 32 * (control_object.x / 255) - 16
		my_overmap_object.pixel_y = 32 * (control_object.y / 255) - 16

	if(newy != control_object.y || newx != control_object.x)
		var/turf/newloc = locate(newx, newy, control_object.z)
		//var/turf/edge_turf = locate(newx + control_object.max_turf_dimx, newy + control_object.max_turf_dimy, control_object.z)
		if(newloc)
			if(!control_object.Move(newloc))
				//collide with something!
				//world << "[control_object] collided with something"
				pixel_speed_x = 0
				pixel_speed_y = 0
				pixel_speed = 0
			else
				//loctracker.loc = newloc
		else
			//we're at the edge of the map, force a space travel
			var/edgex = min(max(1, newx), 255)
			var/edgey = min(max(1, newy), 255)
			newloc = locate(edgex, edgey, control_object.z)
			overmap_controller.overmap_spacetravel(newloc, control_object)

			//preserve extra progress so we don't halt at each boundary edge causing erratic skips and jumps
			pixel_progress_x += 32 * (edgex - newx)
			pixel_progress_y += 32 * (edgey - newy)

			//call recursively with the new progress
			return update(0)

	//move observers smoothly with each pixel
	for(var/mob/M in my_observers)
		if(M.client && M.client.eye == control_object)
			M.client.pixel_x = control_object.pixel_x
			M.client.pixel_y = control_object.pixel_y
	if(my_overmap_object)
		for(var/mob/M in my_overmap_object.my_observers)
			if(M.client && M.client.eye == my_overmap_object)
				M.client.pixel_x = my_overmap_object.pixel_x
				M.client.pixel_y = my_overmap_object.pixel_y

	return 1

/datum/vehicle_transform/proc/turn_to_dir(var/target_dir, var/max_degrees)

	//world << "turn_to_dir([target_dir])"

	//proc/shortest_angle_to_dir(var/current_heading, var/target_dir, var/max_angle)
	var/rotate_angle = shortest_angle_to_dir(heading, target_dir, max_degrees)
	var/new_heading = heading + rotate_angle

	//world << "rotate_angle:[rotate_angle]"

	//world << "rotating [max_degrees] degrees from heading [heading] ([angle2dir(heading)]) to face heading [target_heading] ([angle2dir(target_heading)])"

	var/old_heading = heading

	//change the heading
	heading = new_heading
	while(heading >= 360)
		heading -= 360
	while(heading < 0)
		heading += 360

	//return the number of degrees travelled as a clockwise value
	var/degrees_travelled = new_heading - old_heading
	/*while(degrees_travelled < 0)
		degrees_travelled += 360*/

	//rotate the sprite
	if(control_object)

		var/matrix/M = matrix()
		M.Turn(heading)
		control_object.transform = M

		/*var/icon/I = new(icon_base, icon_state)
		I.Turn(heading)
		control_object.icon = I
		if(overlay_thrust_base && world.time - last_thrust <= 4)
			control_object.overlays.Remove(overlay_thrust)
			overlay_thrust = new(overlay_thrust_base)
			overlay_thrust.Turn(heading)
			control_object.overlays.Add(overlay_thrust)*/

		if(my_overmap_object)
			my_overmap_object.transform = M
			/*var/icon/C = new(overmap_icon_base, overmap_icon_state)
			C.Turn(heading)
			my_overmap_object.icon = C*/

	return degrees_travelled

/datum/vehicle_transform/proc/is_still()
	return !(pixel_speed_x || pixel_speed_y)

/datum/vehicle_transform/proc/get_speed()
	return pixel_speed

/datum/vehicle_transform/proc/recalc_speed()
	pixel_speed = sqrt(pixel_speed_x * pixel_speed_x + pixel_speed_y * pixel_speed_y)

/datum/vehicle_transform/proc/spawn_thrust()
	if(world.time - last_thrust >= 4)
		/*if(icon_state_thrust)
			icon_state = "[icon_state_thrust]"
			var/icon/I = new (icon_base, icon_state)
			//I.Turn(heading)
			control_object.icon = I
		else */if(overlay_thrust_base)
			control_object.overlays.Remove(overlay_thrust)
			overlay_thrust = new(overlay_thrust_base)
			//overlay_thrust.Turn(heading)
			control_object.overlays.Add(overlay_thrust)

	last_thrust = world.time
	spawn(4)
		check_thrust()

/datum/vehicle_transform/proc/check_thrust()
	if(world.time - last_thrust >= 4)
		if(icon_state_thrust)
			icon_state = "[icon_state_original]"
			var/icon/I = new (icon_base, icon_state)
			I.Turn(heading)
			control_object.icon = I
		else if(overlay_thrust_base)
			control_object.overlays.Remove(overlay_thrust)
	else
		spawn(4)
			check_thrust()

/datum/vehicle_transform/proc/enter_new_zlevel(var/obj/effect/overmapobj/target_obj)
	//if we have a separate overmap object, update its turf on the overmap
	if(my_overmap_object)

		//update the pixel_x offset
		my_overmap_object.pixel_x = 32 * (control_object.x / 255) - 16
		my_overmap_object.pixel_y = 32 * (control_object.y / 255) - 16
		/*if(my_overmap_object.x < target_obj.x)
			my_overmap_object.pixel_x = 0
		else if(my_overmap_object.x > target_obj.x)
			my_overmap_object.pixel_x = 32
		//update the pixel_y offset
		if(my_overmap_object.y < target_obj.y)
			my_overmap_object.pixel_y = 0
		else if(my_overmap_object.y > target_obj.y)
			my_overmap_object.pixel_y = 32*/

		//update the turf loc
		my_overmap_object.Move(target_obj.loc)
		//loctracker.loc = my_overmap_object.loc
