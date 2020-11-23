
/decl/hierarchy/outfit/job/geminus_innie
	name = "Insurrectionist"

	head = /obj/item/clothing/head/helmet/innie/medium/brown
	glasses = /obj/item/clothing/glasses/hud/tactical
	mask = /obj/item/clothing/mask/balaclava/tactical
	suit = /obj/item/clothing/suit/storage/innie/medium/brown
	uniform = /obj/item/clothing/under/innie/jumpsuit
	shoes = /obj/item/clothing/shoes/innie_boots/medium/brown
	l_ear = /obj/item/device/radio/headset/insurrection
	gloves = /obj/item/clothing/gloves/x52/x52gloves
	pda_slot = null

	flags = 0

/decl/hierarchy/outfit/job/geminus_innie/equip_id(mob/living/carbon/human/H, rank, assignment)
	. = ..()

	var/obj/item/weapon/card/id/W = .
	if(W)
		W.rank = "Colonist"
		W.assignment = "Colonist"
		W.update_name()

/decl/hierarchy/outfit/job/geminus_innie_leader
	name = "Insurrectionist Captain"

	head = /obj/item/clothing/head/helmet/innie/heavy/vblue
	glasses =/obj/item/clothing/glasses/hud/tactical
	mask = /obj/item/clothing/mask/balaclava/tactical
	suit = /obj/item/clothing/suit/storage/innie/heavy/blue
	uniform = /obj/item/clothing/under/innie/jumpsuit
	shoes = /obj/item/clothing/shoes/innie_boots/medium/blue
	l_ear = /obj/item/device/radio/headset/insurrection
	gloves = /obj/item/clothing/gloves/x52/x52gloves
	pda_slot = null

	flags = 0

/decl/hierarchy/outfit/job/geminus_innie_leader/equip_id(mob/living/carbon/human/H, rank, assignment)
	. = ..()

	var/obj/item/weapon/card/id/W = .
	if(W)
		W.rank = "Colonist"
		W.assignment = "Colonist"
		W.update_name()

/decl/hierarchy/outfit/job/colonist/geminus_innie
	name = "Geminus Insurrectionist"
	l_ear = /obj/item/device/radio/headset/insurrection


/decl/hierarchy/outfit/job/colonist/geminus_innie_orion_defector
	name = "Insurrectionist Orion Defector"

	head = /obj/item/clothing/head/helmet/innie/urfdefector
	glasses = /obj/item/clothing/glasses/hud/tactical
	mask = /obj/item/clothing/mask/gas/soebalaclava
	suit = /obj/item/clothing/suit/storage/innie/urfdefector
	uniform = /obj/item/clothing/under/psysuit/theta
	shoes = /obj/item/clothing/shoes/marine/orion
	l_ear = /obj/item/device/radio/headset/insurrection
	gloves = /obj/item/clothing/gloves/marine/orion
	pda_slot = null

	flags = 0

/decl/hierarchy/outfit/job/colonist/geminus_innie_orion_defector/equip_id(mob/living/carbon/human/H, rank, assignment)
	. = ..()

	var/obj/item/weapon/card/id/W = .
	if(W)
		W.rank = "Colonist"
		W.assignment = "Colonist"
		W.update_name()

/decl/hierarchy/outfit/job/geminus_innie/ert
	name = "Insurrectionist ERT"

	head = /obj/item/clothing/head/helmet/innie/medium/brown
	l_hand = /obj/item/weapon/gun/projectile/ma3_ar
	r_hand = /obj/item/weapon/storage/box/ma3_m118
	glasses = /obj/item/clothing/glasses/hud/tactical
	mask = /obj/item/clothing/mask/balaclava/tactical
	suit = /obj/item/clothing/suit/storage/innie/medium/brown
	belt = /obj/item/weapon/storage/belt/marine_ammo
	uniform = /obj/item/clothing/under/innie/jumpsuit
	shoes = /obj/item/clothing/shoes/innie_boots/medium/brown
	l_ear = /obj/item/device/radio/headset/insurrection
	gloves = /obj/item/clothing/gloves/x52/x52gloves
	pda_slot = null

	flags = 0

/decl/hierarchy/outfit/job/geminus_innie/ert/equip_id(mob/living/carbon/human/H, rank, assignment)
	. = ..()

	var/obj/item/weapon/card/id/W = .
	if(W)
		W.rank = "Colonist"
		W.assignment = "Colonist"
		W.update_name()

/decl/hierarchy/outfit/job/geminus_innie/medic/ert
	name = "Insurrectionist Medic ERT"

	head = /obj/item/clothing/head/helmet/innie/medium/white
	l_hand = /obj/item/weapon/gun/projectile/ma37_ar
	r_hand = /obj/item/weapon/storage/box/ma37_m118
	glasses = /obj/item/clothing/glasses/hud/tactical
	mask = /obj/item/clothing/mask/balaclava/tactical
	suit = /obj/item/clothing/suit/storage/innie/medium/white
	belt = /obj/item/weapon/storage/belt/marine_ammo
	uniform = /obj/item/clothing/under/innie/jumpsuit
	shoes = /obj/item/clothing/shoes/innie_boots/medium/white
	l_ear = /obj/item/device/radio/headset/insurrection
	gloves = /obj/item/clothing/gloves/x52/x52gloves
	pda_slot = null
	l_pocket = /obj/item/weapon/storage/firstaid/unsc
	r_pocket = /obj/item/weapon/storage/firstaid/unsc


	flags = 0

/decl/hierarchy/outfit/job/geminus_innie/medic/ert/equip_id(mob/living/carbon/human/H, rank, assignment)
	. = ..()

	var/obj/item/weapon/card/id/W = .
	if(W)
		W.rank = "Colonist"
		W.assignment = "Colonist"
		W.update_name()

