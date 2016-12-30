
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

		message_admins("	Done ([(world.time - time_started) / 10]s), initializing lighting...")
		time_started = world.time
		sleep(-1)

		//enable dynamic lighting on the new level (very quick)
		create_lighting_overlays(level_data.z)

		//do we need to fully initialize everything? if the map is loaded prior to round start we do
		var/do_full_init = 0
		if(!ticker || ticker.current_state != GAME_STATE_PLAYING)
			do_full_init = 1

		if(do_full_init)
			message_admins("	Done ([(world.time - time_started) / 10]s), initializing areas...")
			time_started = world.time
			sleep(-1)

			//initialize areas (very quick)
			for(var/area/area in all_areas)
				for(var/atom/A in area.contents)
					if(A.z == level_data.z)
						area.initialize()
					break

		if(do_full_init)
			message_admins("	Done ([(world.time - time_started) / 10]s), initializing atmos, objects...")
		else
			message_admins("	Done ([(world.time - time_started) / 10]s), initializing atmos, objects...")
		time_started = world.time
		sleep(-1)

		var/list/custom_init = list()
		var/list/custom_init_types = list(\
			///obj/structure/ladder,
			/obj/machinery/door/airlock,\
			/obj/structure/cable,\
			/obj/machinery/atmospherics)

		for(var/curx = 1, curx <= world.maxx, curx++)
			for(var/cury = 1, cury <= world.maxy, cury++)
				var/turf/cur_turf = locate(curx, cury, level_data.z)

				//setup atmos on the newly loaded turfs
				air_master.mark_for_update(cur_turf)

				for(var/atom/movable/A in cur_turf)

					//pipe manifolds need their 3-way directions reset
					/*
					if(istype(A, /obj/machinery/atmospherics/pipe/manifold))
						var/obj/machinery/atmospherics/pipe/manifold/M = A

						switch(M.dir)
							if(NORTH)
								M.initialize_directions = EAST|SOUTH|WEST
							if(SOUTH)
								M.initialize_directions = WEST|NORTH|EAST
							if(EAST)
								M.initialize_directions = SOUTH|WEST|NORTH
							if(WEST)
								M.initialize_directions = NORTH|EAST|SOUTH
								*/

					//initialisation pre-step for cables
					if(istype(A, /obj/structure/cable))
						var/obj/structure/cable/C = A

						var/dash = findtext(C.icon_state, "-")

						C.d1 = text2num( copytext( C.icon_state, 1, dash ) )

						C.d2 = text2num( copytext( C.icon_state, dash+1 ) )

						var/turf/T = C.loc			// hide if turf is not intact
						if( C.level==1 && !(C.d2 & (UP|DOWN)) )
							C.hide(!T.is_plating())

					A.initialize()

					for(var/custom_type in custom_init_types)
						if(istype(A, custom_type))
							custom_init.Add(A)
							break

		message_admins("	Done ([(world.time - time_started) / 10]s) initializing powernets, ladders, airlocks, atmos machinery, pipenets...")
		time_started = world.time
		sleep(-1)

		for(var/atom/movable/A in custom_init)
			//fix airlocks as the way they are loaded stores their access lists in an incorrect format
			if(istype(A, /obj/machinery/door/airlock))

				var/obj/machinery/door/airlock/D = A
				var/list/req_access_new = list()
				for(var/entry in D.req_access)
					req_access_new += text2num(entry)
				D.req_access = req_access_new
				//
				var/list/req_one_access_new = list()
				for(var/entry in D.req_one_access)
					req_one_access_new += text2num(entry)
				D.req_one_access = req_one_access_new

			//setup cable networks, this is done by the server at startup
			if(istype(A, /obj/structure/cable))
				var/obj/structure/cable/PC = A
				//PC.debug = 1
				if(!PC.powernet)
					var/datum/powernet/NewPN = new()
					NewPN.add_cable(PC)
					propagate_network(PC,PC.powernet)

			//setup atmos machinery, this is done by the server at startup
			if(istype(A, /obj/machinery/atmospherics))
				var/obj/machinery/atmospherics/V = A

				//pipe networks
				V.build_network()

				//pump starting states (in, out etc)
				if(istype(V, /obj/machinery/atmospherics/unary/vent_pump))
					var/obj/machinery/atmospherics/unary/vent_pump/T = V
					T.broadcast_status()
				else if(istype(V, /obj/machinery/atmospherics/unary/vent_scrubber))
					var/obj/machinery/atmospherics/unary/vent_scrubber/T = V
					T.broadcast_status()

			/*if(istype(A, /obj/structure/ladder))
				var/obj/structure/ladder/L = A
				L.init_zdir()*/

		message_admins("	Done ([(world.time - time_started) / 10]s)")
		sleep(-1)

		//assume it's just a basic sector, we'll have to avoid loading in ships at runtime for now
		//tell the overmapobj about this level
		loaded_obj.linked_zlevelinfos.Add(level_data)

		//init scanner handling
		loaded_obj.scanner_manager = new()

		return loaded_obj
	else
		world << "<span class='alert'>Error: [mapname] is not a valid map file.</span>"

	return null
