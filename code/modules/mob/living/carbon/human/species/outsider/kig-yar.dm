/datum/species/kig_yar
	name = "Kig-Yar"
	name_plural = "Kig-Yar"
	blurb = "Shouldn't be seeing this." // Doesn't appear in chargen
	flesh_color = "#FF9463"
	blood_color = "#4A4A64" //Same blood colour as Elites.
	icobase = 'code/modules/halo/icons/species/r_kig-yar.dmi' //The DMI needed modification to fit the usual format (see other species' dmis)
	deform = 'code/modules/halo/icons/species/r_kig-yar.dmi'
	default_language = "Sangheili" //Just for now, no special language just yet
	language = "Sangheili"
	radiation_mod = 0.6 //Covie weapons emit beta radiation. Resistant to 1/3 types of radiation.
	spawn_flags = IS_WHITELISTED
	brute_mod = 1.1

	has_limbs = list(
		"chest" =  list("path" = /obj/item/organ/external/chest),
		"groin" =  list("path" = /obj/item/organ/external/groin),
		"head" =   list("path" = /obj/item/organ/external/head),
		"l_arm" =  list("path" = /obj/item/organ/external/arm/hollow_bones),
		"r_arm" =  list("path" = /obj/item/organ/external/arm/right/hollow_bones),
		"l_leg" =  list("path" = /obj/item/organ/external/leg/hollow_bones),
		"r_leg" =  list("path" = /obj/item/organ/external/leg/right/hollow_bones),
		"l_hand" = list("path" = /obj/item/organ/external/hand/hollow_bones),
		"r_hand" = list("path" = /obj/item/organ/external/hand/right/hollow_bones),
		"l_foot" = list("path" = /obj/item/organ/external/foot/hollow_bones),
		"r_foot" = list("path" = /obj/item/organ/external/foot/right/hollow_bones)
		)

/obj/item/organ/external/arm/hollow_bones
	min_broken_damage = 20 //Needs 10 less damage to break

/obj/item/organ/external/arm/right/hollow_bones
	min_broken_damage = 20

/obj/item/organ/external/leg/hollow_bones
	min_broken_damage = 20

/obj/item/organ/external/leg/right/hollow_bones
	min_broken_damage = 20

/obj/item/organ/external/hand/hollow_bones
	min_broken_damage = 20

/obj/item/organ/external/hand/right/hollow_bones
	min_broken_damage = 20

/obj/item/organ/external/foot/hollow_bones
	min_broken_damage = 20

/obj/item/organ/external/foot/right/hollow_bones
	min_broken_damage = 20
