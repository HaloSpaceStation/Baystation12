
/turf/simulated/shuttle/hull/maglock
	name = "maglock"
	icon = 'shuttle_misc.dmi'
	icon_state = "maglock"
	desc = "For securing two large ships together so they can dock and transfer passengers or cargo."
	density = 1
	opacity = 1
	var/maglock_active = 0

/turf/simulated/wall/maglock
	name = "maglock"
	icon = 'shuttle_misc.dmi'
	icon_state = "maglock"
	desc = "For securing two large ships together so they can dock and transfer passengers or cargo."
	density = 1
	opacity = 1
	var/maglock_active = 0

/obj/structure/portalock
	name = "portable maglock"
	icon = 'shuttle_misc.dmi'
	icon_state = "arrow"//"portalock0"
	desc = "A portable maglock device to assist with modular hangar configurations."
	density = 1
	var/maglock_active = 0

/obj/structure/portalock/attack_hand(var/mob/user as mob)
	anchored = !anchored
	icon_state = "portalock[anchored]"

	var/obj/machinery/overmap_vehicle/shuttle/S = locate() in get_step(src, dir)
	if(S)
		if(anchored)
			S.add_portalock(src)
		else
			S.remove_portalock(src)

/obj/machinery/overmap_vehicle/shuttle/var/list/active_portalocks = list()
/obj/machinery/overmap_vehicle/shuttle/proc/add_portalock(var/obj/structure/portalock/P)
	active_portalocks.Add(P)
	if(active_portalocks.len >= 4)
		init_maglock()

/obj/machinery/overmap_vehicle/shuttle/proc/remove_portalock(var/obj/structure/portalock/P)
	active_portalocks.Remove(P)

/obj/machinery/overmap_vehicle/shuttle/handle_zmove(var/target_dir)
	if(is_maglocked())
		return 0

	return ..()

/*
/turf/unsimulated/shuttle_hull/maglock/proc/can_lock()
	var/turf/external_turf = my_shuttle.get_external_turf(src)
	var/strength = 0

	//if we're on a floor, 1 strength
	if(istype(external_turf, /turf/simulated/floor))
		strength += 1

	//1 strength for each adjacent wall
	for(var/turf/simulated/wall/W in range(1, external_turf))
		strength += 1

		//twice the strength for maglocks
		if(istype(external_turf, /turf/simulated/wall/maglock))
			var/turf/simulated/wall/maglock/M
			if(M.maglock_active)
				strength += 1

	return strength
*/

/obj/machinery/overmap_vehicle/shuttle/proc/get_maglock_strength()
	var/strength = 0

	//loop over turfs along the shuttle hull to figure out the total maglock strength
	var/list/checked_turfs = list()
	for(var/turf/curloc in src.locs)
		//if we're located on top of a floor, that's +1 strength
		if(istype(curloc, /turf/simulated/floor))
			strength += 1

		//check all adjacent turfs to this one
		for(var/turf/checkturf in range(1, curloc))
			//ignore this turf if we've already checked it
			if(checkturf in checked_turfs)
				continue

			//if we're adjacent to a wall, that's +1 strength
			if(istype(checkturf, /turf/simulated/wall))
				strength += 1

				//if the wall is instead an active maglock, make that +4 strength instead
				if(istype(checkturf, /turf/simulated/wall/maglock))
					var/turf/simulated/wall/maglock/M = checkturf
					if(M.maglock_active)
						strength += 3

			checked_turfs.Add(checkturf)

	return strength

/obj/machinery/overmap_vehicle/shuttle/proc/is_maglocked()
	return (src.loc == interior.loc)

/obj/machinery/overmap_vehicle/shuttle/proc/toggle_maglock(var/mob/user)
	if(src.loc == interior.loc)
		cancel_maglock(user)
	else
		init_maglock(user)



//--- Initiate Maglock ---//

