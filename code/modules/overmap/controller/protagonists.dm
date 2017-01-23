
//once round is started, decide the 'protagonist' ship or station for gamemode purposes
//the gamemode code will determine if and what the antagonist home is
/hook/roundstart/proc/locate_protagonist_home()
	for(var/obj/effect/overmapobj/omapobj in world)

		//if this overmapobj matches the protagonist faction, it must be the protagonist home
		if(omapobj.faction == overmap_controller.protagonist_faction)
			overmap_controller.protagonist_home = omapobj

			//prioritise ships over stations
			if(istype(overmap_controller.protagonist_home, /obj/effect/zlevelinfo/ship))
				break

	if(overmap_controller.protagonist_home)
		log_debug("Protagonist home is [overmap_controller.protagonist_home]")
		station_name = overmap_controller.protagonist_home.name
		station_short = station_name
	else
		world << "<span class='warning'>Unable to locate protagonist home!</span>"

	return 1
