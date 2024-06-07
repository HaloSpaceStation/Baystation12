
#define BOMB_DELAY 10 MINUTES

/obj/structure/invasion_bombspawner
	name = "Explosives Requisition Device"
	desc = "Utilises fine-tuned slipspace technology to bring important mission objectives back to"
	icon = 'code/modules/halo/machinery/ship_scanning_console.dmi'
	icon_state = "covie_console"
	density = 1
	anchored = 1
	var/next_bomb_at
	var/bomb_type = /obj/payload/covenant
	var/obj/payload/stored_bomb
	var/turf/spawn_at

/obj/structure/invasion_bombspawner/Initialize()
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/invasion_bombspawner/LateInitialize()
	START_PROCESSING(SSobj, src)
	stored_bomb = locate(bomb_type) in dview(7,get_turf(src))
	if(stored_bomb)
		spawn_at = get_turf(stored_bomb)
	else
		spawn_at = get_turf(src)
	next_bomb_at = world.time + BOMB_DELAY
	. = ..()

/obj/structure/invasion_bombspawner/attack_hand(var/mob/user)
	. = ..()
	if(world.time < next_bomb_at)
		to_chat(user,"<span class = 'notice'>[src] is recharging...</span>")
		return
	GLOB.global_announcer.autosay("Slispace signature detected on the Covenant Ship. Looks like they're bringing in a new explosive device.", "HIGHCOMM SIGINT", RADIO_SQUAD, LANGUAGE_ENGLISH)
	GLOB.global_announcer.autosay("Our advance will not be stopped by feeble loss or theft. A new explosive device has been teleported in.", "Covenant Overwatch", RADIO_COV, LANGUAGE_SANGHEILI)
	if(stored_bomb)
		new /obj/effect/knightroll_tp (get_turf(stored_bomb))
		stored_bomb.forceMove(null)
		qdel(stored_bomb)
	new /obj/effect/knightroll_tp (spawn_at)
	stored_bomb = new bomb_type (spawn_at)

/obj/structure/invasion_bombspawner/Process()
	var/datum/gm = ticker.mode
	if(gm)
		STOP_PROCESSING(SSobj, src)
		if(!istype(gm,/datum/game_mode/outer_colonies))
			forceMove(null)
			STOP_PROCESSING(SSobj, src)
			qdel(src)

/obj/structure/invasion_bombspawner/ex_act()
	return

/obj/structure/invasion_bombspawner/bullet_act()
	return

#undef BOMB_DELAY