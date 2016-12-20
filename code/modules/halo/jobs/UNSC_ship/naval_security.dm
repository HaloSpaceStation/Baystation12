
/datum/job/UNSC_ship/security_chief
	title = "Master-At-Arms (naval security)"
	min_rank = RANK_CWO
	default_rank = RANK_CWO
	max_rank = RANK_CWO
	total_positions = 1
	spawn_positions = 1
	selection_color = "#990000"
	idtype = /obj/item/weapon/card/id/silver
	req_admin_notify = 1

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/heads/hos(H), slot_l_ear)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/unsc/tactical(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/device/pda/heads/hos(H), slot_belt)
		return 1

/datum/job/UNSC_ship/security
	title = "Naval Security"
	min_rank = RANK_RECRUIT
	default_rank = RANK_CREWMAN
	max_rank = RANK_PETTYM
	total_positions = -1
	spawn_positions = 3
	selection_color = "#990000"

	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/headset_sec(H), slot_l_ear)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/unsc/tactical(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/jackboots(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/device/pda/security(H), slot_belt)
		return 1

/obj/structure/closet/unsc_wardrobe/security
	name = "tactical crewman closet"
	desc = "It's a storage unit for tactical uniforms."
	icon_state = "red"
	icon_closed = "red"

/obj/structure/closet/unsc_wardrobe/security/New()
	..()
	new /obj/item/clothing/under/unsc/tactical(src)
	new /obj/item/clothing/shoes/jackboots(src)
	new /obj/item/device/radio/headset/headset_sec(src)
	new /obj/item/clothing/under/unsc/tactical(src)
	new /obj/item/clothing/shoes/jackboots(src)
	new /obj/item/device/radio/headset/headset_sec(src)
