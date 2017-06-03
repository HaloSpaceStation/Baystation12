
/datum/game_mode/slayer
	name = "Slayer"
	round_description = "Free for all"
	extended_round_description = "Free for all fight to the death."
	config_tag = "SlayerFFA"
	end_on_antag_death = 0
	end_on_protag_death = 0
	deny_respawn = 1 //We'll do that ourselves.
	protagonist_faction = null
	var/players = list()
	var/scores = list()
	var/obj/effects/spawnpoint/spwnpts = list()
	var/slayer_maps = list()

/datum/game_mode/slayer/post_setup()
	for(var/mob/m in world)
		players += m.ckey
	for(var/obj/effects/spawnpoint/s in world)
		spwnpts += s
		if(/mob/living in s.loc.contents)
			return 0
		else
			for(var/key in players)
				var/h = new /mob/living/carbon/human(s.loc)
				new /datum/deathmatchnormal(h)
				h.ckey = key

/datum/game_mode/slayer/process()
	sleep(300) // Every 30 seconds.
	for(var/mob/living/carbon/human/m in world)
		if(!m.ckey) // So we don't create new mobs for ckeyless people
			return
		if(m.health <= m.maxHealth*-2)
			var/obj/effects/spawnpoint = pick(spwnpts)
			var/mob/living/carbon/human/h = new /mob/living/carbon/human(spawnpoint.loc)
			h.real_name = m.real_name
			h.name = h.real_name
			h.ckey = m.ckey
			new /datum/deathmatchnormal(h)


/obj/effects/spawnpoint
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x"

/obj/effects/spawnpoint/New()
	invisibility = 100

/datum/deathmatchnormal/New(var/mob/living/carbon/human/h)
	if(!h) //Just in case the person was deleted before this point.
		return
	var/obj/item/weapon/gun/projectile/m6d_magnum/m
	m.magazine_type = /obj/item/ammo_magazine/m127_saphp // To set the ammo type to the less OP one.
	h.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine(h),slot_shoes)
	h.equip_to_slot_or_del(new /obj/item/clothing/under/unsc/odst(h),slot_w_uniform)
	h.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/spartan(h),slot_wear_suit)
	h.equip_to_slot_or_del(new /obj/item/clothing/gloves/combat(h),slot_gloves)
	h.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/spartan(h),slot_head)
	h.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/syndicate(h),slot_wear_mask)
	h.equip_to_slot_or_del(new /obj/item/weapon/tank/emergency_oxygen/unsc(h),slot_r_store)
	h.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/ma5b_ar(h),slot_back)
	h.equip_to_slot_or_del(new m(h),slot_s_store)
	h.equip_to_slot_or_del(new /obj/item/ammo_magazine/m762_ap(h),slot_l_store)
	qdel(src)//Not needed anymore.

//Notes: Look at insurrection's gamemode to see how to spawn maps not usually included in the dm.