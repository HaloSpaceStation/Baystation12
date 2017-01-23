
/datum/controller/process/overmap/proc/overmap_spacetravel(var/turf/space/T, var/atom/movable/A)

	//only let mobs and overmap vehicles change zlevel for now, everything else can get "lost" in space
	if(!istype(A, /obj/machinery/overmap_vehicle) && !istype(A, /mob))
		if(!istype(A, /obj/effect))
			qdel(A)
		return

	var/obj/effect/overmapobj/current_obj = map_sectors["[T.z]"]

	if (!current_obj)
		return
	var/mapx = current_obj.x
	var/mapy = current_obj.y
	var/nx = 1
	var/ny = 1
	var/nz = 1

	if(T.x <= TRANSITIONEDGE)
		nx = world.maxx - TRANSITIONEDGE - 2
		ny = rand(TRANSITIONEDGE + 2, world.maxy - TRANSITIONEDGE - 2)
		mapx = max(1, mapx-1)

	else if (A.x >= (world.maxx - TRANSITIONEDGE - 1))
		nx = TRANSITIONEDGE + 2
		ny = rand(TRANSITIONEDGE + 2, world.maxy - TRANSITIONEDGE - 2)
		mapx = min(world.maxx, mapx+1)

	else if (T.y <= TRANSITIONEDGE)
		ny = world.maxy - TRANSITIONEDGE -2
		nx = rand(TRANSITIONEDGE + 2, world.maxx - TRANSITIONEDGE - 2)
		mapy = max(1, mapy-1)

	else if (A.y >= (world.maxy - TRANSITIONEDGE - 1))
		ny = TRANSITIONEDGE + 2
		nx = rand(TRANSITIONEDGE + 2, world.maxx - TRANSITIONEDGE - 2)
		mapy = min(world.maxy, mapy+1)

	testing("[A] moving from [current_obj] ([current_obj.x], [current_obj.y]) to ([mapx],[mapy]).")

	//grab the overmapobj for the target tile
	var/turf/map = locate(mapx,mapy,OVERMAP_ZLEVEL)
	var/obj/effect/overmapobj/target_obj
	//if there is more than one, get the static sector (the overmapobj that isn't a ship)
	for(var/obj/effect/overmapobj/check_obj in map)
		if(!target_obj || istype(target_obj, /obj/effect/overmapobj/ship))
			target_obj = check_obj

	if(target_obj)
		//always just come in on the top level for now
		var/obj/effect/zlevelinfo/entry_level = target_obj.linked_zlevelinfos[1]
		nz = entry_level.z
	else
		//create a temporary deep space sector
		admin_notice("<span class='danger'>Adding new temporary space sector...</span>", R_DEBUG)
		target_obj = new /obj/effect/overmapobj/temporary_sector(mapx, mapy, nz)

		var/obj/effect/zlevelinfo/data
		if(cached_zlevels.len)
			//grab a cached zlevel
			data = cached_zlevels[cached_zlevels.len]
			cached_zlevels -= data
		else
			//extend the world depth by adding a whole new zlevel
			world << "<span class='danger'>Adding new zlevel for deep space travel, server may lag for a few seconds to a minute...</span>"
			world.maxz++
			data = new(loc = locate(1, 1, world.maxz))

		nz = data.z
		target_obj.linked_zlevelinfos.Add(data)

	testing("Destination: z[nz] [target_obj]")

	var/turf/dest = locate(nx,ny,nz)
	if(dest)
		A.loc = dest

	attempt_recycle_temp_sector(current_obj)
