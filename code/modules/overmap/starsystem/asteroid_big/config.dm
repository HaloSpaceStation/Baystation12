
//some generation config settings (todo: move these to the config controller or something? idk)
/datum/asteroid_gen_config
	var/spread_chance = 75
	var/upper_morph_turfs = 1500
	var/lower_morph_turfs = 5
	//var/mark_points_of_interest = 1
	//
	/*var/average_morph_diameter = 1		//recalculated each step
	var/diameter_percent_trigger = 0.3
	var/mutation_chance = 15*/
	var/asteroid_steps_per_process = 7000
	//
	var/pop_weight = 1
	var/rand_weight = 2
	//
	var/expand_weight = 3
	var/contract_weight = 2
	var/skip_weight = 1
	//
	var/repeats_lower = 0
	var/repeats_upper = 5
	//
	var/skips_lower = 1
	var/skips_upper = 1
	//
	var/target_radius = 80
	//
	var/smoothing_passes = 3
	var/smooth_threshold = 5
	//
	var/cave_iterations = 5
	var/cave_wall_prob = 55

	var/interrupting = 1
