/datum/species/spartan
	name = "Spartan"
	name_plural = "Spartans"
	blurb = ""//Not in chargen
	flesh_color = "#4A4A64"
	blood_color = "#A10808"
	icobase = 'code/modules/halo/icons/species/r_Augmented_Human.dmi' //The DMI needed modification to fit the usual format (see other species' dmis)
	deform = 'code/modules/halo/icons/species/r_Augmented_Human.dmi'
	icon_template = 'code/modules/halo/icons/species/r_Augmented_Human_template.dmi'
	default_language = "Galactic Common"
	language = "Galactic Common"
	eyes = null
	total_health = 130 //Slightly lower base health increase than sangheilli
	spawn_flags = IS_WHITELISTED
	brute_mod = 0.9

	has_limbs = list(
		"chest" =  list("path" = /obj/item/organ/external/chest/augmented),
		"groin" =  list("path" = /obj/item/organ/external/groin/augmented),
		"head" =   list("path" = /obj/item/organ/external/head/augmented),
		"l_arm" =  list("path" = /obj/item/organ/external/arm/augmented),
		"r_arm" =  list("path" = /obj/item/organ/external/arm/right/augmented),
		"l_leg" =  list("path" = /obj/item/organ/external/leg/augmented),
		"r_leg" =  list("path" = /obj/item/organ/external/leg/right/augmented),
		"l_hand" = list("path" = /obj/item/organ/external/hand/augmented),
		"r_hand" = list("path" = /obj/item/organ/external/hand/right/augmented),
		"l_foot" = list("path" = /obj/item/organ/external/foot/augmented),
		"r_foot" = list("path" = /obj/item/organ/external/foot/right/augmented)
		)