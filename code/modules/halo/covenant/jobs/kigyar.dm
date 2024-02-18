
/datum/job/covenant/kigyarminor
	title = "Kig-Yar"
	total_positions = -1
	spawn_positions = -1
	outfit_type = /decl/hierarchy/outfit/kigyar
	alt_titles = list(\
		"Kig-Yar Ranger" = /decl/hierarchy/outfit/kigyar_ranger,
		"Kig-Yar Major" = /decl/hierarchy/outfit/kigyar/major)
	whitelisted_species = list(/datum/species/kig_yar)

/datum/job/covenant/kigyar_marksman
	title = "Kig-Yar Marksman"
	total_positions = 2
	spawn_positions = 2
	outfit_type = /decl/hierarchy/outfit/kigyar/marksman
	faction_whitelist = "Covenant"
	whitelisted_species = list(/datum/species/kig_yar)

/datum/job/covenant/kigyar_sniper
	title = "Kig-Yar Sniper"
	total_positions = 1
	spawn_positions = 1
	outfit_type = /decl/hierarchy/outfit/kigyar/marksman_beamrifle
	faction_whitelist = "Covenant"
	whitelisted_species = list(/datum/species/kig_yar)
/*
/datum/job/covenant/kigyarcorvette/captain
	title = "Kig-Yar Shipmistress"
	total_positions = 1
	spawn_positions = 1
	outfit_type = /decl/hierarchy/outfit/kigyarcorvette/captain
	access = list(240,250)
	faction_whitelist = "Covenant"
	whitelisted_species = list(/datum/species/kig_yar)
*/