
//players look out of a "window" into space to view what is happening outside the ship
//this lets them watch space battles etc
/mob/verb/view_overmap()
	set name = "Look out to space"
	set category = "Overmap"

	if(src && src.client)
		//if we're on a ship or space station, just look out a nearby space tile
		if(istype(src.loc, /turf))
			var/turf/space/S = locate() in view(5)
			if(S)
				var/obj/effect/overmapobj/overmapobj = map_sectors["[src.z]"]
				if(overmapobj)
					overmapobj.observe_space(src)
				else
					src << "<span class='warning'>There is nothing interesting to see in this sector of space.</span>"
					//log_admin("Warning: [src] attempted to \"look out to space\" on overmap disabled zlevel [src.z] (unable to find corresponding omapobject)")
			else
				src << "<span class='info'>You aren't close enough to look out to space.</span>"

		//if we're in a starfighter, we need to be clear of any obstructions
		else if(istype(src.loc, /obj/machinery/overmap_vehicle))
			var/obj/machinery/overmap_vehicle/overmap_vehicle = src.loc
			var/obj/effect/overmapobj/overmapobj = map_sectors["[overmap_vehicle.z]"]
			//make sure we are covering enough space
			var/success = 1
			for(var/turf/T in overmap_vehicle.locs)
				if(!istype(T, /turf/space))
					success = 0
					break
			if(success)
				overmap_vehicle.observe_space(src)
			else
				src << "<span class='info'>Your view out of [overmap_vehicle] to space is being obstructed by [overmapobj]. Move fully into space for a clear view.</span>"
		else
			src << "<span class='info'>[src.loc] is obscuring your view out to space.</span>"
