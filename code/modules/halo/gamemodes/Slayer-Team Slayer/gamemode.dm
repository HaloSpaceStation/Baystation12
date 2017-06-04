
/datum/game_mode/slayer
	name = "Slayer"
	round_description = "Free for all"
	extended_round_description = "Free for all: fight to the death."
	config_tag = "SlayerFFA"
	end_on_antag_death = 0
	end_on_protag_death = 0
	deny_respawn = 1 //We'll do that ourselves.
	protagonist_faction = null
	var/scores = list()
	var/obj/effects/spawnpoint/spwnpts = list()
	var/slayer_maps = list()
	var/time_to_next_respawn = 30 //Time in seconds.
	var/respawnwhen
	var/loadouts = list(/datum/slayernormal/)


/datum/game_mode/slayer/post_setup()
	sleep(100) //Wait 10 seconds, then start doing things
	respawnwhen = world.time + time_to_next_respawn*10
	for(var/obj/effects/spawnpoint/s in world)
		spwnpts += s.loc
		if(/mob/living in s.loc.contents)
			return 0
		else
			for(var/mob/living/carbon/human/h in world)
				h.ghostize() // We don't want any players right now.
			sleep(10)
			for(var/mob/dead/observer/o in world)
				o.loc = pick(spwnpts) //Move all the ghosts to a spawnpoint.

/datum/game_mode/slayer/proc/newplayer(var/obj/effects/spawnpoint/location,var/mob/living/carbon/human/h)
	var/mob/living/carbon/human/p = new /mob/living/carbon/human(location)
	var/l = pick(loadouts)
	new l (p)
	p.real_name = h.real_name
	p.name = p.real_name
	p.ckey = h.ckey



/datum/game_mode/slayer/process() // This code would be for auto-respawn. Currently not functional.
/*
	if(world.time >= respawnwhen)
		respawnwhen = world.time + time_to_next_respawn*10
		for(var/obj/i in spwnpts)
			if(/mob/living in range(5))
				return
			else
				for(var/mob/dead/observer/o in range(0,i)) //This doesn't seem to work.
					newplayer(i,o)
		for(var/mob/living/carbon/human/m in world)
			if(m.ckey == null) // So we don't create new mobs for ckeyless people
				return
			if(m.stat == 2 )
				var/obj/effects/spawnpoint = pick(spwnpts)
				newplayer(spawnpoint.loc,m)

	else
		return */


/obj/effects/spawnpoint
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x"
	var/nextspawn = 0

/obj/effects/spawnpoint/New()
	invisibility = 61

/obj/effects/spawnpoint/attack_ghost(var/mob/dead/observer/o)
	var/i = input(o,"Spawn?","Slayer Spawn","No")in list("Yes","No")
	if(i == "Yes" && world.time >= nextspawn)
		nextspawn += world.time +300 //Respawn's avaliable every 30 seconds.
		var/mob/living/carbon/human/h = new /mob/living/carbon/human(loc)
		new /datum/slayernormal(h)
		h.real_name = o.real_name
		h.name = h.real_name
		h.ckey = o.ckey
	else
		return

/datum/slayernormal/New(var/mob/living/carbon/human/h)
	var/obj/item/weapon/gun/projectile/m = new /obj/item/weapon/gun/projectile/m6d_magnum(h)
	m.magazine_type = /obj/item/ammo_magazine/m127_saphp // To set the ammo type to the less OP one.
	h.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine(h),slot_shoes)
	h.equip_to_slot_or_del(new /obj/item/clothing/under/unsc/odst(h),slot_w_uniform)
	h.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/spartan(h),slot_wear_suit)
	h.equip_to_slot_or_del(new /obj/item/clothing/gloves/combat(h),slot_gloves)
	h.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/syndicate(h),slot_wear_mask)
	h.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/spartan(h),slot_head)
	h.equip_to_slot_or_del(new /obj/item/weapon/tank/emergency_oxygen/unsc(h),slot_r_store)
	h.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/ma5b_ar(h),slot_back)
	h.equip_to_slot_or_del(new /obj/item/ammo_magazine/m762_ap(h),slot_l_store)
	h.equip_to_slot_or_del(new /obj/item/weapon/grenade/frag/m9_hedp(h),slot_belt)
	h.equip_to_slot_or_del(m,slot_s_store)
	del(src)//Not needed anymore.

//Notes: Look at insurrection's gamemode to see how to spawn maps not usually included in the dm.