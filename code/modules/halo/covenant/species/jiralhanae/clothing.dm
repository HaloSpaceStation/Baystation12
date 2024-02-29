#define JIRALHANAE_ICON_PATH_MOB 'code/modules/halo/covenant/species/jiralhanae/jiralhanae_gear.dmi'
#define JIRALHANAE_ICON_PATH_OBJ 'code/modules/halo/covenant/species/jiralhanae/jiralhanae_obj.dmi'






/* BODYSUIT */




/obj/item/clothing/under/covenant/jiralhanae
	name = "Jiralhanae Bodysuit"
	desc = "A Jiralhanae body suit. Looks itchy and covered in hair."
	icon = JIRALHANAE_ICON_PATH_OBJ
	icon_state = "bodysuit"
	sprite_sheets = list("Jiralhanae" = JIRALHANAE_ICON_PATH_MOB)
	species_restricted = list("Jiralhanae")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	armor = list(melee = 3, bullet = 3, laser = 3, energy = 3, bomb = 3, bio = 0, rad = 0)
	matter = list("cloth" = 1)
	rolled_sleeves = 0

/obj/item/clothing/under/covenant/jiralhanae/rolled
	name = "Jiralhanae short Bodysuit"
	desc = "A Jiralhanae short body suit. Looks itchy and covered in hair."
	worn_state = "bodysuit_r"
	rolled_sleeves = -1

/obj/item/clothing/under/covenant/jiralhanae/straps
	name = "Jiralhanae straps"
	desc = "Some straps specifically made of Jiralhanae bodies. Looks itchy and covered in hair."
	icon = JIRALHANAE_ICON_PATH_OBJ
	icon_state = "straps"
	sprite_sheets = list("Jiralhanae" = JIRALHANAE_ICON_PATH_MOB)
	species_restricted = list("Jiralhanae")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)
	matter = list("cloth" = 1)

/obj/item/clothing/under/covenant/jiralhanae/red/
	name = "Jiralhanae Red Bodysuit"
	desc = "A Jiralhanae body suit. Looks itchy and covered in hair."
	icon_state = "bodysuit_red"
	armor = list(melee = 3, bullet = 3, laser = 3, energy = 3, bomb = 3, bio = 0, rad = 0)

obj/item/clothing/under/covenant/jiralhanae/red/rolled
	worn_state = "bodysuit_red_r"
	rolled_sleeves = -1

/obj/item/clothing/under/covenant/jiralhanae/blue
	name = "Jiralhanae Blue Bodysuit"
	desc = "A Jiralhanae body suit. Looks itchy and covered in hair."
	icon_state = "bodysuit_blue"
	armor = list(melee = 3, bullet = 3, laser = 3, energy = 3, bomb = 3, bio = 0, rad = 0)

obj/item/clothing/under/covenant/jiralhanae/blue/rolled
	worn_state = "bodysuit_blue_r"
	rolled_sleeves = 1



/* HELMET */



/obj/item/clothing/head/helmet/jiralhanae
	name = "Jiralhanae Helm"
	desc = "A crude metal cap made of a heavy, alien alloy."
	icon = JIRALHANAE_ICON_PATH_OBJ
	icon_state = "helm_minor"
	sprite_sheets = list("Jiralhanae" = JIRALHANAE_ICON_PATH_MOB)
	armor = list(melee = 30, bullet = 20, laser = 10,energy = 10, bomb = 10, bio = 0, rad = 0)
	species_restricted = list("Jiralhanae")
	matter = list("nanolaminate" = 1)

/obj/item/clothing/head/helmet/jiralhanae/major
	name = "Jiralhanae Major Helm"
	icon_state = "helm_major"
	armor = list(melee = 35, bullet = 25, laser = 10,energy = 10, bomb = 10, bio = 0, rad = 0)

/obj/item/clothing/head/helmet/jiralhanae/captain
	name = "Jiralhanae Captain Helm"
	icon_state = "helm_captain"
	armor = list(melee = 40, bullet = 30, laser = 10,energy = 10, bomb = 10, bio = 0, rad = 0)

