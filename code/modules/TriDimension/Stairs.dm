
/turf/simulated/floor/stairs
	name = "Stairs"
	desc = "Stairs.  You walk up and down them."
	icon = 'icons/turf/floors.dmi'
	icon_state = "stairs"
	layer = 1.9
	var/atom/movable/lastmove

//unlike a normal open space turf, hide everything like normal floors do
/turf/simulated/floor/stairs/levelupdate()
	for(var/obj/O in src)
		if(O.level == 1)
			O.hide(1)

//disable this for now, because people are getting trapped inside large stairwells
/*
/turf/simulated/floor/stairs/Enter(atom/movable/O)
	. = 1
	//nothing can enter from "behind" the staircase
	if(O.z == src.z && O.dir == turn(src.dir, 180))
		O << "<span class='notice'>You cannot enter [src] from this side.</span>"
		return 0
		*/

/turf/simulated/floor/stairs/Exit(atom/movable/O)
	. = 1

	//only try to send it up a level if its heading "up" the stairs from the perspective of the sprite
	if(O.dir == src.dir)
		//this is to avoid infinite recursion loops
		//so long as byond doesn't add multithreading this should be safe (so we're basically good for the lifetime of ss13)
		if(O != lastmove)
			//return 0 here so we don't travel in a 2d cardinal direction instead of moving up a level
			. = 0
			var/turf/above = GetAbove(src)
			if(above)
				for(var/obj/obstacle in above)
					if(!obstacle.CanPass(O, above))
						O << "<span class='notice'>Your way up is blocked by \the [obstacle].</span>"
						return 0
				if(istype(above, /turf/simulated/floor/open))
					var/turf/target = get_step(above, dir)
					for(var/obj/obstacle in target)
						if(!obstacle.CanPass(O, target))
							O << "<span class='notice'>The top of \the [src] is blocked by \the [obstacle].</span>"
							return 0

					//if there's an open space next to the stairs, we'll stop short of going into it
					if(istype(target, /turf/simulated/floor/open))
						target = above
					if(!target.density)
						lastmove = O
						spawn(0)
							O.Move(target)
					else
						O << "<span class='notice'>The top of \the [src] is blocked by \the [target].</span>"
				else if(above)
					O << "<span class='notice'>Your way up is blocked by \the [above].</span>"
			else
				O << "<span class='info'>\the [src] do not lead up to anything interesting.</span>"
		else
			lastmove = null

/turf/simulated/floor/stairs/attackby(obj/item/C as obj, mob/user as mob)
	. = ..(C, user)

	if(istype(C, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = C
		if(WT.remove_fuel(5, user))

			user << "<span class='notice'>You begin to deconstruct \the [src].</span>"
			playsound(src, 'sound/items/Welder.ogg', 100, 1)

			if(!do_after(user, 100) || !WT || !WT.isOn())
				return

			var/obj/item/stack/material/steel/S = PoolOrNew(/obj/item/stack/material/steel, src.loc)
			S.amount = 6
			user << "<span class='info'>You deconstruct \the [src].</span>"
			playsound(src, 'sound/items/Deconstruct.ogg', 100, 1)
			ChangeTurf(/turf/simulated/floor/plating)
		else
			user << "<span class='notice'>You need more welding fuel to complete this task.</span>"
		return
