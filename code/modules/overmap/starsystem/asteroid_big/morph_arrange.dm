
/obj/effect/zlevelinfo/bigasteroid/proc/arrange_morph_markers()
	set background = 1
	var/list/arranged_morphs = list(starting_morph)
	starting_morph.name = "1"

	var/obj/effect/morphmarker/next_morph = starting_morph
	var/list/dir_priorities = list(WEST, NORTHWEST, NORTH, NORTHEAST, EAST, SOUTHEAST, SOUTH, SOUTHWEST)
	while(next_morph)

		//world << "next_morph ([next_morph.x],[next_morph.y])"
		var/obj/effect/morphmarker/chosen_morph
		var/turf/myturf = next_morph.loc
		next_morph = null
		for(var/curdist = 1, curdist < 10, curdist++)
			//world << "	curdist:[curdist]"
			var/list/nearby = orange(curdist, myturf)

			for(var/curdir in dir_priorities)
				//world << "		curdir:[curdir]"

				for(var/obj/effect/morphmarker/check_morph in nearby)
					if(check_morph in arranged_morphs)
						continue

					var/checkdir = get_dir(myturf, check_morph)
					//world << "			checkdir:[checkdir] ([check_morph.x],[check_morph.y])"
					if(curdir == checkdir)
						chosen_morph = check_morph
						chosen_morph.name = "[arranged_morphs.len + 1]"
						arranged_morphs.Add(chosen_morph)
						next_morph = chosen_morph
						//world << "				success! ([next_morph.x],[next_morph.y])"
						break

				if(chosen_morph)
					break

			if(chosen_morph)
				break

		sleep(1)
