/obj/machinery/vending/armory/covenant
	icon = 'code/modules/halo/covenant/structures_machines/covendor.dmi'

/obj/machinery/vending/armory/covenant/allowed(var/mob/m) // Covenant lock
	var/mob/living/carbon/human/h = m
	if(istype(h) && h.species.type in COVENANT_SPECIES_AND_MOBS)
		return 1
	if(m & m.type in COVENANT_SPECIES_AND_MOBS)
		return 1
	return 0

/obj/machinery/vending/armory/covenant/sangheili
	name = "Sangheili Vendors"
	desc = "Test"
	icon_state ="covendor"
	icon_deny = "covendor-deny"

/obj/machinery/vending/armory/covenant/sangheili/allowed(var/mob/living/carbon/human/h)
	if(istype(h,/mob/living/silicon))
		return 1
	if(!istype(h))
		return 0
	if(h.species.type == /datum/species/sangheili)
		return 1
	return 0

/obj/machinery/vending/armory/covenant/jiralhanae
	name = "Jiralhanae Vendors"
	desc = "Test"
	icon_state ="covendor"
	icon_deny = "covendor-deny"

/obj/machinery/vending/armory/covenant/jiralhanae/allowed(var/mob/living/carbon/human/h)
	if(istype(h,/mob/living/silicon))
		return 1
	if(!istype(h))
		return 0
	if(h.species.type == /datum/species/brutes)
		return 1
	return 0

/obj/machinery/vending/armory/covenant/kigyar
	name = "Kig-Yar Vendors"
	desc = "Test"
	icon_state ="covendor"
	icon_deny = "covendor-deny"

/obj/machinery/vending/armory/covenant/kigyar/allowed(var/mob/living/carbon/human/h)
	if(istype(h,/mob/living/silicon))
		return 1
	if(!istype(h))
		return 0
	if(h.species.type == /datum/species/kig_yar || h.species.type == /datum/species/kig_yar_skirmisher)
		return 1
	return 0

/obj/machinery/vending/armory/covenant/unggoy
	name = "Grunt Vendors"
	desc = "Test"
	icon_state ="covendor"
	icon_deny = "covendor-deny"

/obj/machinery/vending/armory/covenant/unggoy/allowed(var/mob/living/carbon/human/h)
	if(istype(h,/mob/living/silicon))
		return 1
	if(!istype(h))
		return 0
	if(h.species.type == /datum/species/unggoy)
		return 1
	return 0

/obj/machinery/vending/armory/covenant/yanmee
	name = "Yanmee Vendors"
	desc = "Test"
	icon_state ="covendor"
	icon_deny = "covendor-deny"

/obj/machinery/vending/armory/covenant/yanmee/allowed(var/mob/living/carbon/human/h)
	if(istype(h,/mob/living/silicon))
		return 1
	if(!istype(h))
		return 0
	if(h.species.type == /datum/species/yanmee)
		return 1
	return 0

/obj/machinery/vending/armory/covenant/sangheili/weapon // Both ammo, and guns!
	name = "Covenant - Sangheili Weapon Vendor"
	desc = "Storage for Covenant Sangheili weapons and ammo"
	icon_state ="covendor" // SPRITES
	icon_deny = "covendor-deny"
	products = list(
	/obj/item/weapon/grenade/smokebomb/covenant = 12
	)

/obj/machinery/vending/armory/covenant/sangheili/equipment // Equipment for Sangheili
	name = "Covenant - Sangheili Equipment Vendor"
	desc = "Storage for Covenant Sangheili equipment"
	icon_state ="covendor" // SPRITES
	icon_deny = "covendor-deny"
	products = list(
	"Storage" = -1,
	/obj/item/clothing/accessory/storage/bandolier/covenant = 6,
	/obj/item/weapon/storage/belt/covenant_medic = 5,
	/obj/item/weapon/storage/belt/utility/full = 5,
	"EVA" = -1,
	/obj/item/weapon/storage/box/large/armorset/elite/eva = 4,
	/obj/item/weapon/tank/air/covenant = 9,
	/obj/item/clothing/mask/breath = 7,
	"Equipment" = -1,
	/obj/item/weapon/pickaxe/plasma_drill = 1,
	/obj/item/flight_item/covenant_pack = 1,
	/obj/item/dumb_ai_chip/cov = 2,
	/obj/item/weapon/plastique/covenant = 4,
	/obj/item/weapon/armor_patch/cov = 6,
	/obj/item/weapon/armor_patch/mini/cov = 8,
	/obj/item/weapon/pinpointer/artifact = 3,
	)

