
/obj/item/clothing/shoes/swat/theta
	name = "Theta Boots"
	desc = "These boots have been inlaced with armor plates to provide far better protection then your normal set of boots. Meant to be worn by the subject of the Project Theta Program."
	armor = list("melee" = 20, "bullet" = 20, "laser" = 30, "energy" = 25, "bomb" = 50, "bio" = 0, "rad" = 0)
	armor_thickness = 5
	species_restricted = list("Theta")

/obj/item/clothing/gloves/guards/theta
	desc = "A prototype pair of synthetic gloves and arm pads reinforced with armor plating. Meant to be worn by the subject of the Project Theta Program."
	name = "Theta Arm Guards"
	armor = list("melee" = 20, "bullet" = 20, "laser" = 20, "energy" = 10, "bomb" = 20, "bio" = 0, "rad" = 0)
	armor_thickness = 5
	species_restricted = list("Theta")

/obj/item/clothing/under/psysuit/theta
	name = "Theta Undersuit"
	desc = "A prototype thick, layered grey undersuit lined with power cables and flexible nano composite plates. This might be the only piece of equipment which is actually better made then what the spartan program has."
	armor = list("melee" = 10, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 10, "bio" = 0, "rad" = 0)
	armor_thickness = 10
	species_restricted = list("Theta")

/obj/item/clothing/suit/space/void/swat/theta
	name = "Theta Armor"
	desc = "A prototype heavily armored suit of flexible nano composite materials. It is intended to be worn by the subject of project Theta. Any common soldier should fear the person who wears this armor."
	allowed = list(/obj/item/weapon/gun/energy,/obj/item/device/radio,/obj/item/weapon/reagent_containers/spray/pepper,/obj/item/weapon/gun/projectile,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/weapon/gun/magnetic)
	armor = list("melee" = 65, "bullet" = 65, "laser" = 55, "energy" = 45, "bomb" = 60, "bio" = 0, "rad" = 0)
	armor_thickness = 50
	flags_inv = 29
	slowdown_general = -1
	breach_threshold = 100
	flags_inv = HIDESHOES
	species_restricted = list("Theta")

/obj/item/clothing/head/helmet/space/deathsquad/theta
	name = "Theta Helmet"
	desc = "A prototype Helmet made from flexible high grade metals meant to mimic the spartan armor and for use by the Theta Project subject. Any common soldier should fear the person who is seen wearing this helmet."
	armor = list("melee" = 70, "bullet" = 65, "laser" = 45, "energy" = 30, "bomb" = 50, "bio" = 0, "rad" = 0)
	armor_thickness = 40
	species_restricted = list("Theta")


//Testing out New Gun for Theta Project, may not end up using this.
/obj/item/weapon/gun/projectile/automatic/z8/theta
	name = "MA9"
	desc = "This weapon was designed and funded by anti-UNSC factions as their reaction to the standard MA5B assault rifle. Designed with high accuracy and easy maneuverability in combat situations, it was quickly discontinued because of it's high price range. It is highly versatile being capable of utilizing any and all 7.62 magazines found in the field. If attachments can be found, this carbine is capable of using them. It can be fired one handed with an accuracy penalty."
	icon = 'code/modules/halo/weapons/icons/Weapon Sprites.dmi'
	icon_state = "MA9"
	item_state = "ma5b"
	caliber = "a762"
	w_class = ITEM_SIZE_NORMAL
	burst_delay = 0.5
	wielded_item_state = "ma5b"
	fire_sound = 'code/modules/halo/sounds/MA3firefix.ogg'
	reload_sound = 'code/modules/halo/sounds/MA3reload.ogg'
	origin_tech = list(TECH_COMBAT = 8, TECH_MATERIAL = 5, TECH_ILLEGAL = 4)
	ammo_type = /obj/item/ammo_casing/a762
	magazine_type = /obj/item/ammo_magazine/m762_ap
	allowed_magazines = list(/obj/item/ammo_magazine/c762, /obj/item/ammo_magazine/m762_ap, /obj/item/ammo_magazine/c762)
	item_icons = list(
		slot_l_hand_str = 'code/modules/halo/weapons/icons/Weapon_Inhands_left.dmi',
		slot_r_hand_str = 'code/modules/halo/weapons/icons/Weapon_Inhands_right.dmi',
		)

	firemodes = list(
		list(mode_name="Semiauto", burst=1,    fire_delay=0,    move_delay=null, use_launcher=null, one_hand_penalty=4, burst_accuracy=(1), dispersion=null),
		list(mode_name="3-round bursts", burst=3,    fire_delay=null, move_delay=5,    use_launcher=null, one_hand_penalty=5, burst_accuracy=list(0,0,-1), dispersion=list(0.0, 0.6, 0.8))
		)

	attachment_slots = list("sight","stock","barrel")

/obj/item/weapon/gun/projectile/automatic/z8/theta/update_icon()
	. = ..()
	if(ammo_magazine)
		icon_state = "MA9"
	else
		icon_state = "MA9_unloaded"
	return