/obj/item/clothing/head/helmet/jiralhanae/chieftain_boulder
	name = "Boulder Chieftain Helm"
	icon_state = "helm_chieftain_red"
	armor = list(melee = 40, bullet = 30, laser = 10,energy = 10, bomb = 10, bio = 0, rad = 0)
	armor_thickness = 25
	armor_thickness_max = 25

/obj/item/clothing/head/helmet/jiralhanae/chieftain_ram
	name = "Ram Chieftain Helm"
	icon_state = "helm_chieftain_blue"
	armor = list(melee = 40, bullet = 30, laser = 10,energy = 10, bomb = 10, bio = 0, rad = 0)
	armor_thickness = 25
	armor_thickness_max = 25

/obj/item/clothing/head/helmet/jiralhanae/covenant
	icon_state = "helm_covenant"
	desc = "The standard issue helmets of Jiralhanae soldiers within the covenant."
	armor = list(melee = 55, bullet = 35, laser = 25,energy = 25, bomb = 20, bio = 25, rad = 25)
	integrated_hud = /obj/item/clothing/glasses/hud/tactical/covenant
	armor_thickness = 22
	armor_thickness_max = 22

/obj/item/clothing/head/helmet/jiralhanae/covenant/minor
	name = "Jiralhanae Helm (Minor)"
	icon = JIRALHANAE_ICON_PATH_OBJ
	icon_state = "minorhelm"

/obj/item/clothing/head/helmet/jiralhanae/covenant/major
	name = "Jiralhanae Helm (Major)"
	icon = JIRALHANAE_ICON_PATH_OBJ
	icon_state = "majorhelm"
	armor_thickness = 24
	armor_thickness_max = 24

/obj/item/clothing/head/helmet/jiralhanae/covenant/captain
	name = "Jiralhanae Helm (Captain)"
	desc = "This modified helmet is of some significance to Jiralhanae clans. It is a mark of importance, however now diminished by the covenant hierarchy."
	icon = JIRALHANAE_ICON_PATH_OBJ
	icon_state = "captainhelm"
	armor_thickness = 26
	armor_thickness_max = 26
	integrated_hud = /obj/item/clothing/glasses/hud/tactical/covenant/medic

/obj/item/clothing/head/helmet/jiralhanae/covenant/chieftain
	name = "Jiralhanae Helm (Chieftain)"
	desc = "This modified helmet is signficant to Jiralhanae clans. It is a mark of importance and leadership, however now somewhat diminished by the covenant hierarchy."
	icon_state = "helm_chieftain"
	armor_thickness = 28
	armor_thickness_max = 28
	integrated_hud = /obj/item/clothing/glasses/hud/tactical/covenant/medic

/* ARMOUR */



/obj/item/clothing/suit/armor/jiralhanae
	name = "Jiralhanae Chest Armour"
	desc = "A mysterious alien alloy fashioned into crude metal plating for protection of vital areas."
	species_restricted = list("Jiralhanae")
	icon = JIRALHANAE_ICON_PATH_OBJ
	icon_state = "armour_minor"
	sprite_sheets = list("Jiralhanae" = JIRALHANAE_ICON_PATH_MOB)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	armor = list(melee = 30, bullet = 20, laser = 10, energy = 10, bomb = 10, bio = 0, rad = 0)
	armor_thickness = 20
	matter = list("nanolaminate" = 2)
	allowed = list(\
		/obj/item/weapon/grenade/plasma,/obj/item/weapon/grenade/frag/spike,/obj/item/weapon/grenade/brute_shot,/obj/item/weapon/grenade/toxic_gas,\
		/obj/item/weapon/gun/projectile/spiker,/obj/item/weapon/gun/projectile/mauler,\
		/obj/item/weapon/gun/energy/plasmapistol, /obj/item/weapon/gun/energy/plasmarifle, /obj/item/weapon/gun/energy/plasmarifle/brute)

/obj/item/clothing/suit/armor/jiralhanae/New()
	..()
	pocket_curr = new/obj/item/weapon/storage/internal/pockets(src,2,ITEM_SIZE_SMALL,null,ARMOUR_POCKET_CANHOLD)

