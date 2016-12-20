
/datum/job/UNSC_ship/marine_co
	title = "Marine Commanding Officer"
	min_rank = RANK_CAPT
	default_rank = RANK_COL
	max_rank = MARINE_CO_MAX
	total_positions = 1
	spawn_positions = 1
	selection_color = "#667700"
	req_admin_notify = 1

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset(H), slot_l_ear)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/unsc/marine_fatigues(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(H), slot_l_hand)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/marine(H), slot_wear_suit)
		return 1

/datum/job/UNSC_ship/marine_xo
	title = "Marine Executive Officer"
	min_rank = MARINE_CO_MIN
	default_rank = RANK_1LT
	max_rank = RANK_CAPT
	total_positions = 1
	spawn_positions = 1
	selection_color = "#667700"
	req_admin_notify = 1

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset(H), slot_l_ear)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/unsc/marine_fatigues(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(H), slot_l_hand)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/marine(H), slot_wear_suit)
		return 1

/datum/job/UNSC_ship/marine_sl
	title = "Marine Squad Leader"
	min_rank = MARINE_SL_MIN
	default_rank = RANK_SGT
	max_rank = MARINE_SL_MAX
	total_positions = 2
	spawn_positions = 6
	selection_color = "#667700"

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset(H), slot_l_ear)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/unsc/marine_fatigues(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(H), slot_head)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/marine(H), slot_wear_suit)
		return 1

/datum/job/UNSC_ship/marine_sl/weapons
	title = "Infantry Weapons Officer"
	total_positions = 1
	spawn_positions = 4
	min_rank = RANK_GYSGT
	default_rank = RANK_GYSGT
	max_rank = RANK_MGYSGT

/datum/job/UNSC_ship/marine
	title = "Marine"
	min_rank = MARINE_MIN
	default_rank = RANK_PVT
	max_rank = MARINE_MAX
	total_positions = -1
	spawn_positions = 12
	selection_color = "#667700"
	alt_titles = list("Machine Gunner Marine","Marine Combat Medic","Assault Recon Marine",\
	"Designated Marksman Marine","Scout Sniper Marine","Anti-Tank Missile Gunner Marine",\
	"EVA Combat Marine")

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset(H), slot_l_ear)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/unsc/marine_fatigues(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(H), slot_head)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/marine(H), slot_wear_suit)
		return 1

/datum/job/UNSC_ship/marine/driver
	title = "Ground Vehicle Operator"
	total_positions = 3
	spawn_positions = 5
	alt_titles = list("Light Armored Vehicle Operator","Heavy Armored Vehicle Operator","Support Vehicle Operator","Tilt-rotor/VTOL Operator")

/datum/job/UNSC_ship/marine/specialist
	title = "Combat Engineer"
	total_positions = 3
	spawn_positions = 8
	alt_titles = list("Field Radio Operator","Explosive Ordnance Disposal Marine","Hazardous Materials Marine")

/obj/structure/closet/unsc_wardrobe/marine
	name = "marine fatigues closet"
	desc = "It's a storage unit for marine fatigues."
	icon_state = "green"
	icon_closed = "green"

/obj/structure/closet/unsc_wardrobe/marine/New()
	..()
	new /obj/item/clothing/under/unsc/marine_fatigues(src)
	new /obj/item/clothing/shoes/marine(src)
	new /obj/item/device/radio/headset(src)
	new /obj/item/clothing/under/unsc/marine_fatigues(src)
	new /obj/item/clothing/shoes/marine(src)
	new /obj/item/device/radio/headset(src)
	new /obj/item/clothing/head/helmet/marine(src)
	new /obj/item/clothing/suit/armor/marine(src)
