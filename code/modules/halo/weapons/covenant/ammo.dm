 // need icons for all projectiles and magazines
/obj/item/projectile/covenant
	name = "Plasma Bolt"
	desc = "A searing hot bolt of plasma."

/obj/item/projectile/covenant/plasmapistol
	damage = 25
	accuracy = -1
	icon = 'code/modules/halo/icons/Covenant Weapons.dmi'
	icon_state = "PlasmapistolProj"

/obj/item/projectile/covenant/plasmapistol/overcharge
	damage = 75

/obj/item/projectile/covenant/plasmarifle
	damage = 30
	accuracy = 1
	icon = 'code/modules/halo/icons/Covenant Weapons.dmi'
	icon_state = "PlasmarifleProj"

/obj/item/ammo_magazine/needles
	name = "Needles"
	desc = "A small pack of crystalline needles."
	icon = 'code/modules/halo/icons/Covenant Weapons.dmi'
	icon_state = "needlermag"
	max_ammo = 30
	ammo_type = /obj/item/ammo_casing/needles
	caliber = "needler"
	mag_type = MAGAZINE

/obj/item/ammo_casing/needles
	desc = "Small crystalline needles"
	caliber = "needler"
	projectile_type = /obj/item/projectile/bullet/covenant/needles
	icon = 'code/modules/halo/icons/Covenant Weapons.dmi'
	icon_state = "needlerammo"

/obj/item/projectile/bullet/covenant/needles
	name = "Needle"
	desc = "A sharp, pink crystalline shard"
	damage = 20
	accuracy = 0
	icon = 'code/modules/halo/icons/Covenant Weapons.dmi'
	icon_state = "needlerammo"