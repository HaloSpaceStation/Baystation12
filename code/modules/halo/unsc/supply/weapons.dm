/decl/hierarchy/supply_pack/unsc_weapons
	name = "UNSC Weapons"
	faction_lock = "UNSC"
	containertype = /obj/structure/closet/crate/secure/weapon

/* MELEE */

/decl/hierarchy/supply_pack/unsc_weapons/melee_knife
	name = "Combat Knives (3)"
	cost = 25
	contains = list(
		/obj/item/weapon/material/knife/combat_knife = 3)
	containername = "\improper Combat Knife crate"

/decl/hierarchy/supply_pack/unsc_weapons/melee_machete
	name = "Machetes (3)"
	cost = 50
	contains = list(
		/obj/item/weapon/material/machete = 3)
	containername = "\improper Machete crate"

/decl/hierarchy/supply_pack/unsc_weapons/melee_humbler
	name = "Humbler Stun Batons (3)"
	cost = 50
	contains = list(
		/obj/item/weapon/melee/baton/humbler = 3)
	containername = "\improper Humbler Stun Baton crate"

/* FIREARMS */

/decl/hierarchy/supply_pack/unsc_weapons/m6d
	name = "M6D Magnums (3)"
	cost = 100
	contains = list(
		/obj/item/weapon/gun/projectile/m6d_magnum = 3)
	containername = "\improper M6D Magnum crate"

/decl/hierarchy/supply_pack/unsc_weapons/ma5b_ar
	name = "MA5B Assault Rifles (3)"
	cost = 100
	contains = list(
		/obj/item/weapon/gun/projectile/ma5b_ar = 3)
	containername = "\improper MA5B Assault Rifle crate"

/decl/hierarchy/supply_pack/unsc_weapons/br55
	name = "BR55 Battle Rifles (3)"
	cost = 100
	contains = list(
		/obj/item/weapon/gun/projectile/br55 = 3)
	containername = "\improper BR55 Battle Rifle crate"

/decl/hierarchy/supply_pack/unsc_weapons/m392_dmr
	name = "M392 Designated Marksman Rifles (3)"
	cost = 100
	contains = list(
		/obj/item/weapon/gun/projectile/m392_dmr = 3)
	containername = "\improper M392 Designated Marksman Rifle crate"

/decl/hierarchy/supply_pack/unsc_weapons/m90_ts
	name = "M90 Tactical Shotguns (3)"
	cost = 100
	contains = list(
		/obj/item/weapon/gun/projectile/shotgun/pump/m90_ts = 3)
	containername = "\improper M90 Tactical Shotgun crate"

/decl/hierarchy/supply_pack/unsc_weapons/m7_smg
	name = "M7 Submachine Guns (3)"
	cost = 100
	contains = list(
		/obj/item/weapon/gun/projectile/m7_smg = 3)
	containername = "\improper M7 Submachine Gun crate"

/* TURRETS */

/decl/hierarchy/supply_pack/unsc_weapons/hmg_kit
	name = "HMG Turret Kit"
	cost = 600
	contains = list(/obj/item/turret_deploy_kit/HMG = 1)
	containername = "\improper HMG Turret Kit crate"

/decl/hierarchy/supply_pack/unsc_weapons/chaingun_kit
	name = "Chaingun Turret Kit"
	cost = 600
	contains = list(/obj/item/turret_deploy_kit/chaingun = 1)
	containername = "\improper Chaingun Turret Kit crate"
