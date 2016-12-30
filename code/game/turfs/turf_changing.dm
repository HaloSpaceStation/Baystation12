
/turf/proc/ReplaceWithLattice()
	//check if we need to use open space or ordinary space tile
	var/turftype = get_base_turf(src.z)
	var/turf/T = GetBelow(src)
	if(T)
		if(!istype(T, /turf/space))
			turftype = /turf/simulated/floor/open
	src.ChangeTurf(turftype)
	spawn()
		new /obj/structure/lattice( locate(src.x, src.y, src.z) )

// Removes all signs of lattice on the pos of the turf -Donkieyo
/turf/proc/RemoveLattice()
	var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
	if(L)
		qdel(L)

//Creates a new turf
/turf/proc/ChangeTurf(var/turf/N, var/tell_universe=1, var/force_lighting_update = 0)
	if (!N)
		return

	var/obj/fire/old_fire = fire
	var/old_opacity = opacity
	var/old_dynamic_lighting = dynamic_lighting
	var/list/old_affecting_lights = affecting_lights
	var/old_lighting_overlay = lighting_overlay

	//world << "Replacing [src.type] with [N]"

	if(connections) connections.erase_all()

	if(istype(src,/turf/simulated))
		//Yeah, we're just going to rebuild the whole thing.
		//Despite this being called a bunch during explosions,
		//the zone will only really do heavy lifting once.
		var/turf/simulated/S = src
		if(S.zone) S.zone.rebuild()

	var/turf/W = new N( locate(src.x, src.y, src.z) )
	if(ispath(N, /turf/simulated/floor))
		//if its open space, drop all loose items
		if(istype(W,/turf/simulated/floor/open))
			for(var/atom/movable/AM in W.contents)
				if(!AM.anchored)
					W.Enter(AM)
		else
			W.RemoveLattice()

	if(old_fire)
		old_fire.RemoveFire()

	if(tell_universe)
		universe.OnTurfChange(W)

	if(air_master)
		air_master.mark_for_update(src)

	for(var/turf/space/S in range(W,1))
		S.update_starlight()

	W.levelupdate()
	. = W

///// Z-Level Stuff
	//for each open turf above us (starting with us), loop up and tell them to update if necessary
	var/turf/T = W
	while(T)
		//world << "	new cycle ([T.type] z[T.z])"
		if(istype(T, /turf/space))
			var/turf/below = GetBelow(src)
			// dont make open space into space, its pointless and makes people drop out of the station
			if(below && !istype(below, /turf/space))
				//world << "turf below is ground (plating etc), changing this one to open"
				if(T == W)
					//change this turf type later
					spawn(0)
						W = T.ChangeTurf(/turf/simulated/floor/open)
						. = W
					break
				else
					T = T.ChangeTurf(/turf/simulated/floor/open)

		else if(istype(T, /turf/simulated/floor/open))
			//world << "turf is open"
			if(T != W)
				//world << "calling level update"
				T.levelupdate()

		T = GetAbove(T)
///// Z-Level Stuff

	lighting_overlay = old_lighting_overlay
	affecting_lights = old_affecting_lights
	if((old_opacity != opacity) || (dynamic_lighting != old_dynamic_lighting) || force_lighting_update)
		reconsider_lights()
	if(dynamic_lighting != old_dynamic_lighting)
		if(dynamic_lighting)
			lighting_build_overlays()
		else
			lighting_clear_overlays()
