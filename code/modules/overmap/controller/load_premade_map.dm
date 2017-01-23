
//warning! make sure you only load maps that are 1 zlevel deep
//this only handles basic overmapobj as well, no other tpyes like /ship
datum/controller/process/overmap/proc/load_premade_map(var/mapname)
	set background = 1
	if(!mapname)
		return null

	var/obj/effect/overmapobj/loaded_obj = new()
	var/obj/effect/zlevelinfo/level_data
	var/loadz = 0

	//get random coords
	//whoever is responsible for calling this function can initialise the overmapobj and zlevelinfo separately
	loaded_obj.x = rand(OVERMAP_EDGE, world.maxx - OVERMAP_EDGE)
	loaded_obj.y = rand(OVERMAP_EDGE, world.maxy - OVERMAP_EDGE)
	loaded_obj.z = OVERMAP_ZLEVEL

	//work out if there are enough adjacent unused zlevels
	if(cached_zlevels.len)
		//grab a precached (unused) zlevel
		message_admins("Using cached zlevel for map [mapname]")

		//find the highest unused zlevel to load onto
		for(var/obj/effect/zlevelinfo/check_level in cached_zlevels)
			if(level_data)
				//if this zlevel is "higher" grab it instead
				//this is required for proper multiz stacking
				if(check_level.z < level_data.z)
					level_data = check_level
			else
				level_data = check_level

		cached_zlevels -= level_data

		//precached space should always have exactly 1 completely empty zlevel
		loadz = level_data.z

	else
		//if not enough empty zlevels are loaded, create a new one
		world << "<span class='danger'>Adding new zlevel for map [mapname], server may lag for a few seconds to a minute...</span>"
		sleep(1)
		world.maxz++
		loadz = world.maxz
		level_data = new(locate(1, 1, loadz))

	var/mapfile = file(mapname)
	if(isfile(mapfile))
		message_admins("Loading map [mapname] onto zlevel [loadz]...")
		var/time_started = world.time

		//temporarily hide the current level data, in case we load in a new one
		var/oldtag = level_data.tag
		level_data.tag = "unused zlevelinfo [world.time]"	//lazy way to ensure a unique tag, just in case

		maploader.load_map(mapfile, loadz)

		//check if we loaded in another zlevelinfo to replace it
		var/obj/effect/zlevelinfo/new_level_data = locate("zlevel[loadz]")

		//there is one, so replace the old level data
		if(new_level_data)
			qdel(level_data)
			level_data = new_level_data

		level_data.tag = oldtag

		message_admins("	Done ([(world.time - time_started) / 10]s), initializing lighting and ladders...")
		time_started = world.time

		//enable dynamic lighting on the new level (should be almost very quick)
		create_lighting_overlays(level_data.z)

		//init ladder states, something about runtime maploading borks this
		for(var/obj/structure/ladder/ladder in world)
			ladder.init_zdir()

		message_admins("	Done ([(world.time - time_started) / 10]s), initializing atmos...")
		time_started = world.time

		//setup atmos on the newly loaded turfs
		for(var/curx = 1, curx <= world.maxx, curx++)
			for(var/cury = 1, cury <= world.maxy, cury++)
				var/turf/cur_turf = locate(curx, cury, level_data.z)

				air_master.mark_for_update(cur_turf)

		message_admins("	Done ([(world.time - time_started) / 10]s)")

		//assume it's just a basic sector, we'll have to avoid loading in ships at runtime for now

		//tell the overmapobj about this level
		loaded_obj.linked_zlevelinfos.Add(level_data)

		return loaded_obj
	else
		world << "<span class='alert'>Error: [mapname] is not a valid map file.</span>"

	return null
