/decl/hierarchy/supply_pack/covexplosives
	name = "Covenant Explosives"
	faction_lock = "Covenant"
	containertype = /obj/structure/closet/crate/covenant

/* GRENADES */

/decl/hierarchy/supply_pack/covexplosives/grenade_plasma
	name = "Type-1 Plasma antipersonnel grenades (2 boxes)"
	contains = list(/obj/item/weapon/storage/box/plasmagrenades = 2)
	cost = 200
	containername = "Type-1 Plasma antipersonnel grenades crate"

/decl/hierarchy/supply_pack/covexplosives/grenade_spike
	name = "Type-2 spike antipersonnel grenades (2 boxes)"
	contains = list(/obj/item/weapon/grenade/frag/spike = 6)
	cost = 200
	containername = "Type-2 spike antipersonnel grenades crate"

/decl/hierarchy/supply_pack/covexplosives/grenade_toxic
	name = "Toxic gas grenades (5)"
	contains = list(/obj/item/weapon/grenade/toxic_gas = 5)
	cost = 600
	containername = "Toxic gas grenades crate"

/* BREACHING CHARGES */

/decl/hierarchy/supply_pack/covexplosives/plastique
	name = "C12 Breaching Charges (4)"
	cost = 200
	contains = list(/obj/item/weapon/plastique/covenant = 4)
	containername = "\improper C12 Breaching Charge crate"

/decl/hierarchy/supply_pack/covexplosives/plastique_breaching
	name = "Large Breaching Charges (4)"
	cost = 500
	contains = list(/obj/item/weapon/plastique/breaching = 4)
	containername = "\improper Breaching Charge crate"

/decl/hierarchy/supply_pack/covexplosives/plastique_breachingpierce
	name = "Piercing Breaching Charges (4)"
	cost = 700
	contains = list(/obj/item/weapon/plastique/breaching/longrange = 4)
	containername = "\improper Piercing Breaching Charge crate"