
/obj/machinery/overmap_vehicle
	name = "vehicle"
	desc = "A vehicle"
	icon = 'longsword_test.dmi'
	icon_state = "longsword_test0"
	dir = 1
	density = 1
	anchored = 1
	layer = MOB_LAYER

	var/hovering_underlay = "hovering"

	var/list/passengers = list()
	var/max_passengers = 0
	var/hovering = 0
	var/move_dir = 0
	var/move_mode_absolute = 0

	var/mob/living/pilot

	var/landing_gear_extended = 1
	var/extendable_landing_gear = 0

	var/armour = 100
	var/hull_remaining = 100
	var/hull_max = 100
	var/max_speed = 32			//pixels per ms
	var/max_speed_hover = 10
	var/accel_duration = 10		//how long until max speed in ms
	var/yaw_speed = 5

	var/datum/vehicle_transform/vehicle_transform

	var/default_controlscheme_type = /datum/vehicle_controls
	var/datum/vehicle_controls/vehicle_controls

	var/list/my_turrets = list()
	var/list/my_observers = list()

	var/main_update_start_time = -1
	var/update_interval = 1

	var/next_shot_loc = 0

	//forward motion on nongravity/space turfs
	//pixels per sec
	var/datum/overmap_vehicle_component/thruster = new()
	//turn rate on nongravity/space turfs
	//degrees per sec
	var/datum/overmap_vehicle_component/thruster_turn = new()
	//forward motion on on gravity turfs
	//pixels per sec
	var/datum/overmap_vehicle_component/wheels = new()
	//turn rate on gravity turfs
	//degrees per sec
	var/datum/overmap_vehicle_component/wheels_turn = new()
	//speed in slipspace
	//pixels tiles per sec
	var/datum/overmap_vehicle_component/slipspace = new()
	//main energy generator
	//watts per sec
	var/datum/overmap_vehicle_component/power_gen = new()

/obj/machinery/overmap_vehicle/New()
	InitComponents()
	//processing_objects.Add(src)

	vehicle_transform = init_vehicle_transform(src)
	vehicle_transform.my_observers = my_observers
	vehicle_transform.heading = dir2angle(dir)
	vehicle_transform.max_pixel_speed = max_speed

	vehicle_controls = new default_controlscheme_type(src)

	layer += 0.1

//obj/machinery/overmap_vehicle/process()

	/*var/delta_time = world.time - time_last_process
	time_last_process = world.time*/

	//if(hovering)
		//check fuel

	//if(move_dir from gravity turfs to nongravity turfs)
	//	lose control unless we have space capable thrusters

	//if(move_dir from nongravity turfs to nongravity turfs)
		//if(check to see if we fall 1 or more zlevels)
			//move down zlevels
			//take falling damage when we eventually hit
			//unless it's space, in which case transfer to overmap and start drifting away from the ship
		//else if(if we are stationary)
			//just settle nice and gently onto the ground

		//if(abs(O.pixel_speed_x) + abs(O.pixel_speed_y) <= 32)

/obj/machinery/overmap_vehicle/proc/InitComponents()
	//setup component verbs here
	if(thruster && thruster.rate)
		verbs += /datum/overmap_vehicle_component/verb/enable_hover
	//setup component stats in child objs

/obj/machinery/overmap_vehicle/relaymove(mob/user, direction)
	vehicle_controls.relay_move(user, direction)

/obj/machinery/overmap_vehicle/proc/vehicle_thrust(var/mob/user)
	vehicle_controls.move_vehicle(user, move_mode_absolute, NORTH)

/obj/machinery/overmap_vehicle/proc/vehicle_thrust_toggle(var/mob/user)
	vehicle_controls.move_toggle(user, move_mode_absolute, NORTH)

/obj/machinery/overmap_vehicle/proc/update(var/my_update_start_time = -1)

	if(!src || !src.loc)
		main_update_start_time = -1
		return

	if(main_update_start_time < 0)
		my_update_start_time = world.time
		main_update_start_time = my_update_start_time
	else if(my_update_start_time != main_update_start_time)
		return

	var/continue_update = 0

	//apply thrust if we've got it toggled on
	if(move_dir)
		continue_update = 1
		vehicle_controls.move_vehicle(pilot, move_mode_absolute, move_dir)

	//update the sprite
	if(vehicle_transform.update(update_interval))
		continue_update = 1

	//only spawn another update if there's something that needs updating
	if(continue_update)
		spawn(update_interval)
			update(my_update_start_time)
	else
		main_update_start_time = -1

/*/obj/machinery/overmap_vehicle/proc/thrust(var/thrust_direction)
	//standard checks
	if(thruster && thruster.integrity > 0 && thruster.rate > 0)
		//check fuel
		//

		if(dir_last_update)
			dir_next_update = dir_last_update | thrust_direction
		dir_last_update |= thrust_direction

		//world << "move_dir in dir [direction]"

/obj/machinery/overmap_vehicle/proc/ground_thrust(var/thrust_direction)
	//standard checks
	if(wheels && wheels.integrity > 0 && wheels.rate > 0)
		//check fuel
		//

		//check if we have traction
		//

		world << "move_dir in dir [thrust_direction]"*/

