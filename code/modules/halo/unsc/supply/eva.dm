/decl/hierarchy/supply_pack/unsc_eva
	name = "UNSC EVA Equipment"
	faction_lock = "UNSC"
	containertype = /obj/structure/closet/crate/secure/weapon

/* EVA SUITS */

/decl/hierarchy/supply_pack/unsc_eva/evasuit
	name = "UNSC Marine EVA Suit (1 Suit)"
	contains = list(/obj/item/weapon/storage/box/large/armorset/eva = 1)
	cost = 300
	containername = "\improper EVA Suit Crate"

/* ATMOS */

/decl/hierarchy/supply_pack/unsc_eva/o2_can
	name = "O2 Canister (1)"
	containertype = /obj/structure/largecrate //Requires a larger crate to fit
	contains = list(/obj/machinery/portable_atmospherics/canister/oxygen = 1)
	cost = 100
	containername = "\improper O2 Canister Crate"

/decl/hierarchy/supply_pack/unsc_eva/airtanks
	name = "Air Tanks (3)"
	contains = list(/obj/item/weapon/tank/air = 3)
	cost = 50
	containername = "\improper Air Tanks Crate"