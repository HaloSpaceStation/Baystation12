 // need icons for all projectiles and magazines
/obj/item/projectile/covenant
	name = "Plasma Bolt"
	desc = "A searing hot bolt of plasma."

/obj/item/projectile/covenant/plasmapistol
	damage = 25
	accuracy = -1

/obj/item/projectile/covenant/plasmarifle
	damage = 30
	accuracy = 1

/obj/item/ammo_magazine/needles
	name = "Needles"
	desc = "A small pack of crystalline needles."
	icon = null
	max_ammo = 20
	ammo_type = /obj/item/projectile/covenant/needles

/obj/item/projectile/covenant/needles
	name = "Needle"
	desc = "A sharp, pink crystalline shard"
	damage = 20
	accuracy = 0