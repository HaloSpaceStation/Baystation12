/datum/species/sangheili
	name = "Sangheili"
	name_plural = "sangheili"
	blurb = "Shouldn't be seeing this." // Doesn't appear in chargen
	flesh_color = "#4A4A64"
	blood_color = "4A4A64"
	icobase = 'code/modules/halo/icons/r_elite.dmi' //The DMI need modification to fit the usual format (see other species' dmis)
	deform = 'code/modules/halo/icons/r_elite.dmi'
	default_language = "Sol Common"
	language = "Galactic Common"

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
