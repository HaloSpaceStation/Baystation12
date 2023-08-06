
/obj/item/weapon/storage/belt/covenant_ammo
	name = "Covenant martial belt"
	desc = "A belt with many various pouches to hold ammunition and weaponry"
	icon = 'tools.dmi'
	item_state = "securitybelt"
	color = "#ff99ff"
	w_class = ITEM_SIZE_HUGE
	max_w_class = ITEM_SIZE_LARGE
	storage_slots = 7
	sprite_sheets = list(
		"Tvaoan Kig-Yar" = null,\
		"Sangheili" = null\
		)

	can_hold = AMMO_BELT_CANHOLD

/obj/item/weapon/storage/belt/covenant_medic
	name = "Covenant Medical Belt"

	desc = "A belt with multiple hooks to hold medical kits. Heavy, but distributes the weight of larger loads much more efficiently."
	icon = 'tools.dmi'
	item_state = "securitybelt"
	color = "#ff99ff"
	w_class = ITEM_SIZE_HUGE
	sprite_sheets = list(
		"Tvaoan Kig-Yar" = null,\
		"Sangheili" = null\
		)
	storage_slots = 5
	dynamic_storage_threshold = 12

	can_hold = MEDIC_BELT_CANHOLD

/obj/item/clothing/accessory/storage/bandolier/covenant
	name = "Covenant Bandolier"
	desc = "A lightweight synthetic bandolier made by the covenant to carry small items"
	icon = 'tools.dmi'
	icon_state = "covbandolier"
