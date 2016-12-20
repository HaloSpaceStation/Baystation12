
//ship commanding officer
/datum/job/UNSC_ship/commander
	title = "Commanding Officer"
	min_rank = RANK_LCDR
	default_rank = RANK_CPT
	max_rank = RANK_CPT
	total_positions = 1
	spawn_positions = 1
	selection_color = "#777777"
	idtype = /obj/item/weapon/card/id/gold
	req_admin_notify = 1

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/heads/captain(H), slot_l_ear)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/unsc/command(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/device/pda/captain(H), slot_belt)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/brown(H), slot_shoes)

//ship 2ic officer
/datum/job/UNSC_ship/exo
	title = "Executive Officer"
	min_rank = RANK_LT
	default_rank = RANK_CDR
	max_rank = RANK_CDR
	total_positions = 1
	spawn_positions = 1
	selection_color = "#777777"
	idtype = /obj/item/weapon/card/id/gold
	req_admin_notify = 1

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/heads/captain(H), slot_l_ear)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/unsc/command(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/device/pda/captain(H), slot_belt)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/brown(H), slot_shoes)

//overall commander of strike craft
/datum/job/UNSC_ship/cag
	title = "Commander Air Group"
	min_rank = RANK_LT
	default_rank = RANK_CDR
	max_rank = RANK_CDR
	total_positions = 1
	spawn_positions = 1
	selection_color = "#777777"
	idtype = /obj/item/weapon/card/id/silver

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset(H), slot_l_ear)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/unsc/command(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/device/pda(H), slot_l_store)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/brown(H), slot_shoes)
		return 1

//misc officers
/datum/job/UNSC_ship/bridge
	title = "Bridge Officer"
	min_rank = RANK_ENSIGN
	default_rank = RANK_LT
	max_rank = RANK_CDR
	total_positions = -1
	spawn_positions = 2
	selection_color = "#777777"
	idtype = /obj/item/weapon/card/id/silver

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset(H), slot_l_ear)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/unsc/command(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/device/pda(H), slot_l_store)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/brown(H), slot_shoes)
		return 1

/obj/structure/closet/unsc_wardrobe/command
	name = "command crew closet"
	desc = "It's a storage unit for command uniforms."
	icon_state = "grey"
	icon_closed = "grey"

/obj/structure/closet/unsc_wardrobe/command/New()
	..()
	new /obj/item/clothing/under/unsc/command(src)
	new /obj/item/clothing/shoes/brown(src)
	new /obj/item/device/radio/headset/heads/captain(src)
	new /obj/item/clothing/under/unsc/command(src)
	new /obj/item/clothing/shoes/brown(src)
	new /obj/item/device/radio/headset/heads/captain(src)
