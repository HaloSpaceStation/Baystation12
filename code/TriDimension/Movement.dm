
/mob/verb/moveup()
	set name = "Travel Upwards"
	set category = "IC"
	var/mob/M = usr
	if(M && istype(M))
		move_updown(M, UP)

/mob/verb/movedown()
	set name = "Travel Downwards"
	set category = "IC"
	var/mob/M = usr
	if(M && istype(M))
		move_updown(M, DOWN)

/proc/move_updown(var/mob/M, var/zdir)
	if(!M || !M.loc)
		return

	var/turf/curturf = get_turf(M)
	if(curturf.ztransit_enabled(zdir))
		var/newZ = 1
		if(zdir == UP)
			newZ = -1
		var/turf/T = locate(curturf.x, curturf.y, curturf.z + newZ)
		var/blocked = 0
		if(!T || !T.CanPass(M, T))
			blocked = T
		else if(zdir == UP && T.blocks_air_downwards)
			blocked = T
		else if(zdir == DOWN && curturf.blocks_air_downwards)
			blocked = curturf

		if(!blocked)
			blocked = 0
			for(var/atom/A in T.contents)
				if(!A.CanPass(usr, T))
					blocked = 1
					usr << "<span class='warning'>You bump into [A].</span>"
					break
			if(!blocked)
				//check for handholds
				var/handhold = 0
				for(var/checkdir in cardinal)
					//all turfs except space and open space turfs can be used as handholds for movement
					var/turf/handholdturf = get_step(curturf, checkdir)
					if(!handholdturf)
						continue

					if( !istype(handholdturf, /turf/space) && !istype(handholdturf, /turf/simulated/floor/open) )
						handhold = 1
						break

					//lattices can be used as handholds for movement
					var/obj/structure/lattice/R = locate() in handholdturf
					if(R)
						handhold = 1
						break

					//ladders can be used as handholds for movement
					var/obj/structure/ladder/L = locate() in handholdturf
					if(L && L.anchored)
						handhold = 1
						break

				//if we don't have a handhold, all we can do is use a jetpack
				if(!handhold)
					var/obj/item/weapon/tank/jetpack/J = locate() in M.contents
					if(J)
						if(J.allow_thrust(0.01, M))
							handhold = 1
						else
							M << "<span class='warning'>Your jetpack is out of fuel!</span>"

				if(handhold)
					M.Move(T)
					M << "<span class='info'>You move [zdir == UP ? "up" : "down"]wards.</span>"
				else
					M << "<span class='notice'>You have no handholds to do that.</span>"
		else
			M << "<span class='warning'>[blocked] is in your way.</span>"
	else
		M << "<span class='info'>There is nothing of interest in this direction.</span>"
