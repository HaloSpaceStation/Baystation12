//this proc is a stripped down version of datum/random_map/automata/cave_system
//some code shamelessly copied

/obj/effect/zlevelinfo/bigasteroid
	var/list/ore_turf_candidates = list()
	var/list/ore_turfs = list()
	var/current_index = 1
	var/current_iteration = 1
	var/ore_max = 0
	var/num_ore = 0

/obj/effect/zlevelinfo/bigasteroid/proc/step_seed(var/num_steps = 1)
	. = 1
	var/cur_step = 1
	for(cur_step, cur_step <= num_steps, cur_step++)
		var/turf/cur_turf = map_turfs[current_index]
		if(prob(config.cave_wall_prob))
			map_turfs[cur_turf] = "w"
		else
			map_turfs[cur_turf] = "f"

		current_index += 1
		if(current_index > map_turfs.len)
			current_index = 1
			. = 0
			break

/obj/effect/zlevelinfo/bigasteroid/proc/step_apply(var/num_steps = 1)
	. = 1
	var/cur_step = 1
	for(cur_step, cur_step <= num_steps, cur_step++)
		var/turf/cur_turf = map_turfs[current_index++]
		if(map_turfs[cur_turf] == "f")
			new/turf/simulated/floor/asteroid(cur_turf)
		else
			//"w"
			//"m"
			//also just in case any null values slip through
			if(istype(cur_turf, /turf/unsimulated/mask))
				new/turf/simulated/mineral(cur_turf)

		if(current_index > map_turfs.len)
			current_index = 1
			. = 0
			break
