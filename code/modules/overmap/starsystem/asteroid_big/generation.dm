
/*
#define BIGASTEROID_STOP 0
#define BIGASTEROID_MASKING 1
#define BIGASTEROID_PICKMORPH 2
#define BIGASTEROID_MORPHING 3
#define BIGASTEROID_SMOOTHING 4
#define BIGASTEROID_SMOOTHING_APPLY 5
#define BIGASTEROID_CAVES_SEED 6
#define BIGASTEROID_CAVES_ITER 7
#define BIGASTEROID_CAVES_ORE 8
#define BIGASTEROID_CAVES_APPLY 9
#define BIGASTEROID_CAVES_FINISH 10
*/

/obj/effect/zlevelinfo/bigasteroid/proc/step_generation(var/num_steps = 1)
	set background = 1
	. = 1

	while(num_steps > 0)
		num_steps -= 1

		switch(gen_stage)
			if(BIGASTEROID_STOP)
				. = 0

			if(BIGASTEROID_CAVES_FINISH)
				. = 0

			if(BIGASTEROID_MASKING)
				//this step is unneeded when we have a premade maskmap
				//. = 2
				if(!step_masking())
					arrange_morph_markers()
					gen_stage = BIGASTEROID_PICKMORPH

			if(BIGASTEROID_PICKMORPH)
				//pick_new_morph is very quick so lets just call the step again after
				if(pick_new_morph())
					gen_stage = BIGASTEROID_MORPHING
					. = step_generation()
				else
					gen_stage = BIGASTEROID_SMOOTHING
					. = step_generation()

			if(BIGASTEROID_MORPHING)
				//. = 3
				if(!step_morphing())
					gen_stage = BIGASTEROID_PICKMORPH

			if(BIGASTEROID_SMOOTHING)
				//loop over our random asteroid smoothing out the edges to make it look more natural
				if(!step_smoothing())
					if(num_smoothes >= config.smoothing_passes)
						gen_stage = BIGASTEROID_SMOOTHING_APPLY

			if(BIGASTEROID_SMOOTHING_APPLY)
				//this one is fairly quick in total, but we'll step it out anyway
				if(!step_smoothing_apply())
					gen_stage = BIGASTEROID_CAVES_SEED

			if(BIGASTEROID_CAVES_SEED)
				if(!step_seed(10))
					gen_stage = BIGASTEROID_CAVES_ITER

			if(BIGASTEROID_CAVES_ITER)
				if(!step_iterate(5))
					ore_max = round(map_turfs.len / 100)
					gen_stage = BIGASTEROID_CAVES_APPLY

			if(BIGASTEROID_CAVES_APPLY)
				if(!step_apply(1))
					gen_stage = BIGASTEROID_CAVES_ORE

			if(BIGASTEROID_CAVES_ORE)
				if(!step_ore(1))

					//final step
					gen_stage = BIGASTEROID_CAVES_FINISH
					message_admins("Finished generating asteroid at ([src.x],[src.y],[src.z])")
					. = 0

		if(!.)
			break
