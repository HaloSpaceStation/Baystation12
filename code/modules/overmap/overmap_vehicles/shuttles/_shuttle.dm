
/obj/machinery/overmap_vehicle/shuttle
	name = "SKT-13 Shuttlecraft"
	icon = 'code/modules/overmap/overmap_vehicles/shuttles/unsc_perp_shuttle.dmi'
	icon_state = "shuttle"
	desc = "Unarmed UNSC personnel transport."
	dir = NORTH
	anchored = 1
	bound_width = 192
	bound_height = 384
	max_speed = 10
	iff_faction_broadcast = "UNSC"
	var/layout_file = 'maps/ships/shuttle_unscpersonnel1.dmm'
	var/layout_x = 6
	var/layout_y = 12
	var/overmap_icon_state = "unsc_shuttle"

	var/obj/effect/zlevelinfo/current_level
	var/area/shuttle_area
	var/obj/effect/virtual_area/interior
	var/list/pilots = list()
	var/num_turfs = 50
	var/maglock_strength = 6

	var/time_last_maneuvre = 0
	var/maneuvre_cooldown = 15

	armour = 75
	hull_default = 250

	var/maglocked_at_spawn = 0
	var/dir_after_init = NORTH

/obj/machinery/overmap_vehicle/shuttle/New()
	..()

	overmap_object.icon_state = overmap_icon_state
	layer = MOB_LAYER - 0.1

	vehicle_controls.move_mode_absolute = 1

/obj/machinery/overmap_vehicle/shuttle/proc/init_interior()

	//grab a temp zlevel and use it to hold our "inside"
	if(!interior)
		interior = overmap_controller.get_virtual_area()

		//load the shuttle map over the top
		maploader.load_onto_turf(layout_file, interior.loc)
		interior.map_dimx = layout_x
		interior.map_dimy = layout_y

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

		//tell all powered objects to recheck
		for(var/obj/machinery/power/apc/apc in shuttle_area)
			shuttle_area.apc = apc
			shuttle_area.power_change()

/obj/machinery/overmap_vehicle/shuttle/initialize()
	..()

	init_interior()

	//there isn't an easy way to do multitile atom rotation in the map editor
	//this handles it after server startup but before roundstart
	var/turf/oldloc = src.loc
	while(src.dir != dir_after_init)
		turn_towards_dir(dir_after_init, 1)
		sleep(1)

	//reset our position so the "turning" in the map editor is based off the bottom left corner
	src.loc = oldloc

	if(maglocked_at_spawn)
		init_maglock()

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

/obj/machinery/overmap_vehicle/shuttle/enable_engines()
	if(!engines_cycling)
		if(!engines_active)
			engines_cycling = 1

			//play sound for occupants
			for(var/mob/M in shuttle_area)
				M.playsound_local_custom(M.loc, 'sound/machines/Spacecraft_Start_Engines_SE.ogg', 100, 1, 3, 5)

			//play sound for people nearby
			playsound_custom(src, 'sound/machines/Spacecraft_Start_Engines_SE.ogg', 100, 1, 3, 5)

			//5 second powerup sequence (15 sec played at 3x speed)
			spawn(50)
				engines_active = 1
				overmap_controller.overmap_scanner_manager.add_overmap_vehicle(overmap_object)
				engines_cycling = 0
			return 1

	return 0

/obj/machinery/overmap_vehicle/shuttle/disable_engines()
	if(!engines_cycling)
		if(engines_active)
			engines_cycling = 1

			//play sound for occupants
			for(var/mob/M in shuttle_area)
				M.playsound_local_custom(M.loc, 'sound/machines/Spacecraft_Start_Engines_SE.ogg', 100, 1, -3, 5)

			//play sound for people nearby
			playsound_custom(src, 'sound/machines/Spacecraft_Start_Engines_SE.ogg', 100, 1, -3, 5)

			//5 second powerdown sequence (15 sec played at 3x speed)
			spawn(50)
				engines_active = 0
				overmap_controller.overmap_scanner_manager.remove_overmap_vehicle(overmap_object)
				engines_cycling = 0
				return 1

	return 0
