var/list/delete_on_spacetravel = list(\
	/mob/living/simple_animal,\
	/mob/living/carbon/slime,\
	/obj/item,\
	/obj/fire,\
	/obj/singularity,\
)

/datum/controller/process/overmap/proc/overmap_spacetravel(var/turf/space/T, var/atom/movable/A)

	//istype(A, /obj/effect/overmapobj) || istype(A, /obj/effect/zlevelinfo)
	if(!A || !T)
		return

	//if this zlevel isnt enabled on overmap then block it from travelling
	var/obj/effect/overmapobj/current_sector = map_sectors["[T.z]"]
	if (!current_sector)
		return

	var/obj/machinery/overmap_vehicle/V = A
	if(!istype(V))
		V = null

	//most stuff we can just "lose" in deep space and never find again
	if(A.type in delete_on_spacetravel)
		//todo: check if this thing has some means of tracking so it can be located again
		qdel(A)
		return
	//otherwise just block it from moving
	else if(!V && !istype(A, /mob))
		//todo: determine edge cases
		log_admin("[A] attemped space travel at [A.x],[A.y],[A.z] but was blocked because of unknown type [A.type]")
		return

	var/mapx = current_sector.x
	var/mapy = current_sector.y
	var/nx = 1
	var/ny = 1
	var/nz = 1

	var/exit_dir = 0
	if(T.x <= TRANSITIONEDGE)
		nx = world.maxx - TRANSITIONEDGE - 2
		ny = min(max(TRANSITIONEDGE + 2, T.y), world.maxy - TRANSITIONEDGE - 2)
		mapx = max(1, mapx-1)
		exit_dir = WEST

	else if (T.x >= (world.maxx - TRANSITIONEDGE - 1))
		nx = TRANSITIONEDGE + 2
		ny = min(max(TRANSITIONEDGE + 2, T.y), world.maxy - TRANSITIONEDGE - 2)
		mapx = min(world.maxx, mapx+1)
		exit_dir = EAST

	else if (T.y <= TRANSITIONEDGE)
		ny = world.maxy - TRANSITIONEDGE -2
		nx = min(max(TRANSITIONEDGE + 2, T.x), world.maxx - TRANSITIONEDGE - 2)
		mapy = max(1, mapy-1)
		exit_dir = SOUTH

	else if (T.y >= (world.maxy - TRANSITIONEDGE - 1))
		ny = TRANSITIONEDGE + 2
		nx = min(max(TRANSITIONEDGE + 2, T.x), world.maxx - TRANSITIONEDGE - 2)
		mapy = min(world.maxy, mapy+1)
		exit_dir = NORTH

	else
		//not close enough to the edge to travel
		log_admin("[A] attemped space travel at [A.x],[A.y],[A.z] but was blocked because it was too far from the edge")
		return

	testing("[A] moving from [current_sector] ([current_sector.x], [current_sector.y]) to ([mapx],[mapy]) with dir [dir2text(exit_dir)].")

	//var/obj/effect/zlevelinfo/curz = locate("zlevel[A.z]")
	//curz.objects_preventing_recycle.Remove(A)

	//will attempt to reuse the existing zlevel if it is a temporary deep space sector
	attempt_recycle_temp_sector(current_sector, A)

	//grab the overmapobj for the target tile for us to transition to
	var/turf/map = locate(mapx,mapy,OVERMAP_ZLEVEL)
	var/obj/effect/overmapobj/target_sector = get_destination_sector(map)

	//fix the fucking wraparound bug for multitile capships and stations
	while(target_sector == current_sector)
		map = get_step(map, exit_dir)
		target_sector = get_destination_sector(map)

	//check for multi-tile objects like cruisers so we don't just loop back on ourselves
	/*if(target_sector == current_sector)
		map = target_sector.get_offedge_turf(A, exit_dir)
		target_sector = get_destination_sector(map)*/
		/*var/cur_size = 0
		while(target_sector == current_sector && cur_size < MAX_OVERMAP_DIMS)
			cur_size += 1
			map = get_step(map, exit_dir)
			target_sector = get_destination_sector(map)
			world << "	checking #[cur_size]: [map ? "[map.x],[map.y]" : "null"]: [target_sector ? target_sector : "null"]"*/

	//if there's something pre-existing there to fly towards, do it
	var/obj/effect/zlevelinfo/entry_level
	if(target_sector)
		if(target_sector.linked_zlevelinfos.len)
			//check if we are in a vehicle targetting a specific level
			if(istype(A, /obj/machinery/overmap_vehicle))
				var/obj/machinery/overmap_vehicle/overmap_vehicle = A
				if(overmap_vehicle.target_entry_level && overmap_vehicle.target_entry_level in target_sector.linked_zlevelinfos)
					entry_level = overmap_vehicle.target_entry_level
					testing("	Space travel destination is object: [target_sector] (targetting zlevel [entry_level.z])")

			if(!entry_level)
				entry_level = target_sector.linked_zlevelinfos[1]
				testing("	Space travel destination is object: [target_sector] (targetting default top zlevel [entry_level.z])")
		else
			//special handling for asteroids, as they might still be generating
			if(istype(target_sector, /obj/effect/overmapobj/bigasteroid))
				var/obj/effect/overmapobj/bigasteroid/bigasteroid = target_sector

				testing("	Space travel destination is bigasteroid: [bigasteroid]")
				entry_level = bigasteroid.get_zlevel()

			else
				testing("WARNING: no valid zlevel target for spacetravel at overmap sector: [target_sector] [target_sector.type] ([target_sector.x],[target_sector.y]) [A]")

		//if we cant get into this sector, force a travel to a temp sector on the same turf
		if(!entry_level)
			target_sector = locate(/obj/effect/overmapobj/temporary_sector) in map
			if(target_sector)
				testing("WARNING: no valid zlevel target for spacetravel at overmap sector, using stacked temp sector ([target_sector.x],[target_sector.y]) [A]")
				entry_level = target_sector.linked_zlevelinfos[1]

	if(!target_sector)
		//otherwise, we're headed for deep space!
		testing("	Space travel destination is ~deep space~")

		//var/obj/effect/zlevelinfo/data// = overmap_controller.transit_level

		//vehicles such as fighters or shuttles will use fast transit, let them handle that
		/*if(V)
			V.enter_deepspace(data)
			return*/

		//otherwise we're going to grab a free empty zlevel and just lurk there
		entry_level = get_or_create_cached_zlevel()
		entry_level.name = "Temporary space sector"

		//create a corresponding deep space sector so we can be found
		testing("	Adding new temporary space sector...")
		target_sector = new /obj/effect/overmapobj/temporary_sector(mapx, mapy, entry_level.z)
		target_sector:objects_preventing_recycle.Add(A)		//whoo typecasting
		target_sector.linked_zlevelinfos.Add(entry_level)
		map_sectors["[entry_level.z]"] = target_sector

	if(istype(V))
		V.leaving_sector(current_sector, target_sector)

	//testing("Destination: z[nz] [target_sector]")
	nz = entry_level.z

	var/turf/dest = locate(nx,ny,nz)
	if(dest)
		A.loc = dest

		//move the mini-fighter on the overmap to the new turf
		/*if(V)
			V.vehicle.enter_new_zlevel(target_sector)*/

	if(istype(V))

		//update overmapobj
		V.overmap_object.loc = target_sector.loc
		if(target_sector.hide_vehicles)
			V.overmap_object.invisibility = 101
		else
			V.overmap_object.invisibility = 0

		V.enter_new_sector(target_sector, entry_level)

		//update any radios
		for(var/mob/M in V)
			for(var/obj/item/device/radio/R in M)
				R.reset_listening_sector()
	else
		for(var/obj/item/device/radio/R in A)
			R.reset_listening_sector()

	return 1

//return a valid destination sector for an overmap turf
//todo: move this over to an intelligent system and add verbs so players can choose what sector to enter
/datum/controller/process/overmap/proc/get_destination_sector(var/turf/mapturf)
	var/obj/effect/overmapobj/target_sector
	for(var/obj/effect/overmapobj/check_obj in mapturf)
		//if this is just a generic marker, ignore it
		//world << "	checking [check_obj]..."
		if(!check_obj.linked_zlevelinfos.len)
			continue

		if(istype(target_sector, /obj/effect/overmapobj/vehicle))
			continue

		//if there is more than one, get the static sector (the one that isn't a ship)
		if(!target_sector || istype(target_sector, /obj/effect/overmapobj/ship))
			target_sector = check_obj

	return target_sector