/obj/item/clothing/suit/armor/jiralhanae/major
	name = "Jiralhanae Major Chest Armour"
	icon_state = "armour_major"
	armor = list(melee = 35, bullet = 25, laser = 10, energy = 10, bomb = 10, bio = 0, rad = 0)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/suit/armor/jiralhanae/captain
	name = "Jiralhanae Captain Chest Armour"
	icon_state = "armour_captain"
	armor = list(melee = 40, bullet = 30, laser = 10, energy = 10, bomb = 10, bio = 0, rad = 0)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|HANDS


/obj/item/clothing/suit/armor/jiralhanae/red
	icon_state = "armour_minor_red"

/obj/item/clothing/suit/armor/jiralhanae/major/red
	icon_state = "armour_major_red"

/obj/item/clothing/suit/armor/jiralhanae/captain/red
	icon_state = "armour_captain_red"

/obj/item/clothing/suit/armor/jiralhanae/chieftain_boulder
	name = "Boulder Chieftain Armour"
	icon_state = "armour_chieftain_red"
	armor = list(melee = 40, bullet = 30, laser = 10, energy = 10, bomb = 10, bio = 0, rad = 0)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|HANDS
	armor_thickness = 25
	armor_thickness_max = 25

/obj/item/clothing/suit/armor/jiralhanae/blue
	name = "Jiralhanae Ram Chest Armour"
	icon_state = "armour_minor_blue"

/obj/item/clothing/suit/armor/jiralhanae/major/blue
	name = "Jiralhanae Ram Chest Armour"
	icon_state = "armour_major_blue"

/obj/item/clothing/suit/armor/jiralhanae/captain/blue
	name = "Jiralhanae Ram Chest Armour"
	icon_state = "armour_captain_blue"

/obj/item/clothing/suit/armor/jiralhanae/chieftain_ram
	name = "Ram Chieftain Armour"
	icon_state = "armour_chieftain_blue"
	armor = list(melee = 40, bullet = 30, laser = 10, energy = 10, bomb = 10, bio = 0, rad = 0)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|HANDS
	armor_thickness = 25
	armor_thickness_max = 25

/obj/item/clothing/suit/armor/jiralhanae/covenant
	icon_state = "armour_covenant"
	desc = "The armour of Jiralhanae soldiers within the covenant."
	armor = list(melee = 50, bullet = 45, laser = 50, energy = 40, bomb = 35, bio = 20, rad = 20)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|HANDS
	armor_thickness = 24
	armor_thickness_max = 24

/obj/item/clothing/suit/armor/jiralhanae/covenant/minor
	name = "Jiralhanae Armor (Minor)"
	icon = JIRALHANAE_ICON_PATH_OBJ
	icon_state = "minorchest"

/obj/item/clothing/suit/armor/jiralhanae/covenant/major
	name = "Jiralhanae Armor (Major)"
	icon = JIRALHANAE_ICON_PATH_OBJ
	icon_state = "majorchest"
	armor_thickness = 27
	armor_thickness_max = 27

/obj/item/clothing/suit/armor/jiralhanae/covenant/captain
	name = "Jiralhanae Armor (Captain)"
	desc = "This modified armor used to be a mark of importance to a Jiralhanae clan. The Covenant hierarchy has diminished it's power."
	icon = JIRALHANAE_ICON_PATH_OBJ
	icon_state = "captainchest"
	armor_thickness = 30
	armor_thickness_max = 30

