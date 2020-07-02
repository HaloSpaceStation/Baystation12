
/datum/techprint/energy_shielding_one
	name = "Energy Shielding I"
	desc = "Theoretical shield design based off Covenant energy shield generators."
	tech_req_one = list(\
		/datum/techprint/sangheili_bodysuit,\
		/datum/techprint/kigyar_gauntlet,\
		/datum/techprint/tvoan_gauntlet,\
		/datum/techprint/shield_barricade)
	ticks_max = 120
/*
/datum/techprint/bubble_shield
	name = "Bubble Shield"
	tech_req_all = list(/datum/techprint/energy_shielding_one, /datum/techprint/energy)
	required_reagents = list(/datum/reagent/toxin/phoron = 100)
	ticks_max = 120
*/
/datum/techprint/human_shield_ablative
	name = "Ablative Battle Shield"
	desc = "Energy dispersal plates allows for battlefield use of handheld shields against the Covenant."
	design_unlocks = list(/datum/research_design/shield_ablative)
	required_reagents = list(/datum/reagent/tungsten = 20)
	required_materials = list("glass" = 20, "plastic" = 20, "steel" = 20)
	ticks_max = 225
	tech_req_all = list(/datum/techprint/ablative)

/datum/techprint/human_shield_gauntlet
	name = "UNSC Handheld Shield Gauntlet"
	desc = "Analysis of Jackal shield gauntlets allows for reverse engineered human versions."
	design_unlocks = list(/datum/research_design/shield_energy)
	required_reagents = list(/datum/reagent/tungsten = 20)
	required_materials = list("glass" = 20, "plastic" = 20, "steel" = 20)
	tech_req_all = list(\
		/datum/techprint/energy_shielding_one,\
		/datum/techprint/human_shield_ablative)
	ticks_max = 275
