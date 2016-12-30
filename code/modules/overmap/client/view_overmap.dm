
//players look out of a "window" into space to view what is happening outside the ship
//this lets them watch space battles etc
/mob/verb/view_overmap()
	set name = "Observe overmap"
	set category = "Overmap"

	if(src && src.client)
		//if we're on a ship or space station, just look out a nearby space tile
		var/obj/machinery/overmap_vehicle/overmap_vehicle
		if(istype(src.loc, /turf))
			var/turf/space/S = locate() in view(5)
			if(S)
				var/obj/effect/overmapobj/overmapobj = map_sectors["[src.z]"]
				if(overmapobj)
					overmapobj.observe_space(src)
				else
					src << "<span class='warning'>There is nothing interesting to see in this sector of space.</span>"
					//log_admin("Warning: [src] attempted to \"look out to space\" on overmap disabled zlevel [src.z] (unable to find corresponding omapobject)")
				return
			else
				//shuttles are handled a little oddly, their handling is a mix between capital ships and fighters
				//players can "view" outside the shuttle via the helm console
				var/obj/machinery/computer/shuttle_helm/H = locate() in view(1)
				if(H)
					overmap_vehicle = H.my_shuttle
				else
					//otherwise find a nearby window to look out of
					var/turf/simulated/shuttle/hull/window/W = locate() in view(5)
					if(W && W.my_shuttle)
						overmap_vehicle = W.my_shuttle
					else
						src << "<span class='info'>You aren't close enough to look out to space.</span>"
						return

		//check if we're in a vehicle (fighters and dropships)
		if(istype(src.loc, /obj/machinery/overmap_vehicle))
			overmap_vehicle = src.loc

		//if we're in a starfighter, we need to be clear of any obstructions
		if(overmap_vehicle)
			var/obj/effect/overmapobj/overmapobj = map_sectors["[overmap_vehicle.z]"]
			//make sure we are covering enough space
			var/success = 1
			if(!overmap_vehicle.is_cruising())
				for(var/turf/T in overmap_vehicle.locs)
					if(!istype(T, /turf/space))
						success = 0
						break
			if(success)
				overmap_vehicle.observe_space(src)
			else
				src << "\icon[overmapobj] <span class='info'>Your view out of [overmap_vehicle] to space is being obstructed by [overmapobj]. Move fully into space for a clear view.</span>"
		else
			src << "<span class='info'>[src.loc] is obscuring your view out to space.</span>"