/obj/machinery/overmap_vehicle/proc/set_landing_gear(var/extended)
	if(extendable_landing_gear)
		landing_gear_extended = extended
		if(landing_gear_extended)
			visible_message("[src] extends its landing gear.")
			verbs -= /datum/overmap_vehicle_component/verb/extend_landing_gear
			verbs += /datum/overmap_vehicle_component/verb/retract_landing_gear
		else
			visible_message("[src] retracts its landing gear.")
			verbs -= /datum/overmap_vehicle_component/verb/retract_landing_gear
			verbs += /datum/overmap_vehicle_component/verb/extend_landing_gear

/obj/machinery/overmap_vehicle/proc/set_hovering(var/hovering_state)
	if(hovering_state)
		if(thruster && thruster.rate > 0)
			if(thruster.integrity > 0)
				usr << "<span class='info'>You switch the thrusters over to hover mode.</span>"
				hovering = 1
				vehicle_transform.max_pixel_speed = max_speed_hover
				verbs -= /datum/overmap_vehicle_component/verb/enable_hover
				verbs += /datum/overmap_vehicle_component/verb/disable_hover
				if(hovering_underlay)
					underlays += hovering_underlay
			else
				usr << "<span class='info'>Thrusters are too damaged to enter hover mode.</span>"
		else
			verbs -= /datum/overmap_vehicle_component/verb/enable_hover
	else
		//let's do a safety check if we're not going fast enough to stay aloft
		if(vehicle_transform.get_speed() <= 32)
			if(alert("Please confirm you want to disable hovering at this time", "Disable hover alert", "Continue", "Cancel")  == "Cancel")
				return
		usr << "<span class='info'>You switch the thrusters from hover mode to thrust mode.</span>"
		hovering = 0
		vehicle_transform.max_pixel_speed = max_speed
		verbs -= /datum/overmap_vehicle_component/verb/disable_hover
		if(thruster && thruster.rate > 0)
			verbs += /datum/overmap_vehicle_component/verb/enable_hover
		if(hovering_underlay)
			underlays -= hovering_underlay

/obj/machinery/overmap_vehicle/bullet_act(obj/item/projectile/P, def_zone)
	//todo: chance of component damage on hit
	//todo: targetting of specific components via def_zone
	if(P.damage >= armour)
		hull_remaining -= P.damage / armour
		health_update()

/obj/machinery/overmap_vehicle/proc/health_update()
	if(hull_remaining <= 0)
		//destroy the vehicle
		var/turf/centre_turf = get_step(src.loc, NORTHEAST)		//spawn the explosion on the centre turf
		for(var/mob/M in contents)
			M.loc = get_step_rand(centre_turf)
			M.unset_machine()
		//	proc/explosion(turf/epicenter, devastation_range, heavy_impact_range, light_impact_range, flash_range, adminlog = 1)
		qdel(src)
		explosion(centre_turf, 2, 3, 4, 5)

/obj/machinery/overmap_vehicle/proc/fall()
	//fall!
	visible_message("<span class='warning'><b>[src] drops out of the air!</b></span>")

	//process() will handle destruction checks
	//todo: actually move the vehicle down zlevels if it is high above the ground
	//todo: scale damage with number of zlevels fallen
	hull_remaining -= 10

/obj/machinery/overmap_vehicle/proc/no_grav()
	//just check if we're in space or not
	var/turf/T = get_turf(src)
	if(T.is_space())
		return 1

	return 0

/obj/machinery/overmap_vehicle/verb/enter()
	set name = "Enter vehicle"
	set category = "Object"
	set src in oview(1)

	if(ishuman(usr))
		if(isturf(src.loc))
			if(usr.loc != src)
				usr << "<span class='info'><b>You enter [src].</b></span>"
				usr.loc = src
				if(!pilot)
					pilot = usr
					pilot.set_machine(src)
					usr << "<span class='info'>You are now the pilot!.</span>"
				my_observers.Add(usr)
				if(usr.client)
					usr.client.view = 14//world.view
			else
				usr << "<span class='info'>You are already inside [src].</span>"
		else
			usr << "<span class='info'>You cannot reach [src] from here.</span>"
	else
		usr << "<span class='info'>You are unable to enter [src].</span>"

/obj/machinery/overmap_vehicle/verb/exit()
	set name = "Exit vehicle"
	set category = "Vehicle"
	set src = usr.loc

	usr.loc = src.loc
	usr << "<span class='info'><b>You exit [src].</b></span>"
	my_observers.Remove(usr)
	if(pilot == usr)
		pilot.unset_machine()
		pilot = null
		usr << "<span class='info'>You are no longer the pilot!.</span>"
	my_observers -= usr
	if(usr.client)
		usr.client.view = world.view
		usr.client.eye = usr

//just stop motion, we can worry about even decelleration later
/obj/machinery/overmap_vehicle/verb/halt()
	set name = "Halt movement"
	set category = "Vehicle"
	set src = usr.loc

	vehicle_transform.pixel_speed_x = 0
	vehicle_transform.pixel_speed_y = 0

/obj/machinery/overmap_vehicle/verb/check_speed()
	set name = "Get speed"
	set category = "Vehicle"
	set src = usr.loc

	usr << "[src] is currently going at [vehicle_transform.get_speed()]"
