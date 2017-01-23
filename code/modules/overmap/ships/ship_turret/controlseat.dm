
//control seat for the turrets
//todo: abstract this away into a datum so that you can control turrets from anything (for AIs, remote hacking etc)

/obj/machinery/overmap_turret_controlseat
	name = "turret control seat"
	desc = "A control station for a shipboard turret."
	anchored = 1
	icon = 'overmap_turrets.dmi'
	icon_state = "human_controlseat"

	var/turret_id
	var/panel_overlay_state = "human_controlseat_overlay"
	var/obj/machinery/overmap_turret/owned_turret
	var/control_range = 7
	var/list/allowed_turret_types = list()

	var/icon/crosshair_icon

/obj/machinery/overmap_turret_controlseat/initialize()
	var/image/I = new('overmap_turrets.dmi', panel_overlay_state)
	I.layer = MOB_LAYER + 0.1
	overlays += I

	reconnect_turret()

/obj/machinery/overmap_turret_controlseat/process()
	//various checks in case we need to shut down control of the turret
	if(!owned_turret)
		processing_objects -= src
		return

	if(!owned_turret.control_mob)
		processing_objects -= src
		return

	if(owned_turret.control_mob.stat || owned_turret.control_mob.paralysis || owned_turret.control_mob.stunned || owned_turret.control_mob.weakened)
		processing_objects -= src
		owned_turret.take_control(null)
		return

/obj/machinery/overmap_turret_controlseat/proc/reconnect_turret()
	//clear out any pre-existing turret
	if(owned_turret)
		if(owned_turret.owned_controller == src)
			owned_turret.owned_controller = null
		owned_turret = null

	//check for any turrets with the same id as us, bypassing type checks
	for(var/obj/machinery/overmap_turret/T in range(control_range, src))
		if(!T.owned_controller && T.turret_id && T.turret_id == src.turret_id)
			T.owned_controller = src
			owned_turret = T
			break

	//just grab the closest turret we can find that's the right type
	var/check_range = 1
	while(!owned_turret && check_range <= control_range)
		for(var/obj/machinery/overmap_turret/T in range(check_range, src))
			if(!T.owned_controller && (!allowed_turret_types.len || (T.type in allowed_turret_types)) )
				T.owned_controller = src
				owned_turret = T
				break
		check_range += 1

/obj/machinery/overmap_turret_controlseat/attack_hand(var/mob/living/M)
	if(istype(M))
		if(owned_turret)
			if(owned_turret.control_mob)
				owned_turret.take_control(null)
			else
				M.set_machine(src)
				owned_turret.take_control(M)
				processing_objects += src

/obj/machinery/overmap_turret_controlseat/check_eye(var/mob/living/M)
	. = -1
	if(M)
		if(owned_turret && owned_turret.control_mob == M)
			if(M.client && M.client.eye == owned_turret.linked)
				. = 0

	if(. == -1 && owned_turret)
		owned_turret.take_control(null)

/obj/machinery/overmap_turret_controlseat/machineClickOn(var/atom/A, var/params)
	if(owned_turret)
		return owned_turret.machineClickOn(A, params)