/obj/machinery/overmap_vehicle/shuttle/proc/init_maglock(var/mob/user, var/forced = 0)
	//check if we've been maglocked already
	if(!is_maglocked())

		if(!forced)
			if(is_cruising())
				if(user)
					user << "<span class='info'>\icon[src] [src] cannot initiate maglock while cruising.</span>"
				return

			if(!pixel_transform.is_still())
				if(user)
					user << "<span class='info'>\icon[src] [src] cannot initiate maglock while in motion.</span>"
				return

			var/cur_maglock_strength = get_maglock_strength()
			if(cur_maglock_strength < maglock_strength)
				if(user)
					user << "<span class='info'>\icon[src] [src] cannot initiate maglock as there are not enough walls and floors nearby to maglock onto \
					(current turf strength: [cur_maglock_strength]/[maglock_strength]).</span>"
				return
			else if(user)
				user << "<span class='info'>\icon[src] [src] initiatating maglock (maglock turf strength: [cur_maglock_strength]/[maglock_strength]).</span>"

		//world << "[src] initiating maglock at ([src.x],[src.y],[src.z])"
		var/list/dest_turfs = list()
		for(var/turf/T in src.locs)
			//move them to a random nearby turf
			var/turf/D = pick(locate(src.x + rand(0,6), src.y - 1, src.z), locate(src.x - 1, src.y + rand(0,6), src.z))
			for(var/atom/movable/AM as mob|obj in T)
				if(AM == src)
					continue
				AM.Move(D)

			for(var/mob/living/carbon/bug in T) // If someone somehow is still in the shuttle's docking area...
				bug.gib()

			for(var/mob/living/simple_animal/pest in T) // And for the other kind of bug...
				pest.gib()

			dest_turfs.Add(T)

		var/list/interior_turfs = interior.get_mapped_turfs()
		while(interior_turfs.len)
			var/turf/virtual_turf = interior_turfs[1]
			interior_turfs -= virtual_turf

			//make sure we don't bring along turfs we're not supposed to
			if(istype(virtual_turf, /turf/space))
				continue
			if(istype(virtual_turf, /turf/unsimulated/blocker))
				continue

			var/turf/external_turf = get_external_turf(virtual_turf)

			swap_turfs(external_turf, virtual_turf, leave_underlay = 1)

		//loop over the changed turfs for some final stuff
		for(var/turf/simulated/shuttle/hull/S in src.locs)
			//make sure they know about us
			S.my_shuttle = src

			//if the turf above us is open, put a "roof" turf there so the shuttle doesn't vent
			var/turf/above = GetAbove(S)
			if(above && (istype(above, /turf/simulated/floor/open) || istype(above, /turf/space)))
				above.ChangeTurf(/turf/simulated/shuttle/hull/floor)
				var/turf/simulated/shuttle/hull/floor/H = above
				H.my_shuttle = src
				H.name = "[shuttle_area] roof"
				H.icon_state = "wall"

		//move the shuttle object into the virtual area so it isnt observed
		src.loc = interior.loc



//--- Cancel Maglock ---//

/obj/machinery/overmap_vehicle/shuttle/proc/cancel_maglock(var/mob/user)
	if(is_maglocked())

		if(user)
			user << "<span class='info'>\icon[src] [src] is cancelling the maglock.</span>"

		//find the lowest corner turf
		var/turf/bottom_left
		var/list/interior_turfs = list()
		for(var/turf/T in shuttle_area)
			interior_turfs.Add(T)
			if(!bottom_left)
				bottom_left = T
			else if(T.x < bottom_left.x || T.y < bottom_left.y)
				bottom_left = T

				//while we're here, check if this shuttle turf has a "roof" above it
				var/turf/above = GetAbove(T)
				if(above && istype(above, /turf/simulated/shuttle/hull))
					var/turf/simulated/shuttle/hull/H = above

					//if this roof is part of our shuttle, replace it with open space
					if(H.my_shuttle == src)
						H.ChangeTurf(/turf/simulated/floor/open)


		//now loop them over and move them relative to the bottom left corner
		while(interior_turfs.len)
			var/turf/interior_turf = interior_turfs[1]

			interior_turfs -= interior_turf

			var/turf/virtual_turf = get_internal_turf(interior_turf, bottom_left)

			swap_turfs(interior_turf, virtual_turf)

		//loop over the changed turfs and tell any newly created shuttle hulls about us
		for(var/turf/simulated/shuttle/hull/S in src.locs)
			S.my_shuttle = src

		//move the shuttle object into the virtual area so it isnt observed
		src.loc = bottom_left
