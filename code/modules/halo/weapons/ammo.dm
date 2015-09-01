#define MAGAZINE 		4



/obj/item/ammo_magazine/magnum
	name = "magazine (12.7x40mm)"
	icon_state = "magnum"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/magnum
	matter = list(DEFAULT_WALL_MATERIAL = 525) //metal costs are very roughly based around 1 .45 casing = 75 metal
	caliber = "40mm"
	max_ammo = 12

/obj/item/ammo_casing/magnum
	desc = "A 40mm bullet casing."
	caliber = "40mm"
	projectile_type = /obj/item/projectile/bullet/pistol/medium

/obj/item/ammo_magazine/assault
	name = "magazine (12.7x40mm)"
	icon_state = "assault"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/magnum
	matter = list(DEFAULT_WALL_MATERIAL = 525) //metal costs are very roughly based around 1 .45 casing = 75 metal
	caliber = "7.62mm"
	max_ammo = 60

/obj/item/ammo_casing/asssault
	desc = "A 7.62mm bullet casing."
	caliber = "7.62mm"
	projectile_type = /obj/item/projectile/bullet/rifle/a762