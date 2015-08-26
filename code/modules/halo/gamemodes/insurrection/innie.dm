var/datum/antagonist/innie/innies

/datum/antagonist/innie
	id = MODE_INNIE
	restricted_jobs = list("Cyborg")
	protected_jobs = list("Military Police", "Warden", "Detective", "ONI Agent", "Chief Security Officer", "Captain")
	flags = ANTAG_SUSPICIOUS | ANTAG_RANDSPAWN | ANTAG_VOTABLE
	max_antags = 5 // No upper limit.

	var/list/innie_uniforms = list(
		/obj/item/clothing/under/soviet,
		/obj/item/clothing/under/pirate,
		/obj/item/clothing/under/redcoat,
		/obj/item/clothing/under/serviceoveralls,
		/obj/item/clothing/under/captain_fly,
		/obj/item/clothing/under/det,
		/obj/item/clothing/under/brown,
		)

	var/list/innie_shoes = list(
		/obj/item/clothing/shoes/jackboots,
		/obj/item/clothing/shoes/workboots,
		/obj/item/clothing/shoes/brown,
		/obj/item/clothing/shoes/laceup
		)

	var/list/innie_glasses = list(
		/obj/item/clothing/glasses/thermal,
		/obj/item/clothing/glasses/thermal/plain/eyepatch,
		/obj/item/clothing/glasses/thermal/plain/monocle
		)

	var/list/innie_helmets = list(
		/obj/item/clothing/head/bearpelt,
		/obj/item/clothing/head/ushanka,
		/obj/item/clothing/head/pirate,
		/obj/item/clothing/head/bandana,
		/obj/item/clothing/head/hgpiratecap,
		)

	var/list/innie_suits = list(
		/obj/item/clothing/suit/pirate,
		/obj/item/clothing/suit/hgpirate,
		/obj/item/clothing/suit/storage/toggle/bomber,
		/obj/item/clothing/suit/storage/leather_jacket,
		/obj/item/clothing/suit/storage/toggle/brown_jacket,
		/obj/item/clothing/suit/storage/toggle/hoodie,
		/obj/item/clothing/suit/storage/toggle/hoodie/black,
		/obj/item/clothing/suit/unathi/mantle,
		/obj/item/clothing/suit/poncho,
		)

	var/list/innie_guns = list(
		/obj/item/weapon/gun/energy/laser,
		/obj/item/weapon/gun/energy/retro,
		/obj/item/weapon/gun/energy/xray,
		/obj/item/weapon/gun/energy/mindflayer,
		/obj/item/weapon/gun/energy/toxgun,
		/obj/item/weapon/gun/energy/stunrevolver,
		/obj/item/weapon/gun/energy/ionrifle,
		/obj/item/weapon/gun/energy/taser,
		/obj/item/weapon/gun/energy/crossbow/largecrossbow,
		/obj/item/weapon/gun/launcher/crossbow,
		/obj/item/weapon/gun/launcher/grenade,
		/obj/item/weapon/gun/launcher/pneumatic,
		/obj/item/weapon/gun/projectile/automatic/mini_uzi,
		/obj/item/weapon/gun/projectile/automatic/c20r,
		/obj/item/weapon/gun/projectile/automatic/wt550,
		/obj/item/weapon/gun/projectile/automatic/sts35,
		/obj/item/weapon/gun/projectile/silenced,
		/obj/item/weapon/gun/projectile/shotgun/pump,
		/obj/item/weapon/gun/projectile/shotgun/pump/combat,
		/obj/item/weapon/gun/projectile/shotgun/doublebarrel,
		/obj/item/weapon/gun/projectile/shotgun/doublebarrel/pellet,
		/obj/item/weapon/gun/projectile/shotgun/doublebarrel/sawn,
		/obj/item/weapon/gun/projectile/colt,
		/obj/item/weapon/gun/projectile/sec,
		/obj/item/weapon/gun/projectile/pistol,
		/obj/item/weapon/gun/projectile/revolver,
		/obj/item/weapon/gun/projectile/pirate
		)

	var/list/innie_holster = list(
		/obj/item/clothing/accessory/holster/armpit,
		/obj/item/clothing/accessory/holster/waist,
		/obj/item/clothing/accessory/holster/hip
		)





/datum/antagonist/innie/New()
	..()
	innies = src

/datum/antagonist/innie/equip(var/mob/living/carbon/human/player)

	var/new_shoes =   pick(innie_shoes)
	var/new_uniform = pick(innie_uniforms)
	var/new_glasses = pick(innie_glasses)
	var/new_helmet =  pick(innie_helmets)
	var/new_suit =    pick(innie_suits)
	var/new_gun =    pick(innie_guns)

	player.equip_to_slot_or_del(new new_shoes(player),slot_shoes)
	player.equip_to_slot_or_del(new new_uniform(player),slot_w_uniform)
	player.equip_to_slot_or_del(new new_glasses(player),slot_glasses)
	player.equip_to_slot_or_del(new new_helmet(player),slot_head)
	player.equip_to_slot_or_del(new new_suit(player),slot_wear_suit)