/decl/hierarchy/outfit/job/geminus_innie_leader/ert
	name = "Insurrectionist Captain ERT"

	head = /obj/item/clothing/head/helmet/innie/heavy/vblue
	l_hand = /obj/item/weapon/gun/projectile/br55
	r_hand = /obj/item/weapon/storage/box/br55_m634
	glasses =/obj/item/clothing/glasses/hud/tactical
	mask = /obj/item/clothing/mask/balaclava/tactical
	suit = /obj/item/clothing/suit/storage/innie/heavy/blue
	belt = /obj/item/weapon/storage/belt/marine_ammo
	uniform = /obj/item/clothing/under/innie/jumpsuit
	shoes = /obj/item/clothing/shoes/innie_boots/medium/blue
	l_ear = /obj/item/device/radio/headset/insurrection
	gloves = /obj/item/clothing/gloves/x52/x52gloves
	pda_slot = null
	l_pocket = /obj/item/weapon/storage/firstaid/unsc
	r_pocket = /obj/item/weapon/storage/firstaid/unsc


	flags = 0

/decl/hierarchy/outfit/job/geminus_innie_leader/ert(mob/living/carbon/human/H, rank, assignment)
	. = ..()

	var/obj/item/weapon/card/id/W = .
	if(W)
		W.rank = "Colonist"
		W.assignment = "Colonist"
		W.update_name()

/decl/hierarchy/outfit/job/colonist/geminus_innie_orion_defector/ert
	name = "Insurrectionist Orion Defector ERT"

	head = /obj/item/clothing/head/helmet/innie/urfdefector
	l_hand = /obj/item/weapon/gun/projectile/m7_smg/silenced
	r_hand = /obj/item/weapon/storage/box/m7_m443/rnd48
	glasses = /obj/item/clothing/glasses/hud/tactical
	mask = /obj/item/clothing/mask/gas/soebalaclava
	suit = /obj/item/clothing/suit/storage/innie/urfdefector
	belt = /obj/item/weapon/storage/belt/marine_ammo
	uniform = /obj/item/clothing/under/psysuit/theta
	shoes = /obj/item/clothing/shoes/marine/orion
	l_ear = /obj/item/device/radio/headset/insurrection
	gloves = /obj/item/clothing/gloves/marine/orion
	pda_slot = null
	back = /obj/item/weapon/storage/backpack/odst/regular
	l_pocket = /obj/item/weapon/storage/firstaid/unsc
	r_pocket = /obj/item/weapon/storage/firstaid/unsc

	flags = 0

/decl/hierarchy/outfit/job/colonist/geminus_innie_orion_defector/ert/equip_id(mob/living/carbon/human/H, rank, assignment)
	. = ..()

	var/obj/item/weapon/card/id/W = .
	if(W)
		W.rank = "Colonist"
		W.assignment = "Colonist"
		W.update_name()


/decl/hierarchy/outfit/job/innie_colossus/ert
	name = "Insurrectionist Heavy ERT"

	head = /obj/item/clothing/head/bomb_hood/security/colossus
	l_hand = /obj/item/weapon/gun/projectile/br55
	r_hand = /obj/item/weapon/storage/box/br55_m634
	glasses = /obj/item/clothing/glasses/hud/tactical
	mask = /obj/item/clothing/mask/gas/soebalaclava
	suit = /obj/item/clothing/suit/bomb_suit/security/colossus
	belt = /obj/item/weapon/storage/belt/marine_ammo
	uniform = /obj/item/clothing/under/psysuit/theta
	shoes = /obj/item/clothing/shoes/innie_boots/medium/black
	l_ear = /obj/item/device/radio/headset/insurrection
	gloves = /obj/item/clothing/gloves/marine/orion
	pda_slot = null
	back = /obj/item/weapon/storage/backpack/odst/regular
	l_pocket = /obj/item/weapon/storage/firstaid/unsc
	r_pocket = /obj/item/weapon/storage/firstaid/unsc

	flags = 0

/decl/hierarchy/outfit/job/innie_colossus/ert(mob/living/carbon/human/H, rank, assignment)
	. = ..()

	var/obj/item/weapon/card/id/W = .
	if(W)
		W.rank = "Colonist"
		W.assignment = "Colonist"
		W.update_name()

/decl/hierarchy/outfit/job/zeal_team/ert
	name = "Zeal Team 6 ERT"

	head = /obj/item/clothing/head/helmet/zeal
	l_hand = /obj/item/weapon/gun/projectile/br55
	r_hand = /obj/item/weapon/storage/box/br55_m634
	glasses = /obj/item/clothing/glasses/hud/tactical
	mask = /obj/item/clothing/mask/gas/soebalaclava
	suit = /obj/item/clothing/suit/justice/zeal
	belt = /obj/item/weapon/storage/belt/marine_ammo
	uniform = /obj/item/clothing/under/psysuit/theta
	shoes = /obj/item/clothing/shoes/innie_boots/light/brown
	l_ear = /obj/item/device/radio/headset/insurrection
	gloves = /obj/item/clothing/gloves/marine/orion
	pda_slot = null
	back = /obj/item/weapon/storage/backpack/odst/regular
	l_pocket = /obj/item/weapon/storage/firstaid/unsc
	r_pocket = /obj/item/weapon/storage/firstaid/unsc

	flags = 0

/decl/hierarchy/outfit/job/zeal_team_rifleman/ert(mob/living/carbon/human/H, rank, assignment)
	. = ..()

	var/obj/item/weapon/card/id/W = .
	if(W)
		W.rank = "Colonist"
		W.assignment = "Colonist"
		W.update_name()