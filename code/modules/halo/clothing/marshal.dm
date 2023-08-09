#define MARSHAL_OVERRIDE 'code/modules/halo/clothing/marshal.dmi'

//UNDER

obj/item/clothing/under/police/marshal
	name = "Marshal's Uniform"
	desc = "A tan uniform worn by UEG Marshals."
	icon = 'code/modules/halo/clothing/marshal.dmi'
	icon_state = "marshal_uniform_obj"
	worn_state = "marshal-uniform"
	starting_accessories = list(/obj/item/clothing/accessory/holster/thigh)
	item_icons = list(
		slot_l_hand_str = 'code/modules/halo/clothing/gcpd_leftinhands.dmi',
		slot_r_hand_str = 'code/modules/halo/clothing/gcpd_rightinhands.dmi',
		)

//HELMET

/obj/item/clothing/head/helmet/swat/police/marshal //light
	name = "Marshal Impact Helmet"
	desc = "A Marshal lightweight helmet tailored towards protecting the wearer from blows to the head with minor shrapnel protection."
	icon_override = MARSHAL_OVERRIDE
	icon = MARSHAL_OVERRIDE
	icon_state = "marshal_helmet_obj"
	item_state = "marshal_helmet_w"

/obj/item/clothing/head/helmet/swat/police/medium/marshal //medium
	name = "Marshal Ballistic Helmet"
	desc = "A heavier Marshal helmet designed to be worn with the medium ballistic vest with more focus on protecting the eyes and head from shrapnel and bullets."
	icon_override = MARSHAL_OVERRIDE
	icon = MARSHAL_OVERRIDE
	icon_state = "marshal_helmet_goggled_obj"
	item_state = "marshal_helmet_goggled_w"

/obj/item/clothing/head/helmet/gas/police/heavy/marshal //heavy
	name = "Marshal EH252 Helmet"
	desc = "A fully enclosed Marshal helmet with inbuilt tear gas filters designed to protect the entirety of the head from ballistics and shrapnel. Goes with the heavy ballistic suit."
	icon_override = MARSHAL_OVERRIDE
	icon = MARSHAL_OVERRIDE
	icon_state = "marshal_helmet_visor_obj"
	item_state = "marshal_helmet_visor_w"

//HEAD

/obj/item/clothing/head/soft/police/marshal
	name = "Marshal Hat"
	desc = "A soft patrol cap to identify officers or show support."
	icon_override = MARSHAL_OVERRIDE
	icon = MARSHAL_OVERRIDE
	icon_state = "marshal_hat_obj"
	item_state = "marshal_hat_w"

/obj/item/clothing/head/soft/police/marshal/patrol
	name = "Marshal Patrol Hat"
	desc = "A hat worn by Marshals, to signify their status, reinforced with internal armour."
	icon_override = MARSHAL_OVERRIDE
	icon = MARSHAL_OVERRIDE
	icon_state = "marshal_patrol_hat_obj"
	item_state = "marshal_patrol_hat_w"

/obj/item/clothing/head/soft/police/marshal/beret
	name = "Marshal Beret"
	desc = "A beret worn by Marshals, to signify their status, reinforced with internal armour."
	icon_override = MARSHAL_OVERRIDE
	icon = MARSHAL_OVERRIDE
	icon_state = "marshal_beret_obj"
	item_state = "marshal_beret_w"

//SUIT

/obj/item/clothing/suit/storage/vest/tactical/police/marshal //light
	name = "Marshal Light Tactical Vest"
	desc = "A lightweight ballistic vest designed to reduce damage from low caliber rounds or stab wounds specifically to the upper torso. For light duties only."
	icon_override = MARSHAL_OVERRIDE
	icon = MARSHAL_OVERRIDE
	icon_state = "marshal_armor_l_obj"
	item_state = "marshal_armor_l_w"
	body_parts_covered = ARMS|UPPER_TORSO
	armor = list(melee = 40, bullet = 45, laser = 45, energy = 40, bomb = 40, bio = 25, rad = 25) // Weaker than Marine armor.
	armor_thickness = 15

/obj/item/clothing/suit/armor/vest/police_medium/marshal //medium
	name = "Marshal Ballistic Vest"
	desc = "A moderately armored vest designed for dangerous operations that features full upper and lower torso coverage."
	icon_override = MARSHAL_OVERRIDE
	icon = MARSHAL_OVERRIDE
	icon_state = "marshal_armor_m_obj"
	item_state = "marshal_armor_m_w"
	armor = list(melee = 45, bullet = 50, laser = 50, energy = 40, bomb = 40, bio = 25, rad = 25) // Slightly more protection than the light vest, still weaker than marine armor.
	armor_thickness = 20

/obj/item/clothing/suit/armor/vest/police/marshal //heavy
	name = "Marshal Heavy Ballistic Suit"
	desc = "A heavily armored vest designed for bullet and explosive resistance with coverage including the arms, upper and lower torso, and neck."
	icon_override = MARSHAL_OVERRIDE
	icon = MARSHAL_OVERRIDE
	icon_state = "marshal_armor_h_obj"
	item_state = "marshal_armor_h_w"
	armor = list(melee = 60, bullet = 55, laser = 55, energy = 45, bomb = 50, bio = 25, rad = 25) // More protection than the medium vest and stronger than marine armor, at the cost of slowdown.
	armor_thickness = 25

//MASK

/obj/item/clothing/mask/balaclava/tactical/police/marshal
	name = "Marshal Balaclava"
	desc = "A Marshal issued balaclava, for use in cold climate enviroments."
	icon_override = MARSHAL_OVERRIDE
	icon = MARSHAL_OVERRIDE
	icon_state = "marshal_mask_obj"
	item_state = "marshal_mask_w"

//EYES

/obj/item/clothing/glasses/police/marshal
	name = "Ballistic Glasses"
	desc = "Tinted to reduce glare and strenghtened to protect eyeballs from shrapnel."

//SHOES

/obj/item/clothing/shoes/marine/marshal
	name = "Marshal Boots"
	desc = "Boots worn by Marshals, to signify their status. Has inlays for to provide extra leg-armour."
	icon_override = MARSHAL_OVERRIDE
	icon = MARSHAL_OVERRIDE
	icon_state = "marshal_boots_obj"
	item_state = "marshal_boots_w"

//GLOVES

/obj/item/clothing/gloves/thick/unsc/marshal
	name = "Marshal Gloves and Armguards"
	desc = "Gloves and jumpsuit inlays designed to reinforce the arms and hands of Marshals."
	icon_override = MARSHAL_OVERRIDE
	icon = MARSHAL_OVERRIDE
	icon_state = "marshal_gloves_obj"
	item_state = "marshal_gloves_w"

//BELT

/obj/item/weapon/storage/belt/marine_ammo/marshal
	name = "Marshal Ammo Belt"
	desc = "A purpose built belt designed to carry ammunition and little else."

//RADIO

/obj/item/device/radio/headset/marshal
	name = "Colonial Marshal Radio Headset"
	icon_state = "sec_headset"
	dongles = list(/obj/item/device/channel_dongle/human_civ,\
		/obj/item/device/channel_dongle/marshals)

//ID

/obj/item/weapon/card/id/civilian/marshal
	name = "Colonial Marshal ID Card"
	desc = "An identification card worn by Colonial Marshals."
	assignment = "Colonial Marshal"
	access = list(8076) //KS7 Police Station Access
	icon_state = "id"
	item_state = "sec"


#undef MARSHAL_OVERRIDE
