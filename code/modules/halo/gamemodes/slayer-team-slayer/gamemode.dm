
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
	var/time_to_next_respawn = 300 //Deciseconds.
	var/respawnwhen
	var/loadouts = list(/datum/slayernormal/)
	var/players = list()
	var/nospawn = list()


/datum/game_mode/slayer/pre_setup()
	. = ..()
	respawnwhen = world.time + time_to_next_respawn
	for(var/obj/effect/spawnpoint/s in world)
		spwnpts += s

/datum/game_mode/slayer/post_setup()
	. = ..()

/datum/game_mode/slayer/proc/newplayer(var/mob/living/carbon/human/h,var/obj/team_overlay)
	var/spwn = list()
	for(var/obj/i in spwnpts)
		var/mob/living/carbon/human/m = locate() in view(5,i)
		if(m)
			if(m.stat != DEAD)
				continue
		else
			if(i.name == h.faction)
				spwn += i.loc
				continue
		if(!spwn) // So we don't get an empty spawnlist. Used as a fallback for FFA
			world << "No Team Spawnpoints found. Falling back to Free For All spawns."
			spwn += i.loc
			continue

	var/location = pick(spwn)
	var/mob/living/carbon/human/p = new /mob/living/carbon/human(location)
	var/l = pick(loadouts)
	new l (p)
	if(team_overlay) // Team overlays don't seem to function.
		var/image/o = p.hud_list[SPECIALROLE_HUD]
		o.icon_state = team_overlay.icon_state
		p.regenerate_icons()
	p.faction = h.faction
	p.real_name = h.real_name
	p.name = p.real_name
	p.ckey = h.ckey
	p.mind.special_role = h.mind.special_role

/datum/game_mode/slayer/proc/promptspawn(var/mob/m)
	if(m.ckey in nospawn) // Used for people who said 'not for this round'
		return
	var/i = input(m,"Spawn as a Slayer Participant?","Slayer Spawn","No") in list("Yes","No","Not for this round")
	if(!m.ckey)
		return
	if(i == "Yes")
		players += m.ckey
		newplayer(m)
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
		respawnwhen = world.time + time_to_next_respawn
		for(var/mob/m in world)
			if(m.ckey)
				if(m.type == /mob/dead/observer) // This is checked first so people can quit playing and observe.
					spawn(0)
						promptspawn(m)
				if(m.type == /mob/new_player) //So we don't ask anyone in the lobby.
					continue
				if(m.stat == DEAD && m.ckey in players) //Autorespawn for dead players
					newplayer(m)

/obj/effect/spawnpoint
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x"
	name = "neutral"//For use by Team Deathmatch spawners. Faction corresponds to team faction eg. "Blue Team","Red Team".

/obj/effect/spawnpoint/red
	name = "Red Team"

/obj/effect/spawnpoint/blue
	name = "Blue Team"

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
	h.equip_to_slot_or_del(new /obj/item/weapon/grenade/frag/m9_hedp,slot_belt)
	qdel(src)//Not needed anymore.

//Notes: Look at insurrection's gamemode to see how to spawn maps not usually included in the dm.

/datum/game_mode/slayer/team
	name = "Team Slayer"
	round_description = "Team Slayer - Fight to the death alongside your team."
	extended_round_description = "Free for all: fight to the death."
	config_tag = "Slayer TDM"
	votable = 1
	var/teams[0]

/datum/game_mode/slayer/team/pre_setup()
	teams += new /datum/slayer/team/red //Team 1
	teams += new /datum/slayer/team/blue // Team 2
	..()

/datum/game_mode/slayer/team/newplayer(var/mob/living/carbon/human/h,var/team_overlay)
	if(h.faction == "neutral")
		var/datum/slayer/team/team1 = teams[1] // TODO: FIX TEAM ASSIGNS
		var/datum/slayer/team/team2 = teams[2]
		if(team1.members.len >= team2.members.len)
			h.faction = team2.name
			team2.members += h.ckey
			team_overlay = team2.team_overlay
		else
			h.faction = team1.name
			team1.members += h.ckey
			team_overlay = team1.team_overlay
	..()

/datum/slayer/team
	var/name = "neutral" //Will also be the faction name.
	var/score = 0
	var/members[0]
	var/team_overlay

/obj/effect/overlay/slayer
	name = "Slayer Team Marker"
	icon = 'icons/mob/hud.dmi'
	layer = 5

/datum/slayer/team/red
	name = "Red Team"
	team_overlay = new /obj/effect/overlay/slayer/redteam

/obj/effect/overlay/slayer/redteam
	name = "Red Team"
	icon_state = "hudinnie"

/datum/slayer/team/blue
	name = "Blue Team"
	team_overlay = new /obj/effect/overlay/slayer/redteam

/obj/effect/overlay/slayer/blueteam
	name = "Blue Team"
	icon_state = "hudheadrevolutionary"
