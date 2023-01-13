/decl/hierarchy/supply_pack/covenant_eva
	name = "Covenant EVA"
	faction_lock = "Covenant"
	containertype = /obj/structure/closet/crate/covenant

/* EVA SUITS */

/decl/hierarchy/supply_pack/covenant_eva/kigyar_ranger
	name = "KigYar Ranger Suit (1 suit)"
	contains = list(
		/obj/item/clothing/suit/armor/ranger_kigyar = 1,
		/obj/item/clothing/head/helmet/ranger_kigyar = 1,
		/obj/item/clothing/shoes/magboots/ranger_kigyar = 1)
	cost = 300
	containername = "\improper KigYar Ranger Suit crate"

/decl/hierarchy/supply_pack/covenant_eva/sangheili_ranger
	name = "Sangheili Ranger Suit (1 suit)"
	contains = list(
		/obj/item/clothing/suit/armor/special/combatharness/ranger = 1,
		/obj/item/clothing/head/helmet/sangheili/ranger = 1,
		/obj/item/clothing/shoes/magboots/sangheili = 1,
		/obj/item/clothing/gloves/thick/sangheili/ranger = 1)
	cost = 300
	containername = "\improper Sangheili Ranger Suit crate"

/decl/hierarchy/supply_pack/covenant_eva/jiralhanae_ranger
	name = "Jiralhanae Ranger Suit (1 suit)"
	contains = list(
		/obj/item/clothing/suit/armor/jiralhanae/covenant/EVA = 1,
		/obj/item/clothing/head/helmet/jiralhanae/covenant/EVA = 1,
		/obj/item/clothing/shoes/magboots/jiralhanaeEVA = 1)
	cost = 300
	containername = "\improper Jiralhanae Ranger Suit crate"

/* ATMOS */


/decl/hierarchy/supply_pack/covenant_eva/o2_can
	name = "O2 Canister (1)"
	containertype = /obj/structure/largecrate //Requires a larger crate to fit
	contains = list(/obj/machinery/portable_atmospherics/canister/oxygen = 1)
	cost = 100
	containername = "\improper O2 Canister Crate"

/decl/hierarchy/supply_pack/covenant_eva/unggoy_tank
	name = "Unggoy Methane Tank (3)"
	contains = list(
		/obj/item/weapon/tank/methane/unggoy_internal = 1,
		/obj/item/weapon/tank/methane/unggoy_internal/red = 1,
		/obj/item/weapon/tank/methane/unggoy_internal/green = 1,
		/obj/item/weapon/tank/methane/unggoy_internal/blue = 1)
	cost = 50
	num_contained = 3
	containername = "\improper Unggoy Methane Tank crate"
	supply_method = /decl/supply_method/randomized

/decl/hierarchy/supply_pack/covenant_eva/airtanks
	name = "Air Tanks (3)"
	contains = list(/obj/item/weapon/tank/air/covenant = 3)
	cost = 50
	containername = "\improper Air Tanks Crate"