/obj/machinery/vending/armory/covenant/jiralhanae/weapon // Both ammo, and guns!
	name = "Covenant - Jiralhanae Weapon Vendor"
	desc = "Storage for Covenant Jiralhanae weapons and ammo"
	icon_state ="covendor" // SPRITES
	icon_deny = "covendor-deny"
	products = list(
	/obj/item/weapon/grav_hammer/gravless = 6,
	/obj/item/weapon/grenade/smokebomb/covenant = 12
	)

/obj/machinery/vending/armory/covenant/jiralhanae/equipment // Equipment for Jiralhanae
	name = "Covenant - Jiralhanae Equipment Vendor"
	desc = "Storage for Covenant Jiralhanae weapons and ammo"
	icon_state ="covendor" // SPRITES
	icon_deny = "covendor-deny"
	products = list(
	"EVA" = -1,
	/obj/item/weapon/storage/box/large/armorset/brute/eva = 4,
	/obj/item/weapon/tank/air/covenant = 7,
	"Storage" = -1,
	/obj/item/clothing/accessory/storage/bandolier/covenant = 6,
	/obj/item/weapon/storage/belt/covenant_medic = 5,
	/obj/item/weapon/storage/belt/covenant_ammo = 5,
	/obj/item/weapon/storage/belt/utility/full = 5,
	"Equipment" = -1,
	/obj/item/flight_item/covenant_pack = 2,
	/obj/item/dumb_ai_chip/cov = 2,
	/obj/item/weapon/armor_patch/cov = 6,
	/obj/item/weapon/armor_patch/mini/cov = 8,
	/obj/item/weapon/pinpointer/artifact = 1,
	)

/obj/machinery/vending/armory/covenant/kigyar/weapon // Both ammo, and guns!
	name = "Covenant - Kig-Yar Weapon Vendor"
	desc = "Storage for Covenant Kig-Yar weapons and ammo"
	icon_state ="covendor" // SPRITES
	icon_deny = "covendor-deny"
	products = list(
	/obj/item/weapon/melee/blamite/cutlass = 3,
	/obj/item/weapon/melee/energy/elite_sword/dagger = 8,
	/obj/item/weapon/grenade/smokebomb/covenant = 12
	)

/obj/machinery/vending/armory/covenant/kigyar/equipment // Equipment for Kig-Yar
	name = "Covenant - Kig-Yar Equipment Vendor"
	desc = "Storage for Covenant Kig-Yar equipment"
	icon_state ="covendor" // SPRITES
	icon_deny = "covendor-deny"
	products = list(
	"Storage" = -1,
	/obj/item/clothing/accessory/storage/bandolier/covenant = 10,
	/obj/item/weapon/storage/belt/covenant_medic = 5,
	/obj/item/weapon/storage/belt/utility/full = 5,
	"Equipment" = -1,
	/obj/item/flight_item/covenant_pack = 1,
	/obj/item/clothing/gloves/shield_gauntlet/kigyar = 4,
	/obj/item/clothing/under/kigyar/armless = 8,
	/obj/item/weapon/pickaxe/plasma_drill = 1,
	/obj/item/weapon/plastique/covenant = 4,
	/obj/item/weapon/armor_patch/cov = 6,
	/obj/item/weapon/pinpointer/artifact = 2
	)

/obj/machinery/vending/armory/covenant/kigyar/ranger // Equipment for Kig-Yar
	name = "Covenant - Kig-Yar Ranger Vendor"
	desc = "Storage for Covenant Kig-Yar ranger equipment"
	icon_state ="covendor" // SPRITES
	icon_deny = "covendor-deny"
	products = list(
	/obj/item/weapon/storage/box/large/armorset/kigyar/eva = 4,
	/obj/item/weapon/tank/air/covenant = 8,
	/obj/item/clothing/mask/breath = 8
	)

