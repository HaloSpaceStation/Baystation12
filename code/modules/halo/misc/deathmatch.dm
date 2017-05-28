
/obj/machinery/deathmatch
	name = "Deathmatch Machine"
	desc = "Fight to the death!
	var/mode = "Team Slayer"
	use_power = 0

/obj/machinery/deathmatch/proc/checkmode()
	switch(mode)
		if("Team Slayer")
			return 1
		if("Slayer")
			return 2
		else
			return 0

/obj/machinery/deathmatch/process()
	//for(var/mob/living/carbon/c