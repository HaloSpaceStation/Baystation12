
/obj/effect/zlevelinfo/bigasteroid/proc/step_ore(var/num_steps)
	. = 1

	var/cur_step = 1
	for(cur_step, cur_step <= num_steps, cur_step++)
		if(ore_turf_candidates.len < 1 || num_ore >= ore_max)
			. = 0
			break

		var/turf/simulated/mineral/vein_source = pick(ore_turf_candidates)
		ore_turf_candidates -= vein_source
		num_ore++

		var/orename = pickweight(mineral_spawn_list)
		var/ore/O = ore_data[orename]
		//vein_source.MineralSpread()

		var/vein_max = 1
		switch(O.vein_size)
			if(3)
				vein_max = rand(20, 30)
			if(2)
				vein_max = rand(8, 16)
			else
				vein_max = rand(1, 5)

		//spread the vein
		var/num_ores = 0
		var/list/working_turfs = list(vein_source)
		while(working_turfs.len > 0 && num_ores < vein_max)
			var/var/turf/simulated/mineral/ore_turf = pick(working_turfs)
			working_turfs -= ore_turf
			ore_turf.mineral = O
			ore_turf.UpdateMineral()
			num_ores += 1

			//get surrounding viable turfs to spread to
			for(var/turf/simulated/mineral/T in orange(1, ore_turf))
				if(T.mineral)
					continue
				working_turfs.Add(T)

		/*
		if(mineral && mineral.spread)
			for(var/trydir in cardinal)
				if(prob(mineral.spread_chance))
					var/turf/simulated/mineral/target_turf = get_step(src, trydir)
					if(istype(target_turf) && !target_turf.mineral)
						target_turf.mineral = mineral
						target_turf.UpdateMineral()
						target_turf.vein_source = vein_source
						vein_source.vein_size += 1
						if(vein_source.vein_size >= vein_source.vein_max)
							target_turf.MineralSpread()
				*/
