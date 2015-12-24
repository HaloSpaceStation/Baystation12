//the foundation of a system for differing/customisable control schemes which will be switchable ingame
//this could also be used as a generic interface between byond client macros and any form of vehicle control (overmap_vehicle or overmap ship)

/datum/vehicle_controls
	var/scheme_name = "Default control scheme"
	var/obj/machinery/overmap_vehicle/vehicle
	var/move_mode_absolute = 0

/datum/vehicle_controls/New(var/obj/machinery/overmap_vehicle/new_owner)
	vehicle = new_owner


/datum/vehicle_controls/proc/relay_move(var/mob/user, var/direction)
	if(move_mode_absolute && (direction in cardinal))
		move_vehicle(user, direction)
	else
		turn_vehicle(user, direction)

/datum/vehicle_controls/proc/turn_vehicle(var/mob/user, var/direction)
	//world << "turn_vehicle([user], [direction])"
	//only pilot can steer this bird
	if(user == vehicle.pilot && !user.stat)
		//world << "check1"

		//if we're sending diagonals, just rotate
		//var/rotate_angle = shortest_angle_to_dir(vehicle_transform.heading, diagonal_to_cardinal(direction), yaw_speed)
		var/rotate_angle = vehicle.vehicle_transform.turn_to_dir(direction, vehicle.yaw_speed)
		//world << "rotate_angle:[rotate_angle]"
		if(rotate_angle != 0)

			//update the heading
			/*heading += rotate_angle
			while(heading > 360)
				heading -= 360
			while(heading < 0)
				heading += 360*/

			//world << "rotating [heading_change * rotate_speed] degrees from heading [heading] ([angle2dir(heading)]) to face heading [target_heading] ([angle2dir(target_heading)])"

			//inform our turrets we about the new heading so they can update their targetting overlays
			for(var/obj/machinery/overmap_turret/T in vehicle.my_turrets)
				T.rotate_targetting_overlay(rotate_angle)

			//rotate the sprite
			/*var/icon/I = new (src.icon, src.icon_state)
			I.Turn(heading)
			src.icon = I*/

/datum/vehicle_controls/proc/move_vehicle(var/mob/user, var/is_absolute, var/direction)
	//access checks
	if(user && user == vehicle.pilot && !user.stat)
		//accelerate to 10% of max speed
		var/accel = 0
		if(vehicle.hovering || vehicle.no_grav())
			if(vehicle.cruising)
				accel = vehicle.cruise_speed
			else
				accel = vehicle.thruster.rate
		else
			accel = vehicle.wheels.rate
		accel /= vehicle.accel_duration

		//check move mode
		if(is_absolute)
			vehicle.vehicle_transform.add_pixel_speed_direction(accel, direction)
		else
			vehicle.vehicle_transform.add_pixel_speed_direction_relative(accel, direction)

/datum/vehicle_controls/proc/move_toggle(var/mob/user, var/direction)
	//world << "move_toggle([is_absolute], [direction])"
	if(user == vehicle.pilot && !user.stat)

		if(vehicle.move_dir)
			vehicle.move_dir = 0
		else
			vehicle.move_dir = direction
			vehicle.update()
