
#define DEFAULT_OBJECTIVE_LIMIT 3
#define CONSOLE_SPAWN_TAGS list("vt9FacilityUpperConsole","vt9FacilityLowerConsole","vt9FacilityLowerEastConsole","vt9CommsStationConsole","vt9OldAirstripConsole","ks7BarConsole","ks7AerodromeConsole","ks7MarshalConsole","ks7MiningConsole","ks7ResidentialConsole","gemCityhallConsole","gemSlumsNorthConsole","gemSlumsSouthConsole","gemCentralConsole","gemPoliceConsole","glasShuttleConsole","glasMiningshackConsole","glasWarehouseConsole","glasApartmentsConsole","glasFacilityConsole")

#include "objectives\_SC_objectives.dm"

/datum/game_mode/system_conquest
	name = "System Conquest"
	round_description = "Complete a series of randomised objectives to win."
	extended_round_description = "Complete a series of randomised objectives to win. First to three successful completions wins."
	config_tag = "systemconquest"
	votable = 1
	probability = 1
	ship_lockdown_duration = 12 MINUTES

	factions = list(/datum/faction/unsc, /datum/faction/covenant, /datum/faction/insurrection)
	faction_balance = list(/datum/faction/unsc, /datum/faction/covenant, /datum/faction/insurrection)

	var/list/round_end_reasons = list()

	var/list/objective_datums = list(/datum/SC_objective/point_control/attack,/datum/SC_objective/point_control/hold) //Initialised from typepaths to datums at presetup.
	var/list/objectives_completed = list() //Contains gamemode-objective datums. format faction = list of objective datums
	var/datum/SC_objective/active_objective = null
	var/next_objective_at = 0
	var/inter_objective_delay = 3 MINUTES

	//How many to win?
	var/objective_limit = DEFAULT_OBJECTIVE_LIMIT

/datum/game_mode/system_conquest/proc/setup_consoles()
	//Delete all existing consoles, then populate our loot landmarks with consoles to place instead.
	for(var/obj/machinery/computer/capture_node/n in world)
		qdel(n)
	for(var/tag in CONSOLE_SPAWN_TAGS)
		loot_distributor.loot_list["[tag]"] = list(/obj/machinery/computer/capture_node/system_conquest)
	loot_distributor.Process()

/datum/game_mode/system_conquest/pre_setup()
	. = ..()
	//Empty lists for each faction so we don't have to check later down the line.
	for(var/datum/faction/f in factions)
		objectives_completed["[f.name]"] = list()
	for(var/type in objective_datums)
		objective_datums += (new type)
		objective_datums -= type
	setup_consoles()
	next_objective_at = world.time + ship_lockdown_duration - 2 MINUTES
	//Disable all capture points
	for(var/obj/machinery/computer/capture_node/node in world)
		node.objective_secured = 1

/datum/game_mode/system_conquest/proc/assign_objective(var/datum/SC_objective/o)
	o.factions = factions.Copy()
	if(active_objective)
		active_objective.send_removal()
	active_objective = o
	active_objective.send_active()

//See if we have one, and if we don't, randomly get one and assign it.
/datum/game_mode/system_conquest/proc/check_assign_objective(var/ignore_active = 0)
	if(!ignore_active && active_objective)
		return 1
	var/datum/SC_objective/o = pick(objective_datums)
	if(!o.check_objective_valid())
		return 0
	var/datum/SC_objective/new_o = new o.type ()
	assign_objective(new_o)
	return 1

/datum/game_mode/system_conquest/proc/complete_objective()
	var/list/winner_list = objectives_completed["[active_objective.objective_winner]"]
	if(!winner_list)
		log_admin("The gamemode just tried to log a completed objective for the [active_objective.objective_winner] faction, but it's not configured as a valid faction on this gamemode!")
		return
	winner_list += active_objective
	active_objective.send_complete()
	active_objective = null
	next_objective_at = world.time + inter_objective_delay

/datum/game_mode/system_conquest/Process()
	. = ..()
	if(world.time < next_objective_at)
		return
	if(active_objective)
		var/o_check = active_objective.check_completion()
		switch (o_check)
			if(1)
				complete_objective()
			if(-1)
				//Forcibly get another. We failed the last objective.
				check_assign_objective(1)
			else
				//The objective isn't complete yet. See if it wants to prompt for a reminder.
				active_objective.send_reminder()
	else
		check_assign_objective()

