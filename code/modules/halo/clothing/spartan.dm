
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

	var/list/hud_elements[0]

	action_button_name = "Toggle Helmet Light"
	light_overlay = "helmet_light"
	brightness_on = 4
	on = 0

/obj/item/clothing/head/helmet/spartan/proc/check_shields_equipped(var/mob/living/carbon/human/L)
	var/obj/item/clothing/suit/armor/special/suit = L.wear_suit
	if(L.wear_suit && istype(L.wear_suit,/obj/item/clothing/suit/armor/special))
		var/datum/armourspecials/shields/shield_datum = get_shield_datum(L,suit)
		return shield_datum

/obj/item/clothing/head/helmet/spartan/proc/get_shield_datum(var/mob/living/L,var/obj/item/clothing/suit/armor/special/suit)
	var/s_d
	for(var/datum/armourspecials/I in suit.specials)
		if(istype(I,/datum/armourspecials/shields))
			s_d = I
			return s_d

/obj/item/clothing/head/helmet/spartan/proc/create_shieldbar(var/iconstate)
	var/obj/bar = new /obj/screen/shieldbar
	bar.icon_state = (iconstate ? iconstate : "shield_base")
	return bar


/obj/item/clothing/head/helmet/spartan/proc/initialise_shieldbar(var/datum/armourspecials/shields/shield_datum,var/mob/living/L)
	if(isnull(L.client)) return
	var/current = (shield_datum.shieldstrength / shield_datum.totalshields)*100
	var/bar
	var/client_screen = L.client.screen
	if(current <= 100)
		bar = create_shieldbar("shield_100")
	else if(current <= 50)
		bar = create_shieldbar("shield_50")
	else if(current <= 10)
		bar = create_shieldbar("shield_10")
	else if(current <= 5)
		bar = create_shieldbar("shield_5")
	else if(current == 1)
		bar = create_shieldbar("shield_1")
	client_screen += bar
	hud_elements += bar

/obj/item/clothing/head/helmet/spartan/equipped(var/mob/living/L) //Just a little testing to see if I can make a shield bar function.
	var/shield = check_shields_equipped(L)
	if(isnull(shield)) return
	initialise_shieldbar(shield,L)

	/*var/obj/screen/I = new
	hud_elements += I
	I.icon = 'code/modules/halo/clothing/spartanhud.dmi'
	I.icon_state = "shieldbar"
	I.screen_loc = "NORTH,CENTER-1"
	L.client.screen += I*/

/obj/item/clothing/head/helmet/spartan/dropped(var/mob/living/L)
	for(var/I in hud_elements)
		L.client.screen -= I
		qdel(I)
	hud_elements.Cut()

/obj/screen/shieldbar
	name = "Shield Bar"
	icon = 'code/modules/halo/clothing/spartanhud.dmi'
	icon_state = "shield_base"
	screen_loc = "NORTH,CENTER-1"

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
	specials = list(/datum/armourspecials/shields/spartan,/datum/armourspecials/dispenseitems/spartanmeds)
	totalshields = 150
	canremove = 0 //To disallow stripping of armour for impersonation in slayer.
	action_button_name = "Dispense Medicine"

/obj/item/clothing/suit/armor/special/spartan/blue
	icon_state = "suit_blue"
	armor = list(melee = 60, bullet = 75, laser = 40, energy = 40, bomb = 60, bio = 25, rad = 25) //lowered armour values for slayer.
	specials = list(/datum/armourspecials/shields/spartan,/datum/armourspecials/dispenseitems/spartanmeds)
	totalshields = 150
	canremove = 0
	action_button_name = "Dispense Medicine"
