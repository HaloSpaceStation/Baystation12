
/obj/item/clothing/head/helmet/SPIgen1
	name = "Semi-Powered Infiltration helmet"
	desc = "Advanced stealth capabilities and spaceworthiness with reduced protection. Fitted for human use."
	icon = 'code/modules/halo/clothing/spi_armour.dmi'
	icon_state = "spi_helm"
	item_state = "spi_helm"
	icon_override = 'code/modules/halo/clothing/spi_armour.dmi'
	item_state_slots = list(slot_l_hand_str = "syndicate-helm-black", slot_r_hand_str = "syndicate-helm-black")

	armor = list(melee = 50, bullet = 30, laser = 50,energy = 20, bomb = 25, bio = 0, rad = 0)
	armor_thickness = 15
	species_restricted = list("Human")
	item_flags = STOPPRESSUREDAMAGE | THICKMATERIAL | AIRTIGHT
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|BLOCKHAIR
	body_parts_covered = HEAD|FACE
	heat_protection = HEAD|FACE
	max_heat_protection_temperature = FIRE_HELMET_MAX_HEAT_PROTECTION_TEMPERATURE
	cold_protection = HEAD|FACE
	min_cold_protection_temperature = SPACE_HELMET_MIN_COLD_PROTECTION_TEMPERATURE
	siemens_coefficient = 1
	flash_protection = FLASH_PROTECTION_MODERATE

	action_button_name = "Toggle Helmet Light"
	light_overlay = "helmet_light_dual"
	brightness_on = 4
	on = 0

	integrated_hud = /obj/item/clothing/glasses/hud/tactical

/obj/item/clothing/suit/armor/special/SPIgen1
	name = "Semi-Powered Infiltration Armour Gen-1"
	desc = "Advanced stealth capabilities and spaceworthiness with reduced protection. Fitted for human use."
	icon = 'code/modules/halo/clothing/spi_armour.dmi'
	icon_state = "spi_suit"
	item_state = "spi_suit"
	icon_override = 'code/modules/halo/clothing/spi_armour.dmi'
	item_state_slots = list(slot_l_hand_str = "syndicate-black", slot_r_hand_str = "syndicate-black")

	blood_overlay_type = "armor"
	armor = list(melee = 55, bullet = 50, laser = 55, energy = 45, bomb = 40, bio = 25, rad = 25)
	armor_thickness = 15
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/gun,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/storage/fancy/cigarettes,/obj/item/weapon/flame/lighter)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	item_flags = STOPPRESSUREDAMAGE | THICKMATERIAL | AIRTIGHT
	flags_inv = HIDETAIL
	heat_protection = UPPER_TORSO | LOWER_TORSO | LEGS | FEET | ARMS | HANDS
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	species_restricted = list("Human")

	action_button_name = "Toggle Active Camouflage"

	specials = list(\
	/datum/armourspecials/cloaking/human_spi,\
	/datum/armourspecials/gear/spi_gloves,\
	/datum/armourspecials/gear/spi_boots,\
	)

/obj/item/clothing/suit/armor/special/SPIgen1/New()
	..()
	pocket_curr = new/obj/item/weapon/storage/internal/pockets(src,2,ITEM_SIZE_SMALL,null,ARMOUR_POCKET_CANHOLD)

/obj/item/clothing/shoes/magboots/SPIgen1
	name = "Semi-Powered Infiltration boots"
	desc = "Advanced stealth capabilities, spaceworthiness and mag-pulse traction with reduced protection. Fitted for human use."
	icon = 'code/modules/halo/clothing/spartan_gear.dmi'
	icon_override = 'code/modules/halo/clothing/spartan_gear.dmi'
	icon_state = "neuralboots_obj0"
	icon_base = "neuralboots_obj"
	item_state = "neuralboots"
	force = 5
	armor = list(melee = 40, bullet = 40, laser = 5, energy = 20, bomb = 50, bio = 0, rad = 0)
	armor_thickness = 15
	item_flags = STOPPRESSUREDAMAGE | THICKMATERIAL | AIRTIGHT
	siemens_coefficient = 0.6
	can_hold_knife = 1
	body_parts_covered = FEET
	cold_protection = FEET
	min_cold_protection_temperature = SHOE_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = FEET
	max_heat_protection_temperature = SHOE_MAX_HEAT_PROTECTION_TEMPERATURE
	species_restricted = list("Human")
	stepsound = 'code/modules/halo/sounds/walk_sounds/marine_boots.ogg'

/obj/item/clothing/gloves/SPIgen1
	name = "Semi-Powered Infiltration gloves"
	desc = "Advanced stealth capabilities and spaceworthiness with reduced protection. Fitted for human use."
	icon = 'code/modules/halo/clothing/spartan_gear.dmi'
	icon_override = 'code/modules/halo/clothing/spartan_gear.dmi'
	icon_state = "neuralgloves_obj"
	item_state = "neuralgloves"
	item_flags = STOPPRESSUREDAMAGE | THICKMATERIAL | AIRTIGHT
	armor = list(melee = 30, bullet = 40, laser = 10, energy = 25, bomb = 35, bio = 0, rad = 0)
	armor_thickness = 15
	siemens_coefficient = 0.05
	permeability_coefficient = 0.05
	body_parts_covered = HANDS
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_HEAT_PROTECTION_TEMPERATURE
	species_restricted = list("Human")


//Field Agent Gear
/obj/item/clothing/suit/armor/special/SPIgen1/field_agent
	desc = "Advanced stealth capabilities and spaceworthiness with reduced protection. Fitted for human use. Comes equipped with an electronic warfare device, mounted in an arm-compartment."
	specials = list(\
	/datum/armourspecials/cloaking/human_spi,\
	/datum/armourspecials/gear/spi_gloves/field_agent,\
	/datum/armourspecials/gear/spi_boots,\
	)

/obj/item/clothing/gloves/SPIgen1/field_agent //This has a door-spoofer inside; unlike the normal gloves.
	desc = "Advanced stealth capabilities and spaceworthiness with reduced protection. Fitted for human use. Contains an EWAR device for infiltration."

/obj/item/clothing/gloves/SPIgen1/field_agent/New()
	..()
	pocket_curr = new/obj/item/weapon/storage/internal/pockets(src,1,ITEM_SIZE_SMALL,null,list(/obj/item/device/ewar_spoofer))
	pocket_curr.name = "EWAR Storage"
	pocket_curr.handle_item_insertion(new /obj/item/device/ewar_spoofer/unsc(loc))

//Gen 2 Armour
/obj/item/clothing/head/helmet/SPIgen1/gen2
	armor_thickness = 20

/obj/item/clothing/suit/armor/special/SPIgen1/gen2
	armor_thickness = 20
	specials = list(\
	/datum/armourspecials/cloaking/cov_specops,\
	/datum/armourspecials/gear/spi_gloves/gen2,\
	/datum/armourspecials/gear/spi_boots/gen2,\
	)

/obj/item/clothing/suit/armor/special/SPIgen1/gen2/New()
	. = ..()
	slowdown_per_slot[slot_wear_suit] = -0.1

/obj/item/clothing/shoes/magboots/SPIgen1/gen2
	armor_thickness = 20

/obj/item/clothing/gloves/SPIgen1/gen2
	armor_thickness = 20