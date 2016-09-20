
/obj/effect/zlevelinfo/bigasteroid/var/list/morph_options

/obj/effect/zlevelinfo/bigasteroid/proc/pick_new_morph()
	. = 1

	//quick and dirty morph algorithm to make the asteroid non-spherical
	//loop over the "corner" turfs (a handful of turfs scattered around the edge of the asteroid)
	//each one will have either expand or contract the asteroid shape so that it looks vaguely natural
	if(corner_turfs.len)
		if(repeats_left > 0)
			repeats_left--
		else
			repeats_left = pick(config.repeats_lower, config.repeats_upper)
			morph_options = list("e" = config.expand_weight, "c" = config.contract_weight, "s" = config.skip_weight)
			num_this_morph = rand(config.upper_morph_turfs, config.lower_morph_turfs)

			//prevent more repeats than we want
			morph_options -= last_dir

			//pickweight cant handle weightings of 0
			for(var/entry in morph_options)
				if(!morph_options[entry])
					morph_options -= entry

			var/result = pickweight(morph_options)
			//world << "result: [result]"

			//world << "pick_new_morph() expand:[100 * (config.expand_weight / total_weight)] contract:[100 * (config.contract_weight / total_weight)] last_dir:[last_dir] repeats_left:[repeats_left]"
			switch(result)
				if("e")
					//expand
					last_dir = "e"
					/*var/mark_type
					if(overmap_controller.mark_points_of_interest)
						mark_type = /obj/effect/rune*/

					trigger_type = /turf/space
					spawn_type = /turf/unsimulated/mask

				if("c")
					//contract
					last_dir = "c"
					/*var/mark_type
					if(overmap_controller.mark_points_of_interest)
						mark_type = /obj/effect/golemrune*/

					trigger_type = /turf/unsimulated/mask
					spawn_type = /turf/space

				else
					//skip
					last_dir = "s"
					trigger_type = null
					spawn_type = null
					repeats_left = rand(config.skips_lower, config.skips_upper)
					while(repeats_left > 0 && corner_turfs.len)
						pop(corner_turfs)
						repeats_left--

		//reset everything for the next go
		morph_turf = pop(corner_turfs)
		//new /obj/item/inflatable(morph_turf)
		morphing_turfs = list(morph_turf)
		num_processed = 0

		/*if(last_dir > 0)
			new /obj/effect/rune(morph_turf)
		else if(last_dir < 0)
			new /obj/effect/golemrune(morph_turf)
		else
			new /obj/effect/spresent(morph_turf)*/

	else
		. = 0
