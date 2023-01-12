/decl/hierarchy/supply_pack/unsc_explosives
	name = "UNSC Explosives"
	faction_lock = "UNSC"
	containertype = /obj/structure/closet/crate/secure/weapon

/* GRENADES */

/decl/hierarchy/supply_pack/unsc_explosives/fragnade
	name = "M9 Fragmentation grenades (2 boxes)"
	contains = list(/obj/item/weapon/storage/box/m9_frag = 2)
	cost = 200
	containername = "\improper M9 grenades crate"

/decl/hierarchy/supply_pack/unsc_explosives/smokenade
	name = "Smoke grenades (6)"
	contains = list(/obj/item/weapon/grenade/smokebomb = 6)
	cost = 50
	containername = "\improper Smoke grenades crate"

/* LANDMINES */

/decl/hierarchy/supply_pack/unsc_explosives/fragmine
	name = "Fragmentation Land Mines (6 mines)"
	contains = list(/obj/item/device/landmine/frag = 6)
	cost = 800
	containername = "\improper Frag Mine Crate"

/decl/hierarchy/supply_pack/unsc_explosives/hemine
	name = "High Explosive Land Mines (6 mines)"
	contains = list(/obj/item/device/landmine/explosive = 6)
	cost = 800
	containername = "\improper HE Mine Crate"

/decl/hierarchy/supply_pack/unsc_explosives/empmine
	name = "Electromagnetic Pulse Land Mines (3 mines)"
	contains = list(/obj/item/device/landmine/emp = 3)
	cost = 1000
	containername = "\improper EMP Mine Crate"

/decl/hierarchy/supply_pack/unsc_explosives/incmine
	name = "Incendiary Land Mines (3 mines)"
	contains = list(/obj/item/device/landmine/flame = 3)
	cost = 1000
	containername = "\improper Incendiary Mine Crate"

/* BREACHING CHARGES */

/decl/hierarchy/supply_pack/unsc_explosives/plastique
	name = "C12 Breaching Charges (4)"
	cost = 200
	contains = list(/obj/item/weapon/plastique = 4)
	containername = "\improper C12 Breaching Charge crate"

/decl/hierarchy/supply_pack/unsc_explosives/plastique_breaching
	name = "Large Breaching Charges (4)"
	cost = 500
	contains = list(/obj/item/weapon/plastique/breaching = 4)
	containername = "\improper Breaching Charge crate"

/decl/hierarchy/supply_pack/unsc_explosives/plastique_breachingpierce
	name = "Piercing Breaching Charges (4)"
	cost = 700
	contains = list(/obj/item/weapon/plastique/breaching/longrange = 4)
	containername = "\improper Piercing Breaching Charge crate"