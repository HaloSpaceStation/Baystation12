
/obj/machinery/overmap_vehicle/shuttle
	name = "SKT-13 Shuttlecraft"
	icon = 'unsc_perp_shuttle.dmi'
	icon_state = "unsc_personnel"
	dir = NORTH
	anchored = 1
	bound_width = 192
	bound_height = 384
	max_speed = 5
	iff_faction_broadcast = "UNSC"

	var/obj/effect/zlevelinfo/current_level
	var/area/shuttle_area
	var/obj/effect/virtual_area/interior
	var/list/pilots = list()
	var/num_turfs = 50
	var/maglock_strength = 0

	var/time_last_maneuvre = 0
	var/maneuvre_cooldown = 30

	armour = 75
	hull_remaining = 250
	hull_max = 250

/obj/machinery/overmap_vehicle/shuttle/New()
	..()

	//grab a temp zlevel and use it to hold our "inside"
	if(!interior)
		interior = overmap_controller.get_virtual_area()

		//load the shuttle map over the top
		maploader.load_onto_turf('maps/shuttle_unscpersonnel1.dmm', interior.loc)
		//maploader.load_onto_turf('maps/unsc_personnel_shuttle1.dmm', locate(interior.x, interior.y, interior.z))
		interior.map_dimx = 6
		interior.map_dimy = 12

		maglock_strength = 6

	overmap_object.icon_state = "unsc_shuttle"
	layer = MOB_LAYER - 0.1

	vehicle_controls.move_mode_absolute = 1

	//create an area for the shuttle interior to make handling a lot of stuff easier
	shuttle_area = new
	shuttle_area.name = src.name
	for(var/xoffset = 0, xoffset < overmap_controller.virtual_area_dims, xoffset++)
		for(var/yoffset = 0, yoffset < overmap_controller.virtual_area_dims, yoffset++)
			var/turf/curturf = locate(interior.x + xoffset, interior.y + yoffset, interior.z)
			if(!istype(curturf, /turf/space) && !istype(curturf, /turf/unsimulated/blocker))
				shuttle_area.contents.Add(curturf)

				//the turfs need to know about the shuttle so they can handle stuff like interaction and explosions
				if(istype(curturf, /turf/simulated/shuttle/hull))
					var/turf/simulated/shuttle/hull/S = curturf
					S.my_shuttle = src

				//create lighting overlays
				if(!curturf.lighting_overlay)
					var/atom/movable/lighting_overlay/O = PoolOrNew(/atom/movable/lighting_overlay, curturf)
					curturf.lighting_overlay = O

				//do initializations for any atoms (should this be in load_onto_turf?)
				for(var/atom/movable/A in curturf)
					A.initialize()
					//tell any helm computers about us
					if(istype(A, /obj/machinery/computer/shuttle_helm))
						var/obj/machinery/computer/shuttle_helm/S = A
						S.my_shuttle = src

					if(istype(A, /obj/machinery/door/airlock/external/shuttle))
						var/obj/machinery/door/airlock/external/shuttle/S = A
						S.my_shuttle = src

				//reset air levels on this turf because loading seems to loses a bit of air for some reason
				//curturf.make_air()

				//mark the turf to be updated for atmos later
				air_master.mark_for_update(curturf)

	//world << "shuttle map loaded with [num_new_lighting_overlays] new lighting overlays created"

	//work out some final init stuff
	calc_num_turfs()

/obj/machinery/overmap_vehicle/shuttle/Destroy()
	..()
	//todo: clean up our inside turfs

/obj/machinery/overmap_vehicle/shuttle/proc/calc_num_turfs()
	if(shuttle_area)
		for(var/turf/simulated/T in shuttle_area)
			num_turfs += 1

	//let acceleration duration just be equivalent to number of turfs
	//let's say +1ms per turf
	//bonus engines reduce this instead of increasing max speed
	accel_duration = num_turfs