/obj/item/clothing/suit/armor/special/chieftain
	name = "Jiralhanae Armour (Chieftain)"
	desc = "This modified armor used to be a mark of importance to Jiralhanae clans. The Covenant hierarchy has diminished it's power."
	species_restricted = list("Jiralhanae")
	icon = JIRALHANAE_ICON_PATH_OBJ
	icon_state = "armour_chieftain"
	sprite_sheets = list("Jiralhanae" = JIRALHANAE_ICON_PATH_MOB)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	armor = list(melee = 50, bullet = 45, laser = 50, energy = 40, bomb = 35, bio = 20, rad = 20)
	specials = list(/datum/armourspecials/shields/elite,/datum/armourspecials/shieldmonitor/jiralhanae)
	totalshields = 210
	armor_thickness = 30
	armor_thickness_max = 30
	matter = list("nanolaminate" = 2)
	allowed = list(\
		/obj/item/weapon/grenade/plasma,/obj/item/weapon/grenade/frag/spike,/obj/item/weapon/grenade/brute_shot,/obj/item/weapon/grenade/toxic_gas,\
		/obj/item/weapon/gun/projectile/spiker,/obj/item/weapon/gun/projectile/mauler,\
		/obj/item/weapon/gun/energy/plasmapistol, /obj/item/weapon/gun/energy/plasmarifle, /obj/item/weapon/gun/energy/plasmarifle/brute)

/obj/item/clothing/suit/armor/special/chieftain/New()
	..()
	pocket_curr = new/obj/item/weapon/storage/internal/pockets(src,2,ITEM_SIZE_SMALL,null,ARMOUR_POCKET_CANHOLD)

/* SHOES */



/obj/item/clothing/shoes/jiralhanae
	name = "Jiralhanae greaves"
	desc = "Crude metal plates made of a mysterious alien alloy for fastening to the legs."
	species_restricted = list("Jiralhanae")
	icon = JIRALHANAE_ICON_PATH_OBJ
	icon_state = "greaves"
	sprite_sheets = list("Jiralhanae" = JIRALHANAE_ICON_PATH_MOB)
	armor = list(melee = 30, bullet = 20, laser = 10, energy = 10, bomb = 10, bio = 0, rad = 0)
	body_parts_covered = LEGS|FEET
	stepsound = 'code/modules/halo/sounds/walk_sounds/brute_boots.ogg'
	matter = list("nanolaminate" = 1)

/obj/item/clothing/shoes/jiralhanae/covenant
	name = "Jiralhanae Greaves"
	desc = "The footwear of Jiralhanae soldiers within the covenant."
	icon_state = "greaves"
	armor = list(melee = 50, bullet = 40, laser = 5, energy = 5, bomb = 40, bio = 0, rad = 0)

/obj/item/clothing/shoes/jiralhanae/covenant/minor
	name = "Jiralhanae Greaves (Minor)"
	icon = JIRALHANAE_ICON_PATH_OBJ
	icon_state = "minorfeet"

/obj/item/clothing/shoes/jiralhanae/covenant/major
	name = "Jiralhanae Greaves (Major)"
	icon = JIRALHANAE_ICON_PATH_OBJ
	icon_state = "majorfeet"

/obj/item/clothing/shoes/jiralhanae/covenant/captain
	name = "Jiralhanae Greaves (Captain)"
	icon = JIRALHANAE_ICON_PATH_OBJ
	icon_state = "captainfeet"

/obj/item/clothing/shoes/jiralhanae/covenant/captain/chieftain
	name = "Jiralhanae Greaves (Chieftain)"//We have no Chieftain sprites for these, but a rename still works.
	icon = JIRALHANAE_ICON_PATH_OBJ
	icon_state = "chieftainfeet"

/obj/item/clothing/shoes/magboots/jiralhanaeEVA
	name = "Jiralhanae Maggreaves"
	desc = "Magboots fitted to Jiralhanae size."
	species_restricted = list("Jiralhanae")
	icon = JIRALHANAE_ICON_PATH_OBJ
	sprite_sheets = list("Jiralhanae" = JIRALHANAE_ICON_PATH_MOB)
	icon_state = "maggreaves"
	item_state = "maggreaves"
	icon_base = null
	cold_protection = LEGS|FEET
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	sprite_sheets = list("Jiralhanae" = JIRALHANAE_ICON_PATH_MOB)
	armor = list(melee = 45, bullet = 35, laser = 0, energy = 0, bomb = 35, bio = 0, rad = 0)
	body_parts_covered = LEGS|FEET
	matter = list("nanolaminate" = 1)

/* FLAGS */

