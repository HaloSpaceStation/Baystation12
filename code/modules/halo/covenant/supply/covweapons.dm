/decl/hierarchy/supply_pack/covenant_weapons
	name = "Covenant Weapons"
	faction_lock = "Covenant"
	containertype = /obj/structure/closet/crate/covenant

/* MELEE */

/decl/hierarchy/supply_pack/covenant_weapons/blamitedagger
	name = "Blamite Daggers (3)"
	contains = list(/obj/item/weapon/melee/blamite/dagger = 3)
	cost = 50
	containername = "\improper Blamite Dagger crate"

/decl/hierarchy/supply_pack/covenant_weapons/energydagger
	name = "Energy Daggers (3)"
	contains = list(/obj/item/weapon/melee/energy/elite_sword/dagger = 3)
	cost = 50
	containername = "\improper Energy Dagger crate"

/* FIREARMS */

/decl/hierarchy/supply_pack/covenant_weapons/plaspistol
	name = "Type-25 Directed Energy Pistols (3)"
	contains = list(/obj/item/weapon/gun/energy/plasmapistol = 3)
	cost = 200 // Extra cost due to ammunition capacity
	containername = "\improper Type-25 Directed Energy Pistol crate"

/decl/hierarchy/supply_pack/covenant_weapons/needler
	name = "Type-33 Guided Munitions Launchers (3)"
	contains = list(/obj/item/weapon/gun/projectile/needler = 3)
	cost = 100
	containername = "\improper Type-33 Guided Munitions Launcher crate"

/decl/hierarchy/supply_pack/covenant_weapons/needlerifle
	name = "Type-31 Needle Rifles (3)"
	contains = list(/obj/item/weapon/gun/projectile/type31needlerifle = 3)
	cost = 100
	containername = "\improper Type-31 Needle Rifle crate"

/decl/hierarchy/supply_pack/covenant_weapons/type51carbine
	name = "Type-51 Carbines (3)"
	contains = list(/obj/item/weapon/gun/projectile/type51carbine = 3)
	cost = 100
	containername = "\improper Type-51 Carbine crate"

/decl/hierarchy/supply_pack/covenant_weapons/plasmarifle
	name = "Plasma Rifles (3)"
	contains = list(/obj/item/weapon/gun/energy/plasmarifle = 3)
	cost = 200 // Extra cost due to ammunition capacity
	containername = "\improper Plasma Rifle crate"

/decl/hierarchy/supply_pack/covenant_weapons/concussionrifle
	name = "Type-50 Concussion Rifles (3)"
	contains = list(/obj/item/weapon/gun/projectile/concussion_rifle = 3)
	cost = 100
	containername = "\improper Concussion Rifle crate"

/decl/hierarchy/supply_pack/covenant_weapons/spiker
	name = "Type-25 Spikers (3)"
	contains = list(/obj/item/weapon/gun/projectile/spiker = 3)
	cost = 100
	containername = "\improper Spiker crate"

/* Mauler excluded due to its power. I don't want everyone getting equipped with Maulers */
/* TURRETS */

/decl/hierarchy/supply_pack/covenant_weapons/plasturret_kit
	name = "Plasma Turret Kit"
	contains = list(/obj/item/turret_deploy_kit/plasturret = 1)
	cost = 600
	containername = "\improper Plasma Turret Kit crate"