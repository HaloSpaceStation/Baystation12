
/obj/machinery/overmap_vehicle/verb/take_control()
	set name = "Take control"
	set category = "Vehicle"
	set src = usr.loc

	if(isliving(usr))
		make_pilot(usr)
	return 0

//just stop motion, we can worry about even decelleration later
//todo: replace this with a proper autobrake
/*
/obj/machinery/overmap_vehicle/verb/halt()
	set name = "Halt movement"
	set category = "Vehicle"
	set src = usr.loc

	if(is_cruising())
		usr << "You must exit cruise before you can halt"
	else
		pixel_transform.pixel_speed_x = 0
		pixel_transform.pixel_speed_y = 0
		pixel_transform.pixel_speed = 0
		*/

/obj/machinery/overmap_vehicle/verb/enable_autobrake()
	set name = "Enable Autobrake"
	set category = "Vehicle"
	set src = usr.loc

	if(is_cruising())
		usr << "\icon[src] <span class='warning'>You must exit cruise before you can enable autobraking.</span>"
	else
		autobraking = 1
		move_forward = 0
		usr << "\icon[src] <span class='info'>Autobraking...</span>"

/obj/machinery/overmap_vehicle/verb/enter()
	set name = "Enter vehicle"
	set category = "Vehicle"
	set src in oview(1)

	if(ishuman(usr))
		var/mob/user = usr
		if(isturf(src.loc))
			if(user.loc != src)
				if(occupants_max < 1 || occupants.len < occupants_max)
					//todo: check for active jetpacks and disable the ion trail
					user.loc = src
					if(user.client)
						user.client.view = 14//double the default world.view which is 7, and dont go any larger than this
						user << "<span class='info'><b>You enter [src].</b></span>"
					user.set_machine(src)
					check_eye(user)
					occupants.Add(user)

					if(!pilot)
						make_pilot(user)

					return 1
				else
					usr << "<span class='warning'>[src] is full, it can only hold [occupants_max] people.</span>"
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
		hud_waypoint_controller.remove_hud_from_mob(pilot)
		overmap_object.hud_waypoint_controller.remove_hud_from_mob(pilot)
		pilot = null
		disable_engines()
		usr << "\icon[src] <span class='info'>You are no longer the pilot!</span>"

	occupants -= usr
	my_observers -= usr
	if(usr.client)
		usr.client.view = world.view
		usr.client.eye = usr

	if(is_cruising())
		//this should handle all of the sector detection and placement logic
		overmap_controller.spawn_to_sector(overmap_object.loc, usr, overmap_object)

	//call movement related procs
	src.loc.Enter(usr)

/obj/machinery/overmap_vehicle/verb/check_speed()
	set name = "Get speed"
	set category = "Vehicle"
	set src = usr.loc

	var/speed
	if(is_cruising())
		speed = "[world.maxx * cruise_speed / 32] (cruising)"
	else
		speed = "[pixel_transform.get_speed()]"

	usr << "\icon[src] [src] is currently going at [speed]"

/obj/machinery/overmap_vehicle/verb/toggle_iff_scanner()
	set name = "Toggle fighter IFF scanner"
	set category = "Vehicle"
	set src = usr.loc

	var/mob/user = usr
	if(user == pilot)
		if(hud_waypoint_controller.remove_hud_from_mob(user) || overmap_object.hud_waypoint_controller.remove_hud_from_mob(user))
			user << "\icon[src] Identify friend/foe sensors toggled <span class='warning'>OFF</span>"
		else
			if(usr.client)
				if(usr.client.eye == src)
					hud_waypoint_controller.add_hud_to_mob(user)
				else if(usr.client.eye == overmap_object)
					overmap_object.hud_waypoint_controller.add_hud_to_mob(user)
			user << "\icon[src] Identify friend/foe sensors toggled <span class='notice'>ON</span>"
	else
		user << "<span class='warning'>You are not the pilot of [src]</span>"

/obj/machinery/overmap_vehicle/verb/cycle_iff_colours()
	set name = "Cycle IFF colours"
	set category = "Vehicle"
	set src = usr.loc

	var/mob/user = usr
	if(user == pilot)
		//switch the colours
		user << cycle_iff_colours()
	else
		user << "<span class='warning'>You are not the pilot of [src]</span>"

