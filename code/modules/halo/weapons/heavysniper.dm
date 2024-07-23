/obj/item/weapon/gun/projectile/heavysniper
	name = "anti-materiel rifle"
	desc = "An outdated bolt-action design capable of firing 14.5mm armour-piercng rounds over a significant range with the assistance of the mounted scope. Commonly found in Insurrectionist arsenals."
	icon_state = "heavysniper"
	item_state = "heavysniper" //sort of placeholder
	wielded_item_state = "heavysniper-wielded" //sort of placeholder
	w_class = ITEM_SIZE_HUGE
	force = 10
	slot_flags = SLOT_BACK
	origin_tech = list(TECH_COMBAT = 8, TECH_MATERIAL = 2, TECH_ILLEGAL = 8)
	caliber = "14.5mmtracerless"
	handle_casings = HOLD_CASINGS
	load_method = SINGLE_CASING
	max_shells = 2
	ammo_type = /obj/item/ammo_casing/m233
	fire_sound = 'code/modules/halo/sounds/anti_material_rifle_fire.ogg'
	one_hand_penalty = -1
	scoped_accuracy = 7
	screen_shake = 0
	fire_delay = 6
	accuracy = -6 //Honestly stop hipfiring snipers damn it
	dispersion = list(0)
	scope_zoom_amount = 8
	min_zoom_amount = 3
	is_scope_variable = 1

	hud_bullet_row_num = 2
	hud_bullet_reffile = 'code/modules/halo/icons/hud_display/hud_bullet_32x16.dmi'
	hud_bullet_iconstate = "sniper"

	crosshair_file = 'code/modules/halo/weapons/icons/dragaim_icon.dmi'

	var/bolt_open = 0

/obj/item/weapon/gun/projectile/heavysniper/update_icon()
	..()
	if(bolt_open)
		icon_state = "[initial(icon_state)]-open"
	else
		icon_state = "[initial(icon_state)]"

/obj/item/weapon/gun/projectile/heavysniper/attack_self(mob/user as mob)
	playsound(src.loc, 'sound/weapons/flipblade.ogg', 50, 1)
	bolt_open = !bolt_open
	if(bolt_open)
		if(chambered)
			to_chat(user, "<span class='notice'>You work the bolt open, ejecting [chambered]!</span>")
			chambered.loc = get_turf(src)
			loaded -= chambered
			chambered = null
		else
			to_chat(user, "<span class='notice'>You work the bolt open.</span>")
	else
		to_chat(user, "<span class='notice'>You work the bolt closed.</span>")
		bolt_open = 0
	add_fingerprint(user)
	update_icon()

/obj/item/weapon/gun/projectile/heavysniper/can_use_when_prone()
	return 1

/obj/item/weapon/gun/projectile/heavysniper/special_check(mob/user)
	if(bolt_open)
		to_chat(user, "<span class='warning'>You can't fire [src] while the bolt is open!</span>")
		return 0
	return ..()

/obj/item/weapon/gun/projectile/heavysniper/load_ammo(var/obj/item/A, mob/user)
	if(!bolt_open)
		return
	..()

/obj/item/weapon/gun/projectile/heavysniper/unload_ammo(mob/user, var/allow_dump=1)
	if(!bolt_open)
		return
	..()