/obj/machinery/vending/armory/covenant/unggoy/weapon // Both ammo, and guns!
	name = "Covenant - Unggoy Weapon Vendor"
	desc = "Storage for Covenant Unggoy weapons and ammo"
	icon_state ="covendor" // SPRITES
	icon_deny = "covendor-deny"
	products = list(
	/obj/item/weapon/melee/energy/elite_sword/dagger = 12,
	/obj/item/weapon/grenade/smokebomb/covenant = 12
	)

/obj/machinery/vending/armory/covenant/unggoy/equipment // Equipment for Unggoy
	name = "Covenant - Unggoy Equipment Vendor"
	desc = "Storage for Covenant Unggoy equipment"
	icon_state ="covendor" // SPRITES
	icon_deny = "covendor-deny"
	products = list(
	"Storage" = -1,
	/obj/item/clothing/accessory/storage/bandolier/covenant = 10,
	/obj/item/weapon/storage/belt/covenant_medic = 5,
	/obj/item/weapon/storage/belt/utility/full = 5,
	"Equipment" = -1,
	/obj/item/weapon/pickaxe/plasma_drill = 1,
	/obj/item/weapon/plastique/covenant = 4,
	/obj/item/weapon/armor_patch/cov = 12,
	/obj/item/weapon/armor_patch/mini/cov = 16,
	/obj/item/weapon/pinpointer/artifact = 1
	)

/obj/machinery/vending/armory/covenant/sangheili/food
	name = "Covenant - Sangheili Food Vendor"
	desc = "A vendor for Sangheili oriented food."
	icon_state ="covendor" // SPRITES
	icon_deny = "covendor-deny"
	products = list(
	/obj/item/weapon/reagent_containers/food/snacks/covenant/colo = 20,
	/obj/item/weapon/reagent_containers/food/snacks/covenant/colo/stew = 15,
	/obj/item/weapon/reagent_containers/food/snacks/covenant/irukanbar = 25
	)

/obj/machinery/vending/armory/covenant/jiralhanae/food
	name = "Covenant - Jiralhanae Food Vendor"
	desc = "A vendor for Jiralhanae oriented food."
	icon_state ="covendor" // SPRITES
	icon_deny = "covendor-deny"
	products = list(
	/obj/item/weapon/reagent_containers/food/snacks/covenant/thornbeast = 20,
	/obj/item/weapon/reagent_containers/food/snacks/covenant/thornbeast/thorn = 15,
	/obj/item/weapon/reagent_containers/food/snacks/covenant/irukanbar = 25
	)

/obj/machinery/vending/armory/covenant/kigyar/food
	name = "Covenant - Kig-Yar Food Vendor"
	desc = "A vendor for Kig-Yar oriented food."
	icon_state ="covendor" // SPRITES
	icon_deny = "covendor-deny"
	products = list(
	/obj/item/weapon/reagent_containers/food/snacks/covenant/uoi = 20,
	/obj/item/weapon/reagent_containers/food/snacks/covenant/uoi/stew = 15,
	/obj/item/weapon/reagent_containers/food/snacks/covenant/irukanbar = 30
	)

/obj/machinery/vending/armory/covenant/yanmee/equipment
	name = "Covenant - Yanmee Equipment Vendor"
	desc = "Storage for Covenant Yanmee equipment"
	icon_state ="covendor" // SPRITES
	icon_deny = "covendor-deny"
	products = list(
	"Storage" = -1,
	/obj/item/clothing/accessory/storage/bandolier/covenant = 10,
	/obj/item/weapon/storage/belt/covenant_medic = 4,
	/obj/item/weapon/storage/belt/covenant_ammo = 4,
	/obj/item/weapon/storage/belt/utility/full = 4,
	/obj/item/clothing/accessory/storage/bandolier/covenant = 4,
	"Equipment" = -1,
	/obj/item/weapon/plastique/covenant = 4,
	/obj/item/weapon/armor_patch/cov = 16,
	/obj/item/weapon/armor_patch/mini/cov = 20,
	/obj/item/weapon/pinpointer/artifact = 1
	)

