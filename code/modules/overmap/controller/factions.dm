
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
		if(!bases_by_faction)
			bases_by_faction = list()
		if(!bases_by_faction[check_faction])
			bases_by_faction[check_faction] = list()
		var/list/faction_bases = bases_by_faction[check_faction]

		return faction_bases
