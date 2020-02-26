
/decl/hierarchy/outfit/job/geminus_innie
	name = "Insurrectionist"

	head = /obj/item/clothing/head/helmet/mediumurf/brown
	glasses = /obj/item/clothing/glasses/hud/tactical
	mask = /obj/item/clothing/mask/balaclava/tactical
	suit = /obj/item/clothing/suit/storage/mediumurfarmor/brown
	uniform = /obj/item/clothing/under/innie/jumpsuit
	shoes = /obj/item/clothing/shoes/mediumurfboot/brown
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

	head = /obj/item/clothing/head/helmet/heavyurf/vblue
	glasses =/obj/item/clothing/glasses/hud/tactical
	mask = /obj/item/clothing/mask/balaclava/tactical
	suit = /obj/item/clothing/suit/storage/heavyurfarmor/blue
	uniform = /obj/item/clothing/under/innie/jumpsuit
	shoes = /obj/item/clothing/shoes/mediumurfboot/blue
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

	head = /obj/item/clothing/head/helmet/space/deathsquad/urfdefector
	glasses = /obj/item/clothing/glasses/hud/tactical
	mask = /obj/item/clothing/mask/gas/soebalaclava
	suit = /obj/item/clothing/suit/space/void/swat/urfdefector
	uniform = /obj/item/clothing/under/psysuit/theta
	shoes = /obj/item/clothing/shoes/swat/theta
	l_ear = /obj/item/device/radio/headset/insurrection
	gloves = /obj/item/clothing/gloves/guards/theta
	pda_slot = null

	flags = 0

/decl/hierarchy/outfit/job/geminus_innie_orion_defector/equip_id(mob/living/carbon/human/H, rank, assignment)
	. = ..()

	var/obj/item/weapon/card/id/W = .
	if(W)
		W.rank = "Colonist"
		W.assignment = "Colonist"
		W.update_name()