/obj/item/clothing/jiralhanae_flag_boulder
	name = "Boulder Clan Flag"
	desc = "A flag of honour from a Jiralhanae clan."
	icon_state = "flag_red"
	item_state = "flag_back_red"
	slot_flags = SLOT_BACK
	force = 15
	w_class = ITEM_SIZE_LARGE
	species_restricted = list("Jiralhanae")
	icon = JIRALHANAE_ICON_PATH_OBJ
	icon_override = JIRALHANAE_ICON_PATH_MOB
	item_state_slots = list(
		slot_l_hand_str = "flag_red_left",
		slot_r_hand_str = "flag_red_right" )
	matter = list("cloth" = 1, "wood" = 1)

/obj/item/clothing/jiralhanae_flag_ram
	name = "Ram Clan Flag"
	desc = "A flag of honour from a Jiralhanae clan."
	icon_state = "flag_blue"
	item_state = "flag_back_blue"
	slot_flags = SLOT_BACK
	force = 15
	w_class = ITEM_SIZE_LARGE
	species_restricted = list("Jiralhanae")
	icon = JIRALHANAE_ICON_PATH_OBJ
	icon_override = JIRALHANAE_ICON_PATH_MOB
	item_state_slots = list(
		slot_l_hand_str = "flag_blue_left",
		slot_r_hand_str = "flag_blue_right" )
	matter = list("cloth" = 1, "wood" = 1)

/obj/item/clothing/jiralhanae_flag_random
	name = "Jiralhanae Clan Flag"
	desc = "A flag belonging to a nearly forgotten clan."
	slot_flags = SLOT_BACK
	force = 30
	w_class = ITEM_SIZE_LARGE
	species_restricted = list("Jiralhanae")
	icon = JIRALHANAE_ICON_PATH_OBJ
	icon_override = JIRALHANAE_ICON_PATH_MOB
	matter = list("cloth" = 1, "wood" = 1)

/obj/item/clothing/jiralhanae_flag_random/Initialize()
	. = ..()
	if(prob(50))
		icon_state = "flag_blue"
		item_state = "flag_back_blue"
		item_state_slots = list(
		slot_l_hand_str = "flag_blue_left",
		slot_r_hand_str = "flag_blue_right" )
	else
		icon_state = "flag_red"
		item_state = "flag_back_red"
		item_state_slots = list(
		slot_l_hand_str = "flag_red_left",
		slot_r_hand_str = "flag_red_right" )

/// JIRALHANAE EVA EQUIPMENT ///

// HELMETS //

/obj/item/clothing/head/helmet/jiralhanae/covenant/EVA
	name = "\improper Jiralhanae Ranger Helmet (Minor)"
	desc = "A heavy Ranger helmet, designed for extended operations in EVA. Its airtight fittings provide the user with immunity to biological contaminants and resistance to radiological hazards."
	item_state = "helm_soft"
	icon_state = "helm_soft"
	armor = list(melee = 55, bullet = 35, laser = 25,energy = 25, bomb = 20, bio = 100, rad = 30)
	armor_thickness = 22
	armor_thickness_max = 22
	item_flags = STOPPRESSUREDAMAGE | THICKMATERIAL | AIRTIGHT
	body_parts_covered = HEAD|FACE
	cold_protection = HEAD|FACE
	min_cold_protection_temperature = SPACE_HELMET_MIN_COLD_PROTECTION_TEMPERATURE

/obj/item/clothing/head/helmet/jiralhanae/covenant/EVA/New()
	..()
	slowdown_per_slot[slot_head] += 0.01 // Movement speed malus due to the armor's weight.

/obj/item/clothing/head/helmet/jiralhanae/covenant/EVA/major
	name = "\improper Jiralhanae Ranger Helmet (Major)"
	item_state = "helm_soft_major"
	armor_thickness = 24
	armor_thickness_max = 24

/obj/item/clothing/head/helmet/jiralhanae/covenant/EVA/captain
	name = "\improper Jiralhanae Ranger Helmet (Captain)"
	item_state = "helm_soft_captain"
	armor_thickness = 26
	armor_thickness_max = 26
	integrated_hud = /obj/item/clothing/glasses/hud/tactical/covenant/medic

