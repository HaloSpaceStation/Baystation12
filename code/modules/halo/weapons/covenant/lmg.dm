
/obj/item/weapon/gun/energy/plasmarepeater
	name = "Type-51 Directed Energy Rifle"
	desc = "Also known as the \"Plasma Repeater\", this weapon fires long bursts of superheated plasma. A unique ventilation and cooling system gives it a reversed dispersion and accuracy profile."
	icon = 'code/modules/halo/weapons/icons/Covenant Weapons.dmi'
	icon_state = "plasmarepeater"
	item_state = "repeater"
	w_class = ITEM_SIZE_HUGE
	fire_sound = 'code/modules/halo/sounds/plasma_repeater_fire.ogg'
	projectile_type = /obj/item/projectile/bullet/covenant/plasmarepeater
	slot_flags = SLOT_BACK
	one_hand_penalty = -1
	max_shots = 500
	charge_meter = 0
	dispersion = list(0.2, 0.2, 0.2, 0.2, 0.3, 0.3, 0.3, 0.3, 0.4, 0.4, 0.4, 0.5)
	w_class = ITEM_SIZE_HUGE
	slowdown_general = 0.5
	item_icons = list(
		slot_l_hand_str = 'code/modules/halo/weapons/icons/Weapon_Inhands_left.dmi',
		slot_r_hand_str = 'code/modules/halo/weapons/icons/Weapon_Inhands_right.dmi',
		)
	wielded_item_state = "repeater-wielded"
	salvage_components = list(/obj/item/plasma_core = 2)
	matter = list("nanolaminate" = 2)
	hud_bullet_usebar = 1
	overheat_capacity = 121
	overheat_fullclear_delay = 15 SECONDS // Increased to account for high DPS and massive overheat capacity.
	overheat_sfx = 'code/modules/halo/sounds/plasrifle_overheat.ogg'

	burst = 12

	firemodes = list(\
	list(mode_name="short bursts",  burst=12, accuracy=0, dispersion=list(0.2, 0.2, 0.2, 0.2, 0.3, 0.3, 0.3, 0.3, 0.4, 0.4, 0.4, 0.5)),
	list(mode_name="extended bursts", burst=24, accuracy=-1,dispersion=list(0.3, 0.3, 0.3, 0.3, 0.4, 0.4, 0.4, 0.4, 0.5, 0.5, 0.5, 0.6))
	)

/obj/item/weapon/gun/energy/plasmarepeater/proc/cov_plasma_recharge_tick()
	if(max_shots > 0)
		if(power_supply.charge < power_supply.maxcharge)
			power_supply.give(charge_cost*20)
			update_icon()
			return 1