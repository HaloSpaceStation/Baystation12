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
	var/obj/effect/overmapobj/current_obj = map_sectors["[T.z]"]
	if (!current_obj)
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

	var/mapx = current_obj.x
	var/mapy = current_obj.y
	var/nx = 1
	var/ny = 1
	var/nz = 1

	var/exit_dir = 0
	if(T.x <= TRANSITIONEDGE)
		nx = world.maxx - TRANSITIONEDGE - 2
		ny = min(max(TRANSITIONEDGE + 2, A.y), world.maxy - TRANSITIONEDGE - 2)
		mapx = max(1, mapx-1)
		exit_dir = WEST

	else if (A.x >= (world.maxx - TRANSITIONEDGE - 1))
		nx = TRANSITIONEDGE + 2
		ny = min(max(TRANSITIONEDGE + 2, A.y), world.maxy - TRANSITIONEDGE - 2)
		mapx = min(world.maxx, mapx+1)
		exit_dir = EAST

	else if (T.y <= TRANSITIONEDGE)
		ny = world.maxy - TRANSITIONEDGE -2
		nx = min(max(TRANSITIONEDGE + 2, A.x), world.maxx - TRANSITIONEDGE - 2)
		mapy = max(1, mapy-1)
		exit_dir = SOUTH

	else if (A.y >= (world.maxy - TRANSITIONEDGE - 1))
		ny = TRANSITIONEDGE + 2
		nx = min(max(TRANSITIONEDGE + 2, A.x), world.maxx - TRANSITIONEDGE - 2)
		mapy = min(world.maxy, mapy+1)
		exit_dir = NORTH

	testing("[A] moving from [current_obj] ([current_obj.x], [current_obj.y]) to ([mapx],[mapy]) with dir [dir2text(exit_dir)].")

	//sneakily reuse the existing zlevel
	var/obj/effect/zlevelinfo/curz = locate("zlevel[A.z]")
	curz.objects_preventing_recycle.Remove(A)
	attempt_recycle_temp_sector(current_obj)

	//grab the overmapobj for the target tile for us to transition to
	var/turf/map = locate(mapx,mapy,OVERMAP_ZLEVEL)
	var/obj/effect/overmapobj/target_obj = get_destination_object(map)

	//check for multi-tile objects like cruisers so we don't just loop back on ourselves
	/*if(target_obj == current_obj)
		map = target_obj.get_offedge_turf(A, exit_dir)
		target_obj = get_destination_object(map)*/
		/*var/cur_size = 0
		while(target_obj == current_obj && cur_size < MAX_OVERMAP_DIMS)
			cur_size += 1
			map = get_step(map, exit_dir)
			target_obj = get_destination_object(map)
			world << "	checking #[cur_size]: [map ? "[map.x],[map.y]" : "null"]: [target_obj ? target_obj : "null"]"*/

	//if there's something pre-existing there to fly towards, do it
	if(target_obj)
		//always just come in on the top level for now
		var/obj/effect/zlevelinfo/entry_level = target_obj.linked_zlevelinfos[1]
		nz = entry_level.z
		testing("	Space travel destination is object: [target_obj]")
	else
		//otherwise, we're headed for deep space!
		testing("	Space travel destination is ~deep space~")

		var/obj/effect/zlevelinfo/data// = overmap_controller.transit_level

		//vehicles such as fighters or shuttles will use fast transit, let them handle that
		/*if(V)
			V.enter_deepspace(data)
			return*/

		//otherwise we're going to grab a free empty zlevel and just lurk there
		data = get_or_create_cached_zlevel()
		data.name = "Temporary space sector"
		data.objects_preventing_recycle.Add(A)
		nz = data.z

		//create a corresponding deep space sector so we can be found
		testing("	Adding new temporary space sector...")
		target_obj = new /obj/effect/overmapobj/temporary_sector(mapx, mapy, nz)
		target_obj.linked_zlevelinfos.Add(data)
		map_sectors["[data.z]"] = target_obj

	//testing("Destination: z[nz] [target_obj]")

	var/turf/dest = locate(nx,ny,nz)
	if(dest)
		A.loc = dest

		//move the mini-fighter on the overmap to the new turf
		if(V)
			V.vehicle_transform.enter_new_zlevel(target_obj)

/datum/controller/process/overmap/proc/get_destination_object(var/turf/mapturf)
	var/obj/effect/overmapobj/target_obj
	for(var/obj/effect/overmapobj/check_obj in mapturf)
		//if this is just a generic marker, ignore it
		//world << "	checking [check_obj]..."
		if(!check_obj.linked_zlevelinfos.len)
			continue

		if(istype(target_obj, /obj/effect/overmapobj/vehicle))
			continue

		//if there is more than one, get the static sector (the one that isn't a ship)
		if(!target_obj || istype(target_obj, /obj/effect/overmapobj/ship))
			target_obj = check_obj

	return target_obj
