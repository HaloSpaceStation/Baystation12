/datum/species/sangheili
	name = "Sangheili"
	name_plural = "sangheili"
	blurb = "Shouldn't be seeing this." // Doesn't appear in chargen
	flesh_color = "#4A4A64"
	blood_color = "#4A4A64"
	icobase = 'code/modules/halo/icons/species/r_elite.dmi' //The DMI needed modification to fit the usual format (see other species' dmis)
	deform = 'code/modules/halo/icons/species/r_elite.dmi'
	icon_template = 'code/modules/halo/icons/species/r_elite_template.dmi'
	default_language = "Sangheili"
	language = "Sangheili"
	total_health = 150 // Stronger than humans at base health.
	radiation_mod = 0.6 //Covie weapons emit beta radiation. Resistant to 1/3 types of radiation.
	spawn_flags = IS_WHITELISTED
	brute_mod = 0.9

	inherent_verbs = list()

	has_organ = list(
	"heart" =    /obj/item/organ/heart,
	"second heart" =	 /obj/item/organ/heart_secondary,
	"lungs" =    /obj/item/organ/lungs,
	"liver" =    /obj/item/organ/liver,
	"kidneys" =  /obj/item/organ/kidneys,
	"brain" =    /obj/item/organ/brain,
	"appendix" = /obj/item/organ/appendix,
	"eyes" =     /obj/item/organ/eyes
	)
