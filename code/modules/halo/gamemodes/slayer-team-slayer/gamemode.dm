
/datum/game_mode/slayer
	name = "Slayer Free For All"
	round_description = "Free for all: fight to the death."
	extended_round_description = "Free for all: fight to the death."
	config_tag = "Slayer FFA"
	end_on_antag_death = 0
	end_on_protag_death = 0
	deny_respawn = 1 //We'll do that ourselves.
	protagonist_faction = null
	votable = 1
	var/obj/effect/spawnpoint/spwnpts = list()
	var/slayer_maps = list()
	var/time_to_next_respawn = 300 //30 //Time in deciseconds.
	var/respawnwhen
	var/loadouts = list(/datum/slayernormal/)
	var/players = list()
	var/nospawn = list()


/datum/game_mode/slayer/pre_setup()
	respawnwhen = world.time + time_to_next_respawn
	for(var/obj/effect/spawnpoint/s in world)
		spwnpts += s.loc

/datum/game_mode/slayer/post_setup()
	respawnwhen = world.time + time_to_next_respawn
	processing_objects += src // Doesn't seem to normally process. Suggestions for a better way to do this would be appreciated.

/datum/game_mode/slayer/proc/newplayer(var/mob/living/carbon/human/h)
	var/spwn = spwnpts
	for(var/obj/effect/spawnpoint/i in spwnpts)
		for(var/mob/living/carbon/human/m in view(5,i))
			if(m.stat == DEAD || m.stat == UNCONSCIOUS)
				continue
			else
				break
		if(i.faction == h.faction)
			spwn += i
	var/location = pick(spwn)
	var/mob/living/carbon/human/p = new /mob/living/carbon/human(location)
	var/l = pick(loadouts)
	new l (p)
	p.faction = h.faction
	p.real_name = h.real_name
	p.name = p.real_name
	p.ckey = h.ckey

/datum/game_mode/slayer/proc/promptspawn(var/mob/m)
	if(m.ckey in nospawn) // Used for people who said 'not for this round'
		return
	var/i = input(m,"Spawn as a Slayer Participant?","Slayer Spawn","No") in list("Yes","No","Not for this round")
	if(i == "Yes")
		players += m.ckey
		newplayer(m,m.faction)
	if(i == "No")
		if(m.ckey in players)
			players -=m.ckey
			return
		return
	if(i == "Not for this round")
		nospawn += m.ckey
		if(m.ckey in players)
			players -= m.ckey
			return
		return

/datum/game_mode/slayer/process()
	if(world.time >= respawnwhen)
		world << "RESPAWNING"
		respawnwhen += world.time + time_to_next_respawn
		for(var/mob/m in world)
			if(m.ckey)
				if(m.type == /mob/dead/observer) // This is checked first so people can quit playing and observe.
					spawn(0)
						promptspawn(m)
				if(m.type == /mob/new_player) //So we don't ask anyone in the lobby.
					break
				if(m.stat == DEAD && m.ckey in players) //Autorespawn for dead players
					newplayer(m)
					break

/obj/effect/spawnpoint
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x"
	var/faction = "neutral"//For use by Team Deathmatch spawners. Faction corresponds to team faction eg. "Blue Team","Red Team".

/obj/effect/spawnpoint/red
	faction = "Red Team"

/obj/effect/spawnpoint/blue
	faction = "Blue Team"

/obj/effect/spawnpoint/New()
	invisibility = 100

/datum/slayernormal/New(var/mob/living/carbon/human/h) // I did have a single grenade in here, but I think it broke the respawning. Don't know why.
	h.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine(h),slot_shoes)
	h.equip_to_slot_or_del(new /obj/item/clothing/under/unsc/odst(h),slot_w_uniform)
	h.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/spartan(h),slot_wear_suit)
	h.equip_to_slot_or_del(new /obj/item/clothing/gloves/combat(h),slot_gloves)
	h.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/syndicate(h),slot_wear_mask)
	h.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/spartan(h),slot_head)
	h.equip_to_slot_or_del(new /obj/item/weapon/tank/emergency_oxygen/unsc(h),slot_r_store)
	h.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/ma5b_ar(h),slot_back)
	h.equip_to_slot_or_del(new /obj/item/ammo_magazine/m762_ap(h),slot_l_store)
	h.equip_to_slot_or_del(new /obj/item/weapon/gun/projectile/m6d_magnum(h),slot_s_store)
	qdel(src)//Not needed anymore.

//Notes: Look at insurrection's gamemode to see how to spawn maps not usually included in the dm.

/datum/game_mode/slayer/team
	name = "Team Slayer"
	round_description = "Team Slayer - Fight to the death alongside your team."
	extended_round_description = "Free for all: fight to the death."
	config_tag = "Slayer TDM"
	votable = 1
	var/team1[0]
	var/team2[0]

/datum/game_mode/slayer/team/newplayer(var/mob/living/carbon/human/h)
	if(h.faction == "neutral")
		if(team1.len >= team2.len) // Team assignments.
			h.faction = "Red Team"
			team2 += h.ckey
			team1 -= h.ckey
			h <<"Assigned To Red Team"
		else
			h.faction = "Blue Team"
			team1 += h.ckey
			team2 -= h.ckey
			h <<"Assigned To Blue Team"
	..()