/datum/game_mode/system_conquest/proc/get_cumulative_objective_worth(var/faction_name)
	var/list/fac_obj = objectives_completed[faction_name]
	var/cumulative_worth = 0
	for(var/datum/SC_objective/o in fac_obj)
		cumulative_worth += o.objective_worth
	return cumulative_worth

/datum/game_mode/system_conquest/check_finished()

	round_end_reasons = list()
	. = evacuation_controller.round_over()
	if(.)
		round_end_reasons += "an early round end was voted for"
		return .

	for(var/fac in objectives_completed)
		var/cumulative_worth = get_cumulative_objective_worth(fac)
		if(cumulative_worth >= objective_limit)
			round_end_reasons += "[fac] completed [objective_limit] objectives and thus seized control of the system."

	return (round_end_reasons.len)

//Largely stripped from invasion GM
/datum/game_mode/system_conquest/declare_completion()
	if(round_end_reasons.len == 0)
		round_end_reasons += "the round ended early"

	var/announce_text = ""

	announce_text += "<h4>The round ended because "
	announce_text += english_list(round_end_reasons)
	announce_text += "</h4>"

	to_world(announce_text)

	//work out survivors
	var/clients = 0
	var/surviving_total = 0
	var/ghosts = 0
	var/list/survivor_factions = list()

	for(var/mob/M in GLOB.player_list)
		if(M.client)
			clients++
			if(M.stat != DEAD)
				surviving_total++
				if(!M.faction)
					M.faction = "unaligned"
				if(survivor_factions[M.faction])
					survivor_factions[M.faction] += 1
				else
					survivor_factions[M.faction] = 1

			else if(isghost(M))
				ghosts++

	var/text = ""
	if(surviving_total > 0)
		var/list/formatted_survivors = list()
		for(var/faction_name in survivor_factions)
			formatted_survivors.Add("[survivor_factions[faction_name]] [faction_name]")
		text += "<br>There was [english_list(formatted_survivors)] survivor[surviving_total != 1 ? "s" : ""] (<b>[ghosts] ghost[ghosts != 1 ? "s" : ""]</b>)."
	else
		text += "There were <b>no survivors</b> (<b>[ghosts] ghost[ghosts > 1 ? "s" : ""]</b>)."

	text += "<br><br>"

	var/first_place = null
	var/fp_score = 0
	var/second_place = null
	var/sp_score = 0

	for(var/fac in objectives_completed)
		var/cumulative_worth = get_cumulative_objective_worth(fac)
		if(!first_place || fp_score < cumulative_worth)
			second_place = first_place
			sp_score = fp_score
			first_place = fac
			fp_score = cumulative_worth
		text += "<h4>Total [fac] Score: [cumulative_worth] points</h4><br>"

	var/win_ratio = 0
	if(fp_score == sp_score)
		text += "<h2>Tie! [first_place] and [second_place] ([fp_score] points)</h2>"
	else if(fp_score + sp_score <= 0)
		text += "<h2>Stalemate! All factions failed in their objectives.</h2>"
	else
		/*
		//calculate the win type based on whether other faction scored points and how many of the winning faction objectives are completed
		win_ratio = (winning_faction.points) / (all_points + winning_faction.max_points - winning_faction.points)
		*/

		//calculate points based on how many of their own objectives were completed
		win_ratio = fp_score / sp_score

		var/win_type = "Pyrrhic"
		if(win_ratio <= 0.34)
			//this should never or rarely happen
			win_type = "Pyrrhic"
		else if(win_ratio < 0.66)
			win_type = "Minor"
		else if(win_ratio < 0.9)
			win_type = "Moderate"
		else if(win_ratio != 1)
			win_type = "Major"
		else
			win_type = "Supreme"

		text += "<h2>[win_type] [first_place] Victory! ([round(100*win_ratio)]% of objectives)</h2>"
	to_world(text)

	if(clients > 0)
		feedback_set("round_end_clients",clients)
	if(ghosts > 0)
		feedback_set("round_end_ghosts",ghosts)
	if(surviving_total > 0)
		feedback_set("survived_total",surviving_total)

	send2mainirc("A round of [src.name] has ended - [surviving_total] survivor\s, [ghosts] ghost\s.")


	return 0

#undef DEFAULT_OBJECTIVE_LIMIT