/obj/machinery/vending/armory/covenant/yanmee/weapon
	name = "Covenant - Yanmee Weapon Vendor"
	desc = "Storage for Covenant Yanmee weapons and ammo"
	icon_state ="covendor" // SPRITES
	icon_deny = "covendor-deny"
	products = list(
	/obj/item/weapon/melee/energy/elite_sword/dagger = 12,
	/obj/item/weapon/grenade/smokebomb/covenant = 12
	)

/obj/machinery/vending/armory/covenant/general/food
	name = "Covenant - Lesser Food Vendor"
	desc = "A food vendor for the lesser species."
	icon_state ="covendor" // SPRITES
	icon_deny = "covendor-deny"
	products = list(
	/obj/item/weapon/reagent_containers/food/snacks/covenant/irukanbar = 35
	)

/obj/machinery/vending/armory/covenant/general/medical
	name = "Covenant - Medical Vendor"
	desc = "A vendor that supplies medical equipment"
	icon_state ="covendor" // SPRITES
	icon_deny = "covendor-deny"
	products = list(
	/obj/item/bodybag/cryobag/covenant = 3,
	"Medkits" = -1,
	/obj/item/weapon/storage/firstaid/unsc/cov = 10,
	/obj/item/weapon/storage/firstaid/fire/covenant = 2,
	/obj/item/weapon/storage/firstaid/o2/covenant = 4,
	/obj/item/weapon/storage/firstaid/toxin/covenant = 4,
	/obj/item/weapon/storage/firstaid/erk/cov = 4,
	/obj/item/weapon/storage/firstaid/combat/unsc/cov = 7,
	/obj/item/weapon/storage/firstaid/adv = 7,
	"Pill Bottles" = -1,
	/obj/item/weapon/storage/pill_bottle/bicaridine = 6,
	/obj/item/weapon/storage/pill_bottle/dermaline = 6,
	/obj/item/weapon/storage/pill_bottle/tramadol = 6,
	/obj/item/weapon/storage/pill_bottle/hyronalin = 6,
	/obj/item/weapon/storage/pill_bottle/iron = 6,
	/obj/item/weapon/storage/pill_bottle/dexalin_plus = 6,
	/obj/item/weapon/storage/pill_bottle/inaprovaline = 6,
	"Injectors" = -1,
	/obj/item/weapon/reagent_containers/hypospray = 3,
	/obj/item/weapon/reagent_containers/syringe/ld50_syringe/triadrenaline = 10,
	/obj/item/weapon/storage/box/syringes = 2,
		)

/obj/machinery/vending/armory/covenant/general/medical/surgery
	name = "Covenant - Surgery Vendor"
	desc = "A vendor that supplies surgery equipment."
	icon_state ="covendor" // SPRITES
	icon_deny = "covendor-deny"
	products = list(
	/obj/item/weapon/hemostat/covenant = 3,
	/obj/item/weapon/scalpel/covenant = 3,
	/obj/item/weapon/retractor/covenant = 3,
	/obj/item/weapon/cautery/covenant = 3,
	/obj/item/weapon/circular_saw/covenant = 3,
	/obj/item/weapon/surgicaldrill/covenant = 3,
	/obj/item/weapon/bonesetter/covenant = 3,
	/obj/item/weapon/FixOVein = 3,
	/obj/item/stack/nanopaste = 3,
	/obj/item/weapon/bonegel = 3,
	/obj/item/stack/medical/advanced/bruise_pack = 3,
	/obj/item/weapon/storage/box/gloves = 3,
	/obj/item/weapon/tank/anesthetic = 3,
	/obj/item/weapon/reagent_containers/blood/OMinus = 6,
	/obj/item/weapon/reagent_containers/blood/empty = 12,
	/obj/item/weapon/reagent_containers/spray/cleaner = 2
	)