// ARMOR //

/obj/item/clothing/suit/armor/special/jiralhanae/EVA
	name = "\improper Jiralhanae Ranger Suit (Minor)"
	desc = "A heavy suit of reinforced spaceproof Ranger armor, designed for extended operations in EVA. Its airtight fittings provide the user with immunity to biological contaminants and resistance to radiological hazards. Features a built-in manouvering system for basic movement in zero-gravity, but lacks the stabilization technology of dedicated jetpacks."
	icon = JIRALHANAE_ICON_PATH_OBJ
	sprite_sheets = list("Jiralhanae" = JIRALHANAE_ICON_PATH_MOB)
	icon_state = "armour_soft"
	item_state = "armour_soft"
	armor = list(melee = 50, bullet = 45, laser = 50, energy = 40, bomb = 35, bio = 100, rad = 30)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|HANDS
	item_flags = STOPPRESSUREDAMAGE | THICKMATERIAL | AIRTIGHT
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	armor_thickness = 24
	armor_thickness_max = 24
	allowed = list(/obj/item/weapon/tank)

	specials = list(/datum/armourspecials/integrated_jetpack)

/obj/item/clothing/suit/armor/special/jiralhanae/EVA/New()
	..()
	slowdown_per_slot[slot_wear_suit] += 0.02 // Movement speed malus due to the armor's weight.
	pocket_curr = new/obj/item/weapon/storage/internal/pockets(src,2,ITEM_SIZE_SMALL,null,ARMOUR_POCKET_CANHOLD)

/obj/item/clothing/suit/armor/special/jiralhanae/EVA/major
	name = "\improper Jiralhanae Ranger Suit (Major)"
	item_state = "armour_soft_major"
	armor_thickness = 27
	armor_thickness_max = 27

/obj/item/clothing/suit/armor/special/jiralhanae/EVA/captain
	name = "\improper Jiralhanae Ranger Suit (Captain)"
	item_state = "armour_soft_captain"
	armor_thickness = 30
	armor_thickness_max = 30

// BOOTS //

/obj/item/clothing/shoes/magboots/jiralhanaeEVA
	name = "Jiralhanae Ranger Magboots"
	desc = "A heavy pair of Ranger magboots, designed for extended operations in EVA. Its airtight fittings provide the user with immunity to biological contaminants and resistance to radiological hazards."
	species_restricted = list("Jiralhanae")
	icon = JIRALHANAE_ICON_PATH_OBJ
	sprite_sheets = list("Jiralhanae" = JIRALHANAE_ICON_PATH_MOB)
	icon_state = "maggreaves"
	item_state = "maggreaves"
	icon_base = null
	cold_protection = LEGS|FEET
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	stepsound = 'code/modules/halo/sounds/walk_sounds/brute_boots.ogg'
	sprite_sheets = list("Jiralhanae" = JIRALHANAE_ICON_PATH_MOB)
	armor = list(melee = 50, bullet = 40, laser = 5, energy = 5, bomb = 40, bio = 100, rad = 30)
	armor_thickness = 20
	armor_thickness_max = 20
	body_parts_covered = LEGS|FEET
	matter = list("nanolaminate" = 1)

/obj/item/clothing/shoes/magboots/jiralhanaeEVA/New()
	..()
	slowdown_per_slot[slot_shoes] += 0.02 // Movement speed malus due to the armor's weight.

// FLAG //

/obj/item/clothing/accessory/jiralhanae_flag
	name = "Jiralhanae Clan Flag"
	desc =  "A flag denoting a Jiralhanae Clan, wear with pride."
	icon = JIRALHANAE_ICON_PATH_OBJ
	icon_state = "flag_red"
	item_state = "flag_red"
	sprite_sheets = list("Jiralhanae" = JIRALHANAE_ICON_PATH_MOB)

#undef JIRALHANAE_ICON_PATH_MOB
#undef JIRALHANAE_ICON_PATH_OBJ
