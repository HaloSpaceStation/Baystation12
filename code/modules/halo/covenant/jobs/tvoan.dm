
/datum/job/covenant/skirmminor
	title = "T-Vaoan Skirmisher"
	total_positions = -1
	spawn_positions = -1
	outfit_type = /decl/hierarchy/outfit/skirmisher_minor
	access = list(access_covenant)
	whitelisted_species = list(/datum/species/kig_yar_skirmisher)

	radio_speech_size = RADIO_SPEECH_SPECIALIST

/datum/job/covenant/skirmmajor
	title = "T-Vaoan Major"
	total_positions = 2
	spawn_positions = 2
	faction_whitelist = "Covenant"
	outfit_type = /decl/hierarchy/outfit/skirmisher_major
	access = list(access_covenant, access_covenant_command)
	whitelisted_species = list(/datum/species/kig_yar_skirmisher)
	access = list(access_covenant, access_covenant_cargo)

	radio_speech_size = RADIO_SPEECH_SPECIALIST

/datum/job/covenant/skirmmurmillo
	title = "T-Vaoan Murmillo"
	total_positions = 1
	spawn_positions = 1
	outfit_type = /decl/hierarchy/outfit/skirmisher_murmillo
	alt_titles = list(\
		"T-Vaoan Minor" = /decl/hierarchy/outfit/skirmisher_minor,
		"T-Vaoan Major" = /decl/hierarchy/outfit/skirmisher_major)
	access = list(access_covenant, access_covenant_command, access_covenant_slipspace, access_covenant_cargo)
	faction_whitelist = "Covenant"
	whitelisted_species = list(/datum/species/kig_yar_skirmisher)
	pop_balance_mult = 1.5 //They're worth a bit more than a marine due to their speed.
	open_slot_on_death = 1 //Since the speed nerf, these aren't nearly as powerful as they used to be.

	radio_speech_size = RADIO_SPEECH_SPECIALIST

/datum/job/covenant/skirmcommando
	title = "T-Vaoan Commando"
	total_positions = 1
	spawn_positions = 1
	outfit_type = /decl/hierarchy/outfit/skirmisher_commando
	access = list(access_covenant, access_covenant_command, access_covenant_slipspace, access_covenant_cargo)
	faction_whitelist = "Covenant"
	whitelisted_species = list(/datum/species/kig_yar_skirmisher)
	pop_balance_mult = 1.5 //They're worth a bit more than a marine due to their speed.

	radio_speech_size = RADIO_SPEECH_SPECIALIST

/datum/job/covenant/skirmchampion
	title = "T-Vaoan Champion"
	total_positions = 1
	spawn_positions = 1
	outfit_type = /decl/hierarchy/outfit/skirmisher_champion
	access = list(access_covenant, access_covenant_command, access_covenant_slipspace, access_covenant_cargo)
	faction_whitelist = "Covenant"
	whitelisted_species = list(/datum/species/kig_yar_skirmisher)
	pop_balance_mult = 2 //They have stronger shield gauntlets than murmillos and the commando's holo decoy.

	radio_speech_size = RADIO_SPEECH_LEADER