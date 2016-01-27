
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

	var/obj/effect/zlevelinfo/transit_level
	var/list/overmap_vehicles_in_transit = list()
	var/list/bases_by_faction[][]

/datum/controller/process/overmap/doWork()
	//see temporary_sector.dm
	process_temp_sectors()

//just a placeholder proc for now. eventually have the mapunloader run over these levels to turn them back to empty space
//then add them to the list to be reused
/datum/controller/process/overmap/proc/recycle_omapobj(var/obj/effect/overmapobj/trash)
	for(var/obj/effect/zlevelinfo/trashlevel in trash.linked_zlevelinfos)
		trash_zlevels.Add(trashlevel)
	qdel(trash)

/datum/controller/process/overmap/proc/recycle_zlevel(var/obj/effect/zlevelinfo/trashlevel)
	trash_zlevels.Add(trashlevel)

/datum/controller/process/overmap/proc/get_friend_foe_colour(var/my_faction, var/other_faction)
	//just do the easy thing for now until we get a more complex faction and subfaction system developed
	if(my_faction == other_faction)
		return friend_colour

	var/list/main_factions = list("UNSC", "Insurrection", "Covenant")
	if((my_faction in main_factions) && (other_faction in main_factions))
		return foe_colour

/datum/controller/process/overmap/proc/get_random_faction_base(var/check_faction)
	var/list/faction_bases = get_faction_bases(check_faction)

	if(faction_bases.len)
		return pick(faction_bases)

/datum/controller/process/overmap/proc/get_faction_bases(var/check_faction)
	if(check_faction)
		if(!bases_by_faction[check_faction])
			bases_by_faction[check_faction] = list()
		var/list/faction_bases = bases_by_faction[check_faction]

		return faction_bases
