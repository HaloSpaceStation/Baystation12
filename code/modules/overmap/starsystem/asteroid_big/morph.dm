
/obj/effect/zlevelinfo/bigasteroid/proc/step_morphing()
	set background = 1
	. = 1

	if(!spawn_type || !trigger_type)
		log_admin("alert! step_morphing() failed because it didnt spawn_type or trigger_type were not set for asteroid ([src.x],[src.y],[src.z])")
		return 0

	//this proc amorphously (via random flood fill) expands or contracts one of the "corner" turfs we marked earlier to make the sphere non-uniform
	//early versions were a little tentacley, so i've tweaked the config settings to avoid most of that
	var/total_weight = config.pop_weight + config.rand_weight

	if(morphing_turfs.len && num_processed < num_this_morph)
		//get the next turf and remove it from the list
		//a pick tends to create tentacley blobs, while a pop tends to create flattish blocks
		//how these are weighted finds a balance between the 2
		var/turf/cur_turf
		if(prob(100 * config.rand_weight / total_weight))
			cur_turf = pick(morphing_turfs)
		else
			cur_turf = morphing_turfs[1]
		morphing_turfs -= cur_turf
		//new /obj/item/broken_device(cur_turf)

		//get all adjacent turfs
		var/list/nearby = orange(1, cur_turf)

		//replace the current turf
		if(cur_turf.type != spawn_type)
			cur_turf = new spawn_type(cur_turf)
			map_turfs |= cur_turf
			//new /obj/item/pipe(cur_turf)

		//update outer bounds
		if(cur_turf.x > max_gen_x)
			max_gen_x = cur_turf.x
		if(cur_turf.y > max_gen_y)
			max_gen_y = cur_turf.y
		//
		if(cur_turf.x < min_gen_x)
			min_gen_x = cur_turf.x
		if(cur_turf.y < min_gen_y)
			min_gen_y = cur_turf.y

		/*var/cur_dist = get_dist(start_turf, new_turf)
		if(do_mutation)
			world << "	curdist: [cur_dist]"
			if(cur_dist >= overmap_controller.average_morph_diameter * overmap_controller.diameter_percent_trigger)
				mutation_turf = new_turf*/

		//dont overwrite any turfs we have already processed later
		//this shouldnt error if the turfs arent on the list beforehand
		corner_turfs -= nearby

		//chance to spread the asteroid onto nearby mask tiles
		while(nearby.len)
			var/turf/T = pop(nearby)
			//nearby -= T
			if(istype(T, trigger_type) && prob(config.spread_chance))
				morphing_turfs.Add(T)

		//dont spread too far
		num_processed++

	/*if(mutation_turf)
		world << "mutation spawned at [mutation_turf.x],[mutation_turf.y]"
		corner_turfs += mutation_turf
		if(mark_type)
			new /obj/effect/spresent(mutation_turf)*/
	else
		. = 0
