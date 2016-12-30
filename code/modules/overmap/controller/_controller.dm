
//===================================================================================
//Controller to build and update overmap
//===================================================================================

//see code\controllers\Processes\overmap.dm

var/global/datum/controller/process/overmap/overmap_controller
var/global/list/map_sectors = list()		//array of strings w/ all zlevel numbers stored as strings, each string indexes the associated overmap obj for that zlevel
var/global/list/cached_zlevels = list()		//unused and empty zlevels in case they are needed for something

/datum/controller/process/overmap
	name = "overmap controller"
	var/list/map_sectors_reference
	var/list/cached_zlevels_reference
	var/list/all_datanets_reference
	var/list/uninitialised_datanets_reference

	var/list/moving_levels = list()

	var/obj/effect/overmapobj/protagonist_home
	var/obj/effect/overmapobj/antagonist_home

	var/protagonist_faction = "UNSC"
	var/list/faction_iff_colour = list("UNSC" = "#00FF00", "Insurrection" = "#FF0000", "Covenant" = "#FF00FF")
	var/galaxy_travel_enabled = 0
	var/friend_colour = "#00FF00"
	var/foe_colour = "#FF0000"

	var/list/trash_zlevels = list()

	var/obj/effect/starsystem/current_starsystem
	var/list/all_starsystems = list()

	var/list/overmap_vehicles_in_transit = list()
	var/list/bases_by_faction[][]

	var/datum/scanner_manager/overmap_scanner_manager

	var/datum/asteroid_gen_config/asteroid_gen_config

	var/list/all_abundant_ores_reference
	var/list/all_common_ores_reference
	var/list/all_rare_ores_reference
	//
	var/list/unused_abundant_ores_reference
	var/list/unused_common_ores_reference
	var/list/unused_rare_ores_reference

	var/list/asteroid_zlevels = list()
	var/list/asteroid_zlevels_loading_assigned = list()
	var/list/asteroid_zlevels_loading_unassigned = list()
	var/obj/effect/zlevelinfo/bigasteroid/asteroid_zlevel_loading
	var/list/asteroid_zlevels_ready = list()

/datum/controller/process/overmap/doWork()
	//see temporary_sector.dm
	process_temp_sectors()

	//load our asteroid zlevels
	var/steps_per_asteroid = asteroid_gen_config.asteroid_steps_per_process
	if(asteroid_zlevel_loading)
		//prioritise loading this asteroid first
		spawn(0)
			if(!asteroid_zlevel_loading.step_generation(steps_per_asteroid))
				asteroid_zlevels_ready.Add(asteroid_zlevel_loading)
				asteroid_zlevel_loading = null

	else if(asteroid_zlevels_loading_assigned.len)
		//prioritise generating any assigned asteroids
		var/num_steps = steps_per_asteroid / (asteroid_zlevels_loading_assigned.len)
		for(var/obj/effect/zlevelinfo/bigasteroid/asteroid_zlevel in asteroid_zlevels_loading_assigned)
			spawn(0)
				if(!asteroid_zlevel.step_generation(num_steps))
					asteroid_zlevels_loading_assigned.Remove(asteroid_zlevel)

	else if(asteroid_zlevels_loading_unassigned.len)
		//split between any remaining unassigned asteroids
		var/num_steps = steps_per_asteroid / (asteroid_zlevels_loading_unassigned.len)
		for(var/obj/effect/zlevelinfo/bigasteroid/asteroid_zlevel in asteroid_zlevels_loading_unassigned)
			spawn(0)
				if(!asteroid_zlevel.step_generation(num_steps))
					asteroid_zlevels_ready.Add(asteroid_zlevel)
					asteroid_zlevels_loading_unassigned.Remove(asteroid_zlevel)

//just a placeholder proc for now. eventually have the mapunloader run over these levels to turn them back to empty space
//then add them to the list to be reused
/datum/controller/process/overmap/proc/recycle_omapobj(var/obj/effect/overmapobj/trash)
	for(var/obj/effect/zlevelinfo/trashlevel in trash.linked_zlevelinfos)
		trash_zlevels.Add(trashlevel)
	qdel(trash)

/datum/controller/process/overmap/proc/recycle_zlevel(var/obj/effect/zlevelinfo/trashlevel)
	trash_zlevels.Add(trashlevel)

/datum/controller/process/overmap/proc/attempt_recycle_deepspace_atom(var/atom/movable/A)
	//keep tracking all mobs, otherwise everything else can get permanently "lost" in deep space
	if(!ismob(A))
		qdel(A)
		return 1

	return 0

//zlevels we want to make inaccessible, disable transit, disable sensors, disable radio
/datum/controller/process/overmap/proc/is_restricted_z(var/obj/effect/zlevelinfo/curz)
	. = 0
	if(curz.z == OVERMAP_ZLEVEL)
		return 1

	if(curz == virtual_zlevel)
		return 1
