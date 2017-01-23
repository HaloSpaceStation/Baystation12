/datum/species/elite
	name = "Elite"
	name_plural = "Elites"
	icobase = 'UNSC/r_minor.dmi'
	deform = 'icons/mob/human_races/r_def_vox.dmi'
	default_language = "Sol Common"
	language = "Galactic Common"
	unarmed_types = list(/datum/unarmed_attack/stomp, /datum/unarmed_attack/kick,  /datum/unarmed_attack/claws/strong, /datum/unarmed_attack/bite/strong)
	rarity_value = 2
	blurb = "cool guys man."

	speech_sounds = list('sound/voice/shriek1.ogg')
	speech_chance = 20

	warning_low_pressure = 50
	hazard_low_pressure = 0

	cold_level_1 = 80
	cold_level_2 = 50
	cold_level_3 = 0

	eyes = "vox_eyes_s"

	breath_type = "nitrogen"
	poison_type = "oxygen"
	siemens_coefficient = 0.2

	flags = CAN_JOIN | IS_WHITELISTED | NO_SCAN | HAS_EYE_COLOR

	blood_color = "#2299FC"
	flesh_color = "#808D11"

	inherent_verbs = list(
		/mob/living/carbon/human/proc/leap
		)

	has_organ = list(
		"heart" =    /obj/item/organ/heart,
		"lungs" =    /obj/item/organ/lungs,
		"liver" =    /obj/item/organ/liver,
		"kidneys" =  /obj/item/organ/kidneys,
		"brain" =    /obj/item/organ/brain,
		"eyes" =     /obj/item/organ/eyes
		)

/datum/species/elite/get_random_name(var/gender)
	var/datum/language/species_language = all_languages[default_language]
	return species_language.get_random_name(gender)