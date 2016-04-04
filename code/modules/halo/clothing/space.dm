/obj/item/clothing/head/helmet/space/void/innie
	icon = 'code/modules/halo/clothing/clothing.dmi'
	name = "insurrectionist helmet"
	desc = "An ODST combat space suit with a sleek red paintjob and rebel markings. The serial number and trademark information are scratched off."
	icon_state = "innieHelmet"
	item_state = "innieHelmet"
	armor = list(melee = 60, bullet = 50, laser = 30,energy = 15, bomb = 35, bio = 100, rad = 60)
	siemens_coefficient = 0.6
	species_restricted = list("Human")
	camera_networks = list()
	light_overlay = "helmet_light_green"

/obj/item/clothing/suit/space/void/innie
	icon = 'code/modules/halo/clothing/clothing.dmi'
	icon_state = "innieArmor"
	item_state = "innieArmor"
	name = "insurrectionist suit"
	desc = "An ODST combat space helmet with a sleek red paintjob and rebel markings. The serial number and trademark information are scratched off."
	item_state = "syndie_voidsuit"
	w_class = 3
	armor = list(melee = 60, bullet = 50, laser = 30, energy = 15, bomb = 35, bio = 100, rad = 60)
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/device/suit_cooling_unit,/obj/item/weapon/gun,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/melee/energy/sword,/obj/item/weapon/handcuffs)
	siemens_coefficient = 0.6
	species_restricted = list("Human")


/obj/item/clothing/head/helmet/space/void/salvage
	name = "salvaging  helmet"
	desc = "A bulky UNSC salvager's helmet. Perfect for scrapping unused ships, stations, and other space junk."
	icon_state = "rig0-salvage"
	item_state = "rig0-salvage"
	item_state_slots = list(
		slot_l_hand_str = "mining_helm",
		slot_r_hand_str = "mining_helm",
		)
	armor = list(melee = 30, bullet = 10, laser = 20, energy = 5, bomb = 55, bio = 100, rad = 75)
	light_overlay = "helmet_light_salvage"

/obj/item/clothing/suit/space/void/salvage
	icon_state = "salvage_void"
	name = "salvaging space suit"
	desc = "A bulky UNSC salvager's space suit. Perfect for scrapping unused ships, stations, and other space junk."
	item_state = "salvage_void"
	armor = list(melee = 30, bullet = 10, laser = 20, energy = 5, bomb = 55, bio = 100, rad = 75)
	allowed = list(/obj/item/device/flashlight,/obj/item/weapon/tank,/obj/item/device/suit_cooling_unit,/obj/item/weapon/storage/bag/ore,/obj/item/device/t_scanner,/obj/item/weapon/pickaxe, /obj/item/weapon/rcd)
