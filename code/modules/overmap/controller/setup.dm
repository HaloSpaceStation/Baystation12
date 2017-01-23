
datum/controller/process/overmap/setup()

	/*if(!config.use_overmap)
		return kill()*/

	overmap_controller = src

	testing("Building overmap...")

	//to enable debugging
	map_sectors_reference = map_sectors
	cached_zlevels_reference = cached_zlevels

	var/obj/effect/zlevelinfo/data
	for(var/level in 1 to world.maxz)
		data = locate("zlevel[level]")
		if(data)
			testing("Z-Level [level] is enabled on overmap")

			if(istype(data, /obj/effect/zlevelinfo/precached))
				testing("	pre-cached empty space")
				/*var/obj/effect/overmapobj/precached_zlevels = new /obj/effect/overmapobj()
				precached_zlevels.loc = null*/
				cached_zlevels += data

			/*else if(istype(data, /obj/effect/zlevelinfo/precreated))
				testing("Adding precreated ship! Tag: [data.tag] Name: [data.name] at [data.mapx],[data.mapy] corresponding to z[level]")
				//map_sectors["[level]"] = new /obj/effect/overmapobj(data)
				cached_zlevelspre["[data.name]"] = data*/

			else
				var/obj/effect/overmapobj/found_obj = locate("[data.name]")

				if(found_obj)
					if(!found_obj.initialised && data.use_me_to_initialise)
						testing("	belongs to \"[data.name]\", initialising")
						initialise_overmapobj(found_obj, data)
					else
						testing("	belongs to \"[data.name]\"")
				else
					//If there is no obj with such name, we will create one.
					if(istype(data, /obj/effect/zlevelinfo/ship))
						found_obj = new /obj/effect/overmapobj/ship()
					else
						found_obj = new /obj/effect/overmapobj()

					//spawn the ship at random coords, since one wasn't preplaced on the overmap
					found_obj.x = rand(OVERMAP_EDGE, world.maxx - OVERMAP_EDGE)
					found_obj.y = rand(OVERMAP_EDGE, world.maxy - OVERMAP_EDGE)
					found_obj.z = OVERMAP_ZLEVEL

					if(data.use_me_to_initialise)
						testing("	no overmapobj yet, \"[data.name]\" was spawned at rand coords ([found_obj.x],[found_obj.y]), initialising")
						initialise_overmapobj(found_obj, data)
					else
						testing("	no overmapobj yet, \"[data.name]\" was spawned at rand coords ([found_obj.x],[found_obj.y]), not initialising")

				found_obj.linked_zlevelinfos += data
				map_sectors["[level]"] = found_obj

	for(var/obj/effect/overmapobj/ship/S in world)
		S.update_spaceturfs()

	current_starsystem = new()
	all_starsystems.Add(current_starsystem)

	world << "<span class='danger'>Populating asteroid fields...</span>"
	current_starsystem.generate_asteroid_fields()

	/*for(var/x in 1 to 3)
		load_prepared_sector("Meteor Shower", "MeteorShower[x]")*/

	//callHook("customOvermap", list(overmap_controller))

	for(var/obj/machinery/computer/helm/H in machines)
		H.reinit()

	return 1
