
datum/controller/process/overmap/New()
	overmap_scanner_manager = new()		//just in case
	..()

datum/controller/process/overmap/setup()

	/*if(!config.use_overmap)
		return kill()*/

	overmap_controller = src

	//testing("Building overmap...")
	admin_notice("<span class='danger'>Building overmap...</span>", R_DEBUG)

	//to enable debugging
	map_sectors_reference = map_sectors
	cached_zlevels_reference = cached_zlevels
	//
	all_abundant_ores_reference = all_abundant_ores
	unused_abundant_ores_reference = unused_abundant_ores
	all_common_ores_reference = all_common_ores
	unused_common_ores_reference = unused_common_ores
	all_rare_ores_reference = all_rare_ores
	unused_rare_ores_reference = unused_rare_ores
	//
	halo_frequencies_reference = halo_frequencies
	//
	all_datanets_reference = all_datanets
	uninitialised_datanets_reference = uninitialised_datanets

	asteroid_gen_config = new()

	var/obj/effect/zlevelinfo/data
	for(var/level in 1 to world.maxz)
		data = locate("zlevel[level]")
		if(data)
			//testing("Z-Level [level] is enabled on overmap")

			if(istype(data, /obj/effect/zlevelinfo/precached))
				//testing("	pre-cached empty space")
				/*var/obj/effect/overmapobj/precached_zlevels = new /obj/effect/overmapobj()
				precached_zlevels.loc = null*/
				cached_zlevels += data

			/*else if(istype(data, /obj/effect/zlevelinfo/precreated))
				testing("Adding precreated ship! Tag: [data.tag] Name: [data.name] at [data.mapx],[data.mapy] corresponding to z[level]")
				//map_sectors["[level]"] = new /obj/effect/overmapobj(data)
				cached_zlevelspre["[data.name]"] = data*/

			else if(istype(data, /obj/effect/zlevelinfo/bigasteroid))
				asteroid_zlevels.Add(data)
				asteroid_zlevels_loading_unassigned.Add(data)
				asteroid_zlevel_loading = data
				data:begin_generation()		//whatever

			else if(istype(data, /obj/effect/zlevelinfo/innie_base))
				if(!innie_base)
					innie_base = new /obj/effect/overmapobj/innie_base(locate(1,1,1))
					initialise_overmapobj(innie_base, data)

				innie_base.linked_zlevelinfos += data
				map_sectors["[level]"] = innie_base

			else
				var/obj/effect/overmapobj/found_obj = locate("[data.name]")

				if(found_obj)
					//testing("	belongs to \"[data.name]\"")
				else
					//If there is no obj with such name, we will create one.
					if(istype(data, /obj/effect/zlevelinfo/ship))
						found_obj = new /obj/effect/overmapobj/ship()
					else
						found_obj = new /obj/effect/overmapobj()

					//spawn the center of the world
					found_obj.x = 1
					found_obj.y = 1
					found_obj.z = OVERMAP_ZLEVEL

					//testing("	no overmapobj yet, \"[data.name]\" was spawned at rand coords ([found_obj.x],[found_obj.y]), not initialising")

				if(!found_obj.initialised && data.use_me_to_initialise)
					//testing("	initialising")
					initialise_overmapobj(found_obj, data)

				found_obj.linked_zlevelinfos += data
				map_sectors["[level]"] = found_obj

	for(var/obj/effect/overmapobj/ship/S in world)
		S.update_spaceturfs()

	//Setup datanets
	setup_datanets()

	init_virtual_areas()
	if(innie_base)
		innie_base.loc = virtual_zlevel.loc

	current_starsystem = new()
	all_starsystems.Add(current_starsystem)
	//
	current_starsystem.place_asteroid_fields()
	overmap_scanner_manager.add_asteroidfields(current_starsystem.asteroid_fields)

	/*for(var/x in 1 to 3)
		load_prepared_sector("Meteor Shower", "MeteorShower[x]")*/

	//callHook("customOvermap", list(overmap_controller))

	for(var/obj/machinery/computer/helm/H in machines)
		H.reinit()

	return 1

datum/controller/process/overmap/proc/get_or_create_cached_zlevel()
	var/obj/effect/zlevelinfo/data
	if(!cached_zlevels.len)
		data = create_new_zlevel()
	else
		data = cached_zlevels[cached_zlevels.len]
	cached_zlevels -= data

	return data

datum/controller/process/overmap/proc/create_new_zlevel()
	//extend the world depth by adding a whole new zlevel
	world << "<span class='danger'>Adding new zlevel, server may lag for a few seconds to a minute...</span>"
	var/starttime = world.time

	sleep(1)
	world.maxz++
	var/obj/effect/zlevelinfo/data = new(locate(1, 1, world.maxz))
	cached_zlevels += data
	world << "<span class='danger'>	Finished adding new zlevel ([(world.time - starttime)/10]).</span>"
	return data

datum/controller/process/overmap/proc/get_finished_asteroid_zlevel()
	if(asteroid_zlevels_ready.len)
		return pop(asteroid_zlevels_ready)

datum/controller/process/overmap/proc/get_or_create_asteroid_zlevel()
	. = get_finished_asteroid_zlevel()
	if(.)
		return .

	if(asteroid_zlevels_loading_unassigned.len)
		. = pop(asteroid_zlevels_loading_unassigned)
		asteroid_zlevels_loading_assigned.Add(.)
		return .

	//get an ordinary zlevel
	var/obj/effect/zlevelinfo/new_level = get_or_create_cached_zlevel()

	//create a special asteroid type info marker
	var/obj/effect/zlevelinfo/bigasteroid/asteroid_level = new(new_level.loc)

	//clear out the old one
	new_level.tag = null
	qdel(new_level)

	//setup the new one
	asteroid_level.tag = "zlevel[asteroid_level.z]"
	asteroid_zlevels.Add(asteroid_level)
	asteroid_zlevels_loading_assigned.Add(asteroid_level)
	asteroid_level.begin_generation()

	//return the result
	. = asteroid_level
