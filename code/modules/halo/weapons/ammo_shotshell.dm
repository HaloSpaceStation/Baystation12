
/obj/item/projectile/bullet/shotgun
	name = "slug"
	fire_sound = 'sound/weapons/gunshot/shotgun.ogg'
	damage = 50
	armor_penetration = 40
	shield_damage = 30

/obj/item/projectile/bullet/shotgun/beanbag		//because beanbags are not bullets
	name = "beanbag"
	check_armour = "melee"
	damage = 10
	agony = 50
	armor_penetration = 0
	embed = 0
	sharp = 0

/obj/item/projectile/bullet/pellet/shotgun
	name = "shrapnel"
	icon = 'code/modules/halo/weapons/icons/Weapon Sprites.dmi'
	icon_state = "bullet_shotshell"
	fire_sound = 'sound/weapons/gunshot/shotgun.ogg'
	damage = 22
	armor_penetration = 10
	shield_damage = 25
	pellets = 8
	range_step = 1
	spread_step = 5

/obj/item/projectile/bullet/pellet/shotgun/high_power
	name = "large shrapnel"
	damage = 20
	armor_penetration = 30
	pellets = 6
	range_step = 1.5
	spread_step = 10

/obj/item/ammo_casing/shotgun/pellet/low_power
	desc = "A 12g shotgun shell, low-powder load."
	caliber = "shotgunlowpower"
	projectile_type = /obj/item/projectile/bullet/pellet/low_power

/obj/item/projectile/bullet/pellet/low_power
	damage = 18
	pellets = 6

//8gauge caliber rechambers
/obj/item/ammo_casing/shotgun/high_power
	desc = "An 8 gauge slug."
	caliber = "shotgunhighpower"

/obj/item/ammo_casing/shotgun/pellet/high_power
	desc = "An 8-gauge shotgun shell,"
	caliber = "shotgunhighpower"
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun/high_power

/obj/item/ammo_casing/shotgun/blank/high_power
	caliber = "shotgunhighpower"

/obj/item/ammo_casing/shotgun/practice/high_power
	caliber = "shotgunhighpower"

/obj/item/ammo_casing/shotgun/beanbag/high_power
	caliber = "shotgunhighpower"

/obj/item/ammo_casing/shotgun/flash/high_power
	caliber = "shotgunhighpower"

/obj/item/ammo_casing/shotgun/emp/high_power
	desc = "An 8 gauge shotgun slug fitted with a single-use ion pulse generator."
	caliber = "shotgunhighpower"