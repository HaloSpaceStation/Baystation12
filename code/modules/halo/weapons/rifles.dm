#define MAGAZINE 		4



/obj/item/weapon/gun/projectile/automatic/assault
	name = "\improper MA5B Assault Rifle"
	desc = "standard-issue service rifle of the UNSC Marines."
	icon_state = "assault-loaded"
	item_state = "assault"
	w_class = 3
	force = 10
	caliber = "7.62mm"
	origin_tech = list(TECH_COMBAT = 5, TECH_MATERIAL = 2, TECH_ILLEGAL = 8)
	slot_flags = SLOT_BELT|SLOT_BACK
	fire_sound = 'sound/weapons/Gunshot_light.ogg'
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/assault
	auto_eject = 1
	auto_eject_sound = 'sound/weapons/smg_empty_alarm.ogg'

/obj/item/weapon/gun/projectile/assault/update_icon()
	..()
	if(loaded.len)
		icon_state = "assault-loaded"
	else
		icon_state = "assault-empty"
