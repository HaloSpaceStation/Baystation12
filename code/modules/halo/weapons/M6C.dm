
//M6C Magnum

/obj/item/weapon/gun/projectile/m6c_magnum
	name = "\improper M6C Magnum"
	desc = "The M6C is a common UNSC sidearm and one of the many variants of Misriah Armory's M6 handgun series. Takes 12.7mm calibre magazines."
	icon = 'code/modules/halo/weapons/icons/Weapon Sprites.dmi'
	icon_state = "m6c"
	item_state = "m6c"
	magazine_type = /obj/item/ammo_magazine/m6s/m225
	allowed_magazines = list(/obj/item/ammo_magazine/m6s,/obj/item/ammo_magazine/m6s/m225,/obj/item/ammo_magazine/m6s_m228)
	caliber = "12.7mm"
	slot_flags = SLOT_BELT|SLOT_HOLSTER
	fire_sound = 'code/modules/halo/sounds/MagnumShotSoundEffect.ogg'
	reload_sound = 'code/modules/halo/sounds/MagnumReloadSoundEffect.ogg'
	load_method = MAGAZINE
	dispersion = list(0.4)
	one_hand_penalty = 1
	scope_zoom_amount = 1.1
	slowdown_general = 0

	item_icons = list(
		slot_l_hand_str = 'code/modules/halo/weapons/icons/Weapon_Inhands_left.dmi',
		slot_r_hand_str = 'code/modules/halo/weapons/icons/Weapon_Inhands_right.dmi',
		)
	crosshair_file = 'code/modules/halo/weapons/icons/dragaim_icon.dmi'

/obj/item/weapon/gun/projectile/m6c_magnum/verb/scope()
	set category = "Weapon"
	set name = "Use Scope (Sidearm)"
	set popup_menu = 1

	toggle_scope(usr, scope_zoom_amount)

/obj/item/weapon/gun/projectile/m6c_magnum/update_icon()
	if(ammo_magazine)
		icon_state = "m6c"
	else
		icon_state = "m6c_unloaded"
	. = ..()