/obj/machinery/overmap_vehicle/verb/move_upwards()
	set name = "Move up a level"
	set category = "Vehicle"
	set src = usr.loc

	if(usr == pilot)
		if(z_move)
			z_move = 0
		else if(src.HasAbove())
			usr << "\icon[src] <span class='info'>You start to move up a level...</span>"
			z_move = 1
		else
			usr << "<span class='warning'>There is nothing of interest up there.</span>"
	else
		usr << "<span class='warning'>You are not the pilot of [src]</span>"

/obj/machinery/overmap_vehicle/verb/move_downwards()
	set name = "Move down a level"
	set category = "Vehicle"
	set src = usr.loc

	if(usr == pilot)
		if(z_move)
			z_move = 0
		else if(src.HasBelow())
			usr << "\icon[src] <span class='info'>You start to move down a level...</span>"
			z_move = -1
		else
			usr << "<span class='warning'>There is nothing of interest down there.</span>"
	else
		usr << "<span class='warning'>You are not the pilot of [src]</span>"

/obj/machinery/overmap_vehicle/verb/cycle_airlock_exterior()
	set name = "Cycle airlock to exterior"
	set category = "Vehicle"
	set src = usr.loc

	var/obj/machinery/embedded_controller/radio/airlock/airlock_controller/target_controller

	var/list/targets = list()
	for(var/obj/machinery/embedded_controller/radio/airlock/airlock_controller/controller in range(20, src))
		targets.Add(controller)

	if(targets.len == 1)
		//just autopick if there's only 1 possible option
		target_controller = targets[1]
	else if(targets.len > 1)
		targets.Add("Cancel")
		target_controller = input("Select a hangar airlock to cycle outwards.", "Target hangar airlock") in targets
	else
		usr << "<span class='warning'>No valid hangar airlocks detected in range (50m).</span>"

	if(!target_controller || !istype(target_controller))
		return

	if(!istype(target_controller.program, /datum/computer/file/embedded_program/airlock))
		usr << "<span class='warning'>That airlock type is not configured for vehicle access.</span>"
		return

	switch(target_controller.program:target_state)
		if(0)
			target_controller.program.receive_user_command("cycle_ext")
			usr << "\icon[target_controller] <span class='info'>Command sent to [target_controller] to CYCLE EXTERIOR, please be patient while it executes.</span>"
		if(-1)
			usr << "\icon[target_controller] <span class='warning'>[target_controller] is already executing a command to CYCLE INTERIOR.</span>"
		if(-2)
			usr << "\icon[target_controller] <span class='warning'>[target_controller] is already executing a command to CYCLE EXTERIOR.</span>"

/obj/machinery/overmap_vehicle/verb/cycle_airlock_interior()
	set name = "Cycle airlock to interior"
	set category = "Vehicle"
	set src = usr.loc

	var/obj/machinery/embedded_controller/radio/airlock/airlock_controller/target_controller

	var/list/targets = list()
	for(var/obj/machinery/embedded_controller/radio/airlock/airlock_controller/controller in range(20, src))
		targets.Add(controller)

	if(targets.len == 1)
		//just autopick if there's only 1 possible option
		target_controller = targets[1]
	else if(targets.len > 1)
		targets.Add("Cancel")
		target_controller = input("Select a hangar airlock to cycle inwards.", "Target hangar airlock") in targets
	else
		usr << "<span class='warning'>No valid hangar airlocks detected in range (50m).</span>"

	if(!target_controller || !istype(target_controller))
		return

	if(!istype(target_controller.program, /datum/computer/file/embedded_program/airlock))
		usr << "<span class='warning'>That airlock type is not configured for vehicle access.</span>"
		return

	switch(target_controller.program:target_state)
		if(0)
			target_controller.program.receive_user_command("cycle_int")
			usr << "\icon[target_controller] <span class='info'>Command sent to [target_controller] to CYCLE INTERIOR, please be patient while it executes.</span>"
		if(-1)
			usr << "\icon[target_controller] <span class='warning'>[target_controller] is already executing a command to CYCLE INTERIOR.</span>"
		if(-2)
			usr << "\icon[target_controller] <span class='warning'>[target_controller] is already executing a command to CYCLE EXTERIOR.</span>"