/*
/obj/machinery/overmap_vehicle/shuttle/relaymove(mob/user, direction)
	//allow ordinary pixel movement forwards and backwards
	if(direction & (src.dir) || direction & turn(src.dir, 180))
		//vehicle_controls.move_vehicle(user, direction)
		src.vehicle_controls.move_vehicle(user, direction)
	else
		//otherwise use ordinary turf based movement for strafing
		strafe_dir = direction
		spawn(strafe_chargeup)
			if(strafe_dir == direction)
				src.Move(get_step(src,direction))
*/

/obj/machinery/overmap_vehicle/shuttle/get_relative_directional_thrust(var/direction = NORTH)
	//north = front of the shuttle

	//max_speed = initial_velocity + max_accel * time
	//max_speed = max_accel * accel_duration
	//:. max_accel = max_speed / accel_duration
	var/max_accel = max_speed / accel_duration

	var/num_engines = 0
	if(shuttle_area)
		//just use the engines as props for the moment, don't worry about fuel or power etc
		for(var/obj/structure/shuttle/engine/E in shuttle_area)
			//dont worry about directional checks for now, just check all the engines
			//if(direction == E.dir)
			num_engines += 1

	//let's say 1 engine per 10 turfs for max speed
	//force = mass * acceleration
	//thrust = num_turfs * accel
	//accel = num_turfs / thrust

	var/accel_multiplier = min((10 * num_engines) / num_turfs, 1)
	return max_accel * accel_multiplier

/obj/machinery/overmap_vehicle/shuttle/get_absolute_directional_thrust(var/direction)
	//north = north on the map
	//we've got to "reorient" which way is north
	var/angle_offset = dir2angle(src.dir)
	var/adjusted_direction = turn(direction, angle_offset)

	return get_relative_directional_thrust(adjusted_direction)

/obj/machinery/overmap_vehicle/shuttle/make_pilot(var/mob/living/H)
	//handle piloting differently to other vehicle types
	return

//this proc doesn't safety check! make sure you pass it a turf in the virtual space only, and only when the shuttle is not maglocked
/obj/machinery/overmap_vehicle/shuttle/proc/get_external_turf(var/turf/internal_turf)
	var/turf/external_turf

	//get the native turf offsets to calculate the external turf
	var/native_offset_x = min(internal_turf.x - interior.x, round(bound_width / 32))
	var/native_offset_y = min(internal_turf.y - interior.y, round(bound_height / 32))

	external_turf = locate(src.x + native_offset_x, src.y + native_offset_y, src.z)
	return external_turf

//this proc doesn't safety check! make sure you pass it the correct corner turf
/obj/machinery/overmap_vehicle/shuttle/proc/get_internal_turf(var/turf/external_turf, var/turf/external_corner_turf)
	var/turf/internal_turf

	//get the native turf offsets to calculate the external turf
	//these assume the shuttle is facing north (mapped shuttles should always face north, the shuttle object itself can rotate around)
	var/native_offset_x = min(external_turf.x - external_corner_turf.x, round(bound_width / 32))
	var/native_offset_y = min(external_turf.y - external_corner_turf.y, round(bound_height / 32))

	internal_turf = locate(interior.x + native_offset_x, interior.y + native_offset_y, interior.z)
	return internal_turf

/obj/machinery/overmap_vehicle/shuttle/handle_auto_moving()
	if(move_dir)
		if(is_cruising())
			return ..()

		else if(is_maglocked())
			//don't try to turn if maglocked
			move_dir = 0

		else
			//moving straight ahead or behind uses pixel based movement
			if(move_dir == src.dir || move_dir == turn(src.dir, 180))
				return ..()

			else if(world.time > time_last_maneuvre + maneuvre_cooldown)
				//automated strafing uses ordinary turf based movement
				var/olddir = src.dir
				src.Move(get_step(src, move_dir))
				src.dir = olddir

				//limit how often we can strafe
				time_last_maneuvre = world.time

			return  1

	return 0
