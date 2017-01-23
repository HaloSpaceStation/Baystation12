#define MAGAZINE 		4



/obj/item/weapon/gun/projectile/magnum
	name = "\improper M6D Magnum"
	desc = "United Nations Space Command sidearm and is one of the variants of Misriah Armory's M6 handgun series."
	magazine_type = /obj/item/ammo_magazine/magnum
	icon_state = "magnum"
	caliber = "40mm"
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	fire_sound = 'sound/weapons/Gunshot_light.ogg'
	load_method = MAGAZINE

/obj/item/weapon/gun/projectile/magnum/update_icon()
	..()
	if(loaded.len)
		icon_state = "magnum-loaded"
	else
		icon_state = "magnum-empty"
