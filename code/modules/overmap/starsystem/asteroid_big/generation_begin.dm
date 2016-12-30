
/obj/effect/zlevelinfo/bigasteroid/proc/begin_generation(var/masks_also = 0)
	centre_turf = locate(127, 127, src.z)
	if(masks_also)
		gen_stage = BIGASTEROID_MASKING
	else
		gen_stage = BIGASTEROID_PICKMORPH//BIGASTEROID_CAVES_SEED

	corner_turfs = morphturfs
	/*for(var/obj/effect/morphmarker/marker in myzlevel.morphmarkers)
		qdel(marker)*/

	map_turfs = asteroid_masks["[src.z]"]

	config = overmap_controller.asteroid_gen_config

	//lets start in a little bit as a shortcut
	gen_x = max(127 - config.target_radius - 5, 1)
	gen_y = max(127 - config.target_radius - 5, 1)
	corner_dist = config.target_radius * config.target_radius
	rsq = config.target_radius * (config.target_radius + 0.5)

	//choose which minerals will spawn

	//abundant ores
	var/num_ores = Ceiling(all_abundant_ores.len/4)
	while(num_ores > 0 && unused_abundant_ores.len > 0)
		//pick one at random
		var/orename = pick(unused_abundant_ores)
		var/ore/ore = unused_abundant_ores[orename]
		mineral_spawn_list[orename] = ore.spawn_weight

		//remove them from the list of candidates
		unused_abundant_ores -= orename
		num_ores -= 1

	//common ores
	num_ores = Ceiling(all_common_ores.len/4)
	while(num_ores > 0 && unused_common_ores.len > 0)
		//pick one at random
		var/orename = pick(unused_common_ores)
		var/ore/ore = unused_common_ores[orename]
		mineral_spawn_list[orename] = ore.spawn_weight

		//remove them from the list of candidates
		unused_common_ores -= orename
		num_ores -= 1

	//rare ores
	num_ores = Ceiling(all_rare_ores.len/4)
	while(num_ores > 0 && unused_rare_ores.len > 0)
		//pick one at random
		var/orename = pick(unused_rare_ores)
		var/ore/ore = unused_rare_ores[orename]
		mineral_spawn_list[orename] = ore.spawn_weight

		//remove them from the list of candidates
		unused_rare_ores -= orename
		num_ores -= 1

	//cave_ore_map = new /datum/random_map/automata/cave_system(null,1,1,myzlevel.z,255,255, 0, 1, 1, "Z[myzlevel.z] asteroid ore caves")
	//cave_ore_map.start_iteration()
	//cave_ore_map = new()
	//cave_ore_map.map_turfs = mask_turfs
