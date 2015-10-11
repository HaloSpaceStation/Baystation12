
/obj/structure/ladder
	name = "ladder"
	desc = "A ladder.  You climb up and down it."
	icon = 'icons/obj/structures.dmi'
	icon_state = "ladder-0"
	density = 0
	opacity = 0
	anchored = 0
	var/zdir = 0

/obj/structure/ladder/New()
	. = ..()

	var/dash = findtext(icon_state, "-")
	zdir = text2num( copytext(icon_state, dash + 1) ) & (UP|DOWN)

/obj/structure/ladder/ex_act(severity)
	switch(severity)
		if(1.0)
			if(prob(10))
				qdel(src)
				var/obj/item/stack/rods/R = PoolOrNew(/obj/item/stack/rods, src.loc)
				R.amount = 2
		if(2.0)
			if(prob(50))
				qdel(src)
				var/obj/item/stack/rods/R = PoolOrNew(/obj/item/stack/rods, src.loc)
				R.amount = 2
		if(3.0)
			qdel(src)
			var/obj/item/stack/rods/R = PoolOrNew(/obj/item/stack/rods, src.loc)
			R.amount = 2
	return

/obj/structure/ladder/attackby(obj/item/C as obj, mob/user as mob)
	if(istype(C, /obj/item/stack/rods))
		var/obj/item/stack/rods/S = C
		if(S.amount < 2)
			user << "<span class='notice'>You dont have enough rods to extend the ladder upwards.</span>"
			return
		else if(zdir & UP)
			user << "<span class='notice'>The ladder is already extended upwards as far as it can go.</span>"
			return
		else
			user << "<span class='info'>You start extending the ladder upwards...</span>"

		if(!do_after(user, 30) || !C)
			return

		S.use(2)
		zdir |= UP
		icon_state = "ladder-[zdir]"
		user << "<span class='info'>You extend the ladder upwards, securing it to the roof.</span>"
		anchored = 1

		return

	else if(istype(C, /obj/item/weapon/wrench))
		if(zdir & DOWN)
			user << "<span class='notice'>You start loosening the  ladder to the floor...</span>"
		else
			user << "<span class='notice'>You start securing the ladder to the floor...</span>"
		playsound(src.loc, 'sound/items/Ratchet.ogg', 100, 1)

		if(!do_after(user, 30) || !C)
			return

		if(zdir & DOWN)
			user << "<span class='info'>You remove the bolts anchoring the ladder.</span>"
			if( !(zdir & UP) )
				anchored = 0
		else
			anchored = 1
			user << "<span class='info'>You secure the bolts anchoring the ladder.</span>"
		zdir ^= DOWN
		icon_state = "ladder-[zdir]"

		return

	else if(istype(C, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = C
		if(WT.remove_fuel(1, user))

			user << "<span class='notice'>You begin to deconstruct the ladder.</span>"
			playsound(src.loc, 'sound/items/Welder.ogg', 100, 1)

			if(!do_after(user, 50) || !WT || !WT.isOn())
				return

			var/obj/item/stack/rods/R = PoolOrNew(/obj/item/stack/rods, src.loc)
			R.amount = 2
			if(zdir & UP)
				user << "<span class='info'>You deconstruct the top of the ladder.</span>"
				zdir ^= UP
				icon_state = "ladder-[zdir]"

				//once we remove the ladder, force any mobs standing on it to fall
				if(HasAbove(src.z))
					var/turf/above = locate(src.x, src.y, src.z - 1)
					for(var/mob/living/M in above)
						above.Enter(M)

			else
				user << "<span class='info'>You deconstruct the ladder.</span>"
				//once we remove the ladder, force any mobs standing on it to fall
				var/turf/curturf = get_turf(src)
				for(var/mob/living/M in curturf)
					curturf.Enter(M)
				qdel(src)
		else
			user << "<span class='notice'>You need more welding fuel to complete this task.</span>"
		return

	. = ..(C, user)

/obj/structure/ladder/proc/attempt_traverse(var/mob/M, var/movedir = 0)

	add_fingerprint(M)

	//check if the ladder has been setup to lead somewhere
	if(zdir)
		//check if we already know what direction we want to go
		if(movedir && HasAboveBelow(src.z, movedir))
			//check if the ladder works in that direction
			if(movedir & zdir)
				var/turf/curturf = get_turf(src)
				var/turf/T = GetAboveBelow(src, movedir)

				//check whether there is floor or wall in the way
				var/turf/block_turf = curturf.CanPass(M, T)
				if(!block_turf || !istype(block_turf) || !block_turf.blocks_air_downwards)
					//check if transit to that zlevel is actually enabled
					if(HasAboveBelow(curturf.z, movedir))
						if(block_turf && istype(block_turf))
							M << "<span class='notice'>\icon[block_turf] [block_turf] is blocking the top of [src].</span>"
						else
							var/obj/structure/ladder/L = locate(/obj/structure/ladder/) in T

							//if we're going up, we need a ladder above us
							var/success = 0
							if(movedir == UP)
								if(L)
									success = 1
									M.visible_message("<span class='notice'>[M] climbs up \the [src]!</span>", \
							 		"<span class='notice'>You climb up \the [src]!</span>")
								else
									M << "<span class='notice'>[src] does not reach high enough to get to the floor above.</span>"
							else
								success = 1
								M.visible_message("<span class='notice'>[M] climbs down \the [src]!</span>", \
								"<span class='notice'>You climb down \the [src]!</span>")
								//hit the ground with a bang if we fall onto a floor below
								if(!L && !istype(T, /turf/space))
									M << "<span class='warning'>[src] does not reach all the way down and you drop the rest of the way.</span>"
									playsound(curturf, 'sound/machines/door_close.ogg', 100, 1)

							if(success)
								M.Move(curturf)
								if(M.loc == curturf)
									return M.Move(T)
					else
						M << "<span class='notice'>There is nothing interesting [movedir == UP ? "up" : "down"] there.</span>"
				else
					M << "<span class='notice'>[block_turf] is in the way, you must cut a hole in it with a welder first.</span>"
			else
				M << "<span class='notice'>[src] does not go in that direction.</span>"
		else
			if(zdir ^ (UP|DOWN))
				//there's only one direction to go
				movedir = zdir
			else
				//there's two directions, so we'll ask the player
				var/textdir = input("Which direction?","Traverse ladder", "Up") in list("Up", "Down", "Cancel")
				switch(textdir)
					if("Up")
						movedir = UP
					if("Down")
						movedir = DOWN
					else
						return
			//try again with a proper direction
			if(HasAboveBelow(src.z, movedir))
				attempt_traverse(M, movedir)
	else
		M << "<span class='warning'>[src] is not connected to anything.</span>"

	return 0

/obj/structure/ladder/proc/attempt_ascend(var/mob/M)
	return attempt_traverse(M, UP)

/obj/structure/ladder/proc/attempt_descend(var/mob/M)
	return attempt_traverse(M, DOWN)

/obj/structure/ladder/attack_hand(var/mob/M)
	attempt_traverse(M)
