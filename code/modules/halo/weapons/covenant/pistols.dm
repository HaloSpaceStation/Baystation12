
/obj/item/weapon/gun/energy/plasmapistol
	name = "Plasma Pistol"
	desc = "A Type 25 Directed Energy Pistol"
	icon = 'code/modules/halo/icons/Covenant Weapons.dmi'
	icon_state = "Plasma Pistol"
	slot_flags = SLOT_BELT||SLOT_HOLSTER
	fire_sound = 'code/modules/halo/sounds/haloplasmapistol.ogg'
	fire_sound_text = "plasma bolt"
	charge_meter = 0
	self_recharge = 1
	max_shots = 20
	projectile_type = /obj/item/projectile/covenant/plasmapistol


/obj/item/weapon/gun/projectile/needler // Uses "magazines" to reload rather than inbuild cells.
	name = "Needler"
	desc = "A Type 33 Guided Munitions Launcher"
	icon = 'code/modules/halo/icons/Covenant Weapons.dmi'
	icon_state = "Needler"
	slot_flags = SLOT_BELT||SLOT_HOLSTER
	fire_sound = null // no sound
	magazine_type = /obj/item/ammo_magazine/needles
