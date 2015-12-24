
//players look out of a "window" into space to view what is happening outside the ship
//this lets them watch space battles etc
/mob/verb/view_overmap()
	set name = "Look out to space"
	set category = "Overmap"

	if(usr && usr.client)
		//if we're on a ship or space station, just look out a nearby space tile
		if(istype(usr.loc, /turf))
			var/obj/effect/overmapobj/overmapobj = map_sectors["[usr.z]"]
			if(overmapobj)
				var/turf/space/S = locate() in view(5)
				if(S)
					overmapobj.observe_space(usr)
				else
					usr << "<span class='info'>You aren't close enough to look out to space.</span>"
			else
				log_admin("Overmap error: [usr.z] level is most likely not enabled on overmap (unable to find corresponding object)")

		//if we're in a starfighter, we need to be clear of any obstructions
		else if(istype(usr.loc, /obj/machinery/overmap_vehicle))
			var/obj/machinery/overmap_vehicle/overmap_vehicle = usr.loc
			var/obj/effect/overmapobj/overmapobj = map_sectors["[overmap_vehicle.z]"]
			//make sure we are covering enough space
			var/success = 1
			for(var/turf/T in overmap_vehicle.locs)
				if(!istype(T, /turf/space))
					success = 0
					break
			if(success)
				overmap_vehicle.observe_space(usr)
			else
				usr << "<span class='info'>Your view out of [overmap_vehicle] to space is being obstructed by [overmapobj]. Move fully into space for a clear view.</span>"
		else
			usr << "<span class='info'>[usr.loc] is obscuring your view out to space.</span>"
