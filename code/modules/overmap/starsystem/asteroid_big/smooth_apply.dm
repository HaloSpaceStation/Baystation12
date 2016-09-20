
/obj/effect/zlevelinfo/bigasteroid/proc/step_smoothing_apply(var/num_steps = 1)
	. = 1

	//loop over the final calculated smoothing map and apply our changes
	//this only makes one pass because we're finalising the smoothing process by applying it
	var/cur_step = 1
	for(cur_step, cur_step <= num_steps, cur_step++)
		var/turf/cur_turf = map_turfs[current_index]
		var/mapval = map_turfs[cur_turf]
		//new /obj/effect/rune(cur_turf)
		if(mapval == "w")
			if(!istype(cur_turf, /turf/unsimulated/mask))
				//this must be a lonely space turf which will be "smoothed" into a mask turf
				cur_turf = new /turf/unsimulated/mask(cur_turf)
				//new /obj/item/pizzabox(cur_turf)
		else
			if(!istype(cur_turf, /turf/space))
				//this must be a lonely mask turf which will be "smoothed" into a space turf
				cur_turf = new /turf/space(cur_turf)
				//new /obj/effect/spresent(cur_turf)

			//remove any space turfs to speed up later loops
			map_turfs_next -= cur_turf

		current_index += 1
		if(current_index > map_turfs.len)
			. = 0
			current_index = 1
			map_turfs = map_turfs_next
			break
