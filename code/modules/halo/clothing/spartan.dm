
/obj/item/clothing/head/helmet/spartan
	name = "MJOLNIR Powered Assault Armor Helmet"
	desc = "Ave, Imperator, morituri te salutant."
	icon = 'spartan.dmi'
	icon_state = "helmet"
	icon_override = 'mob_spartanhelm.dmi'
	item_state_slots = list(
		slot_l_hand_str = "spartan5",
		slot_r_hand_str = "spartan5",
		)
	item_flags = STOPPRESSUREDAMAGE | THICKMATERIAL | AIRTIGHT
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|BLOCKHAIR
	body_parts_covered = HEAD|FACE
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELMET_MIN_COLD_PROTECTION_TEMPERATURE
	siemens_coefficient = 1
	armor = list(melee = 50,bullet = 15,laser = 50,energy = 10,bomb = 25,bio = 0,rad = 0)

	action_button_name = "Toggle Helmet Light"
	light_overlay = "helmet_light"
	brightness_on = 4
	on = 0

/obj/item/clothing/head/helmet/spartan/blue
	icon_state = "helmet_blue"

/obj/item/clothing/head/helmet/spartan/red
	icon_state = "helmet_red"

/obj/item/clothing/suit/armor/special/spartan
	name = "MJOLNIR Powered Assault Armor Mark V"
	desc = "a technologically-advanced combat exoskeleton system designed to vastly improve the strength, speed, agility, reflexes and durability of a SPARTAN-II, supersoldier in the field of combat."
	icon = 'spartan.dmi'
	icon_state = "suit"
	icon_override = 'mob_spartansuit.dmi'
	item_state_slots = list(
		slot_l_hand_str = "spartan5_l",
		slot_r_hand_str = "spartan5_r",
		)
	blood_overlay_type = "armor"
	armor = list(melee = 80, bullet = 95, laser = 50, energy = 50, bomb = 60, bio = 25, rad = 25)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	item_flags = STOPPRESSUREDAMAGE | THICKMATERIAL
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETAIL
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE

/obj/item/clothing/suit/armor/special/spartan/ui_action_click()
	for(var/datum/armourspecials/special in specials)
		special.try_item_action()

/obj/item/clothing/suit/armor/special/spartan/red
	icon_state = "suit_red"
	armor = list(melee = 60, bullet = 75, laser = 40, energy = 40, bomb = 60, bio = 25, rad = 25) //lowered armour values for slayer.
	specials = list(/datum/armourspecials/shields/spartan,/datum/armourspecials/dispenseitems/spartanmeds,/datum/armourspecials/shieldmonitor)
	totalshields = 150
	canremove = 0 //To disallow stripping of armour for impersonation in slayer.
	action_button_name = "Dispense Medicine"

/obj/item/clothing/suit/armor/special/spartan/blue
	icon_state = "suit_blue"
	armor = list(melee = 60, bullet = 75, laser = 40, energy = 40, bomb = 60, bio = 25, rad = 25) //lowered armour values for slayer.
	specials = list(/datum/armourspecials/shields/spartan,/datum/armourspecials/dispenseitems/spartanmeds,/datum/armourspecials/shieldmonitor)
	totalshields = 150
	canremove = 0
	action_button_name = "Dispense Medicine"
