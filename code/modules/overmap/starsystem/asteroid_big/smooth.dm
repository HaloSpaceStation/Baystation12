
/obj/effect/zlevelinfo/bigasteroid/proc/step_smoothing(var/num_steps = 1)
	. = 1

	//loop over the morphed masks and smooth them out so they dont look ugly
	//make multiple passes if necessary
	var/cur_step = 1
	for(cur_step, cur_step <= num_steps, cur_step++)
		var/turf/cur_turf = map_turfs[current_index]
		var/mapval = map_turfs[cur_turf]
		var/w_count = 0
		//new /obj/item/pipe_meter(cur_turf)

		if(mapval)
			for(var/x_offset = -1, x_offset <= 1, x_offset++)
				for(var/y_offset = -1, y_offset <= 1, y_offset++)
					var/turf/tmp_cell = locate(cur_turf.x + x_offset, cur_turf.y + y_offset, cur_turf.z)
					if(map_turfs[tmp_cell] == "w")
						w_count++
						//new /obj/item/pipe_meter(cur_turf)
					else
						//new /obj/item/organ/brain(cur_turf)
		else
			//if mapval is unset (null) then we are on our first pass and need to check the nearby turfs instead of our own data map
			for(var/x_offset = -1, x_offset <= 1, x_offset++)
				for(var/y_offset = -1, y_offset <= 1, y_offset++)
					var/turf/tmp_cell = locate(cur_turf.x + x_offset, cur_turf.y + y_offset, cur_turf.z)
					if(istype(tmp_cell, /turf/unsimulated/mask))
						w_count++

						//this shouldnt be necessary, but it should also fix an issue with some turfs getting ignored by the smoothing
						//map_turfs_next[tmp_cell] = "w"

						//new /obj/item/organ/cell(cur_turf)
					else
						//insert adjacent space turfs on our initial pass so we can smooth them down as well (but do it in future passes)
						map_turfs_next[tmp_cell] = "s"

						//new /obj/item/organ/diona(cur_turf)

					//just in case this cell was skipped in the morphing prcess, we still might want to smooth it
					//map_turfs_next |= tmp_cell

		//if there's at least 4, stay the same for next iteration otherwise flip
		if(w_count >= config.smooth_threshold)
			map_turfs_next[cur_turf] = "w"
		else
			map_turfs_next[cur_turf] = "s"

		current_index += 1
		//are we finished this iteration?
		if(current_index > map_turfs.len)
			current_index = 1
			num_smoothes += 1
			//
			map_turfs = map_turfs_next.Copy()

		//iterate over multiple times
		if(num_smoothes >= config.smoothing_passes)
			. = 0
			break

		/*
		//grab the current turf
		current_turf = locate(gen_x, gen_y, myzlevel.z)
		var/same_nearby = 0
		for(var/turf/T in orange(1, current_turf))
			//check our neighbors to see what type they all are
			if(istype(T, trigger_type))
				same_nearby++

		//if there's not enough of the same turf type nearby, "smooth" it by changing it to match its neighbors
		if(same_nearby >= config.smooth_threshold)
			map_turfs |= new /turf/unsimulated/mask(current_turf)
		else
			map_turfs -= current_turf
			new /turf/space(current_turf)

		//increment the coords for the next step
		gen_x += 1
		if(gen_x > max_gen_x)
			gen_x = min_gen_x
			gen_y += 1

		//reset everything if we're done smoothing
		if(gen_y > max_gen_y)
			gen_y = min_gen_y
			num_smoothes += 1
			. = 0
			break
		*/
