
/obj/machinery/overmap_vehicle/var/last_bump = 0
/obj/machinery/overmap_vehicle/Bump(atom/Obstacle)

	//interval timer so the proc doesn't call multiple times per collision
	if(world.time > last_bump + 0.5)
		last_bump = world.time

		var/myspeed = pixel_transform.get_speed()

		//take up to 100% hull damage at top speed collision, but reduced by armour
		if(myspeed > PIXEL_IMPACT_SPEED)
			var/damage = 100 * hull_max * (myspeed / PIXEL_CRASH_SPEED) / armour
			hull_remaining -= damage

			//"\icon[Obstacle] <span class='danger'>[src] collides with [Obstacle] and takes [damage] damage ([hull_remaining]/[hull_max])!</span>"
			impact_occupants_major()

			health_update()

		else if(myspeed > PIXEL_KNOCK_SPEED)
			//"\icon[Obstacle] <span class='danger'>[src] bumps into [Obstacle]!</span>"
			impact_occupants_minor()

/obj/machinery/overmap_vehicle/proc/impact_occupants_minor(var/impact_message)
	//space means we can't use the ordinary sound procs so we have to do custom ones
	var/sound/S = sound('sound/effects/Glasshit.ogg')
	S.volume = 100
	S.frequency = get_rand_frequency()
	S.falloff = 5
	S.environment = PADDED_CELL

	for(var/mob/M in occupants)
		M << S
		if(impact_message)
			M << impact_message
		shake_camera(M, 1, 1)

/obj/machinery/overmap_vehicle/proc/impact_occupants_major(var/impact_message)
	//space means we can't use the ordinary sound procs so we have to do custom ones
	var/sound/S = sound('sound/effects/meteorimpact.ogg')
	S.volume = 100
	S.frequency = get_rand_frequency()
	S.falloff = 5
	S.environment = PADDED_CELL

	for(var/mob/M in occupants)
		M << S
		if(impact_message)
			M << impact_message
		shake_camera(M, 3, 3)

/obj/machinery/overmap_vehicle/proc/message_viewers(var/message, var/occupants_message)
	var/list/viewers = view(src, 7)
	if(occupants_message)
		viewers -= my_observers
		for(var/mob/M in my_observers)
			M << occupants_message

	for(var/mob/M in viewers)
		M << message
