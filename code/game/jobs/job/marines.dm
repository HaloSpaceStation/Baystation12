
/datum/job/marine
	title = "Marine"
	flag = MARINE
	department = "Security"
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 8
	spawn_positions = 8
	supervisors = "marine sergeants and the captain"
	selection_color = "#ffeeee"
	//alt_titles = list("Junior Officer")
	economic_modifier = 2
	access = list(access_security, access_eva, access_sec_doors, access_brig, access_maint_tunnels, access_morgue, access_external_airlocks)
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_maint_tunnels, access_external_airlocks)
	minimal_player_age = 5
	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/headset_sec(H), slot_l_ear)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/unsc/marine_fatigues(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/device/pda/security(H), slot_belt)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(H), slot_head)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/marine(H), slot_wear_suit)
		return 1

/datum/job/marine_sgt
	title = "Marine Sergeant"
	flag = MARINE_SGT
	department = "Security"
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the captain"
	selection_color = "#ffeeee"
	//alt_titles = list("Junior Officer")
	economic_modifier = 4
	access = list(access_security, access_eva, access_sec_doors, access_brig, access_maint_tunnels, access_morgue, access_external_airlocks)
	minimal_access = list(access_security, access_eva, access_sec_doors, access_brig, access_maint_tunnels, access_external_airlocks)
	minimal_player_age = 5
	equip(var/mob/living/carbon/human/H)
		if(!H)	return 0
		H.equip_to_slot_or_del(new /obj/item/device/radio/headset/headset_sec(H), slot_l_ear)
		H.equip_to_slot_or_del(new /obj/item/clothing/under/unsc/marine_fatigues(H), slot_w_uniform)
		H.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine(H), slot_shoes)
		H.equip_to_slot_or_del(new /obj/item/device/pda/security(H), slot_belt)
		H.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine(H), slot_head)
		H.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/marine(H), slot_wear_suit)
		return 1
