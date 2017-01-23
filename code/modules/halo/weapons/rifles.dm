#define MAGAZINE 		4



/obj/item/weapon/gun/projectile/automatic/assault
	name = "\improper MA5B Assault Rifle"
	desc = "standard-issue service rifle of the UNSC Marines."
	icon_state = "assault"
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

/obj/item/weapon/gun/projectile/automatic/m739
	name = "\improper M739 Light Machine Gun"
	desc = "standard-issue squad automatic weapon, designed for use in heavy engagements."
	icon_state = "M739"
	item_state = "M739"
	w_class = 3
	force = 20
	caliber = "7.62mm"
	origin_tech = list()
	slot_flags = SLOT_BACK
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/m739
	auto_eject = 1
	auto_eject_sound = 'sound/weapons/smg_empty_alarm.ogg'

