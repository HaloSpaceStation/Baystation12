
/obj/item/weapon/tank/oxygen/unsc
	icon_state = "unsc"

/obj/item/weapon/tank/emergency_oxygen/unsc
	icon_state = "unsc_em"

/obj/item/clothing/mask/gas/unsc
	icon_state = "unsc_gasmask"
	item_state = "unsc_gasmask"

/obj/item/weapon/storage/firstaid/erk
	name = "emergency response kit"
	desc = "A hull breach kit for UNSC first responders."
	icon_state = "emergency_response_kit"
	item_state = "firstaid-o2"

	New()
		..()
		if (empty) return

		new /obj/item/weapon/storage/pill_bottle/dexalin(src)
		new /obj/item/weapon/tank/emergency_oxygen/unsc(src)
		new /obj/item/clothing/mask/gas/unsc(src)
		return

/obj/item/weapon/storage/firstaid/erk/eng
	New()
		..()
		if (empty) return

		new /obj/item/weapon/crowbar(src)
		new /obj/item/device/flashlight/unsc(src)
		return


/obj/item/weapon/storage/firstaid/unsc
	name = "UNSC medkit"
	desc = "A general medical kit for UNSC personnel and installations."
	icon_state = "unsc_medkit"
	item_state = "firstaid-unsc"

	New()
		..()
		if (empty) return

		new /obj/item/stack/medical/bruise_pack(src)
		new /obj/item/stack/medical/ointment(src)
		new /obj/item/weapon/storage/pill_bottle/kelotane(src)
		new /obj/item/weapon/storage/pill_bottle/inaprovaline(src)
		new /obj/item/weapon/storage/pill_bottle/bicaridine(src)
		new /obj/item/weapon/storage/pill_bottle/dexalin(src)
		new /obj/item/device/healthanalyzer(src)
		return

/obj/item/device/flashlight/unsc
	name = "UNSC flashlight"
	desc = "Standard issue flashlight for UNSC personnel and installations"
	icon = 'code/modules/halo/misc/halohumanmisc.dmi'
	icon_state = "flashlight"
	item_state = "flashlight-unsc"
