//the foundation of a system for differing/customisable control schemes which will be switchable ingame
//this could also be used as a generic interface between byond client macros and any form of vehicle control (overmap_vehicle or overmap ship)
//currently only overmap_vehicle is setup to use this, so its a little bit gimmicky and redundant, but maybe one day...

/datum/vehicle_controls
	var/scheme_name = "Default control scheme"
	var/obj/machinery/overmap_vehicle/vehicle
	var/move_mode_absolute = 0

/datum/vehicle_controls/New(var/obj/machinery/overmap_vehicle/new_owner)
	vehicle = new_owner

/datum/vehicle_controls/proc/relay_move(var/mob/user, var/direction)
	//world << "/datum/vehicle_controls/proc/relay_move([user], [direction])"
	if(move_mode_absolute)
		move_vehicle(user, direction)
	else
		turn_vehicle(user, direction)

/datum/vehicle_controls/proc/relay_face(var/mob/user, var/direction)
	turn_vehicle(user, direction)

/datum/vehicle_controls/proc/turn_vehicle(var/mob/user, var/direction)

	//if we're sending diagonals, just rotate
	var/rotate_angle = 0
	var/datum/pixel_transform/target_pixel_transform = vehicle.pixel_transform
	if(vehicle.is_cruising())
		target_pixel_transform = vehicle.overmap_object.pixel_transform

	rotate_angle = target_pixel_transform.turn_to_dir(direction, vehicle.yaw_speed)
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

/datum/vehicle_controls/proc/move_vehicle(var/mob/user, var/direction)
	//world << "/datum/vehicle_controls/proc/move_vehicle([user], [direction])"
	//accelerate to 10% of max speed
	var/accel = 0
	if(move_mode_absolute)
		//world << "	check1"
		accel = vehicle.get_absolute_directional_thrust(direction)		//north = north on the map
	else
		accel = vehicle.get_relative_directional_thrust(direction)		//north = front of the shuttle

	var/datum/pixel_transform/target_pixel_transform = vehicle.pixel_transform
	if(vehicle.is_cruising())
		target_pixel_transform = vehicle.overmap_object.pixel_transform

	//check move mode
	if(move_mode_absolute)
		//world << "	check2"
		target_pixel_transform.add_pixel_speed_direction(accel, direction)
	else
		target_pixel_transform.add_pixel_speed_direction_relative(accel, direction)

/datum/vehicle_controls/proc/move_vehicle_forward(var/mob/user)
	var/accel = vehicle.get_relative_directional_thrust(NORTH)
	var/datum/pixel_transform/target_pixel_transform = vehicle.pixel_transform
	if(vehicle.is_cruising())
		target_pixel_transform = vehicle.overmap_object.pixel_transform
	target_pixel_transform.add_pixel_speed_direction_relative(accel, NORTH)

/datum/vehicle_controls/proc/move_toggle(var/mob/user, var/direction)
	//world << "move_toggle([is_absolute], [direction])

	if(vehicle.move_dir)
		vehicle.move_dir = 0
	else
		vehicle.move_dir = direction
		vehicle.update()
