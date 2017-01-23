
//define the various projectile types

/obj/item/projectile/autocannon50
	name = "autocannon round"
	icon_state = "gauss"
	damage = 500
	damage_type = BRUTE
	check_armour = "bomb"

/obj/item/projectile/overmap/autocannon50
	name = "overmap autocannon round"
	icon_state = "50mm_overmap"
	damage = 500
	damage_type = BRUTE
	check_armour = "bomb"

/obj/item/projectile/plasma_turret
	name = "plasma cannon round"
	icon_state = "pulse1_bl"
	damage = 1000
	damage_type = BURN
	check_armour = "energy"

/obj/item/projectile/overmap/plasma_turret
	name = "overmap plasma cannon round"
	icon_state = "plasmaturret_overmap"
	damage = 1000
	damage_type = BURN
	check_armour = "energy"
