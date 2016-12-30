
/obj/effect/zlevelinfo/bigasteroid
	name = "random asteroid level"
	var/list/morphturfs = list()
	var/list/morphmarkers = list()
	//
	var/datum/asteroid_gen_config/config

	//generation
	var/gen_x = 1
	var/gen_y = 1
	var/turf/current_turf
	var/gen_stage = BIGASTEROID_STOP
	var/generating = 1

	//generated bounds
	var/max_gen_x = 1
	var/min_gen_x = 255
	var/max_gen_y = 1
	var/min_gen_y = 255

	//masking
	var/turf/centre_turf
	var/list/corner_turfs = list()
	var/corner_dist = 1
	var/rsq = 1
	//var/list/mask_turfs = list()
	var/list/map_turfs = list()
	var/list/map_turfs_next = list()

	//morphing
	var/repeats_left = 0
	var/last_dir = ""
	var/trigger_type
	var/spawn_type
	var/turf/morph_turf
	var/list/morphing_turfs = list()
	var/num_processed = 0
	var/num_this_morph = 1
	var/obj/effect/morphmarker/starting_morph

	//smoothing
	var/num_smoothes = 0

	var/list/mineral_spawn_list = list()

/obj/effect/zlevelinfo/bigasteroid/proc/update_overlays()
	//set src in view(7)

	var/starttime = world.time
	log_admin("update_overlays()...")
	for(var/turf/simulated/mineral/M in world)
		M.updateMineralOverlays()
	for(var/turf/simulated/floor/asteroid/M in world)
		M.updateMineralOverlays()
	log_admin("	Done update_overlays() ([(world.time - starttime) / 10]s).")
