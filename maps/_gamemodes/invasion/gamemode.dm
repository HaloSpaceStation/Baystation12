
/datum/game_mode/outer_colonies
	name = "Outer Colonies"
	config_tag = "outer_colonies"
	round_description = "In an outer colony on the edge of human space, an insurrection is brewing. Meanwhile an alien threat lurks in the void."
	extended_round_description = "In an outer colony on the edge of human space, an insurrection is brewing. Meanwhile an alien threat lurks in the void."
	required_players = 15
	probability = 1
	var/faction_safe_time = 10 MINUTES
	var/faction_safe_duration = 10 MINUTES
	var/safe_expire_warning = 0
	var/list/factions = list(/datum/faction/unsc, /datum/faction/covenant, /datum/faction/insurrection, /datum/faction/human_civ)
	var/list/overmap_hide = list()
	var/list/objectives_specific_target = list()
	var/list/objectives_slipspace_affected = list()
	var/list/round_end_reasons = list()

/datum/game_mode/outer_colonies/pre_setup()
	. = ..()

	setup_factions()

	GLOB.innie_factions_controller.begin_processing()

	//hide some faction sectors from factions not playing
	for(var/obj/effect/overmap/S in world)
		if(S.type in overmap_hide)
			if(S && S.map_z_data.len)
				var/obj/effect/landmark/map_data/check_data = S.map_z_data[1]
				S.loc = check_data.loc
			else
				message_admins("GAMEMODE WARNING: Attempted to hide overmap object [S] ([S.type]) but it was not loaded properly.")

	setup_objectives()

	//setup a couple of other objectives
	for(var/datum/faction/F in factions)
		for(var/datum/objective/objective in F.all_objectives)
			if(objective.find_specific_target && !objective.target)
				objectives_specific_target += objective

/datum/game_mode/outer_colonies/proc/setup_factions()
	//setup factions
	for(var/faction_type in factions)
		var/datum/faction/F = GLOB.factions_by_type[faction_type]
		factions.Add(F)

/datum/game_mode/outer_colonies/proc/setup_objectives()

	//setup covenant objectives
	var/list/objective_types = list(\
		/datum/objective/protect_ship/covenant,\
		/datum/objective/protect/covenant_leader,\
		/datum/objective/glass_colony,\
		///datum/objective/retrieve/steal_ai,
		/datum/objective/retrieve/nav_data,\
		/datum/objective/destroy_ship/covenant,
		/datum/objective/destroy_ship/covenant_odp,
		/datum/objective/retrieve/artifact)
	GLOB.COVENANT.setup_faction_objectives(objective_types)
	GLOB.COVENANT.has_flagship = 1

	//setup unsc objectives
	objective_types = list(\
		/datum/objective/protect_ship/unsc,\
		/datum/objective/retrieve/artifact/unsc,\
		/datum/objective/protect/unsc_leader,\
		/datum/objective/capture_innies,\
		/datum/objective/retrieve/steal_ai/cole_protocol,\
		/datum/objective/retrieve/nav_data/cole_protocol,\
		/datum/objective/destroy_ship/unsc,\
		/datum/objective/protect_colony)
	GLOB.UNSC.setup_faction_objectives(objective_types)
	GLOB.UNSC.has_flagship = 1
	GLOB.UNSC.base_desc = "Orbital Defence Platform"

	//setup innie objectives
	objective_types = list(\
		/datum/objective/protect/innie_leader,\
		/datum/objective/destroy_ship/innie,\
		/datum/objective/assassinate/kill_unsc_leader,\
		///datum/objective/recruit_pirates,
		///datum/objective/recruit_scientists,
		/datum/objective/protect_colony/innie)
		///datum/objective/takeover_colony)
	GLOB.INSURRECTION.setup_faction_objectives(objective_types)
	GLOB.INSURRECTION.base_desc = "secret underground base"

	GLOB.HUMAN_CIV.name = "Geminus City"
	GLOB.HUMAN_CIV.base_desc = "human colony"

/datum/game_mode/outer_colonies/handle_latejoin(var/mob/living/carbon/human/character)
	for(var/datum/objective/objective in objectives_specific_target)
		if(objective.check_target(character.mind))
			objectives_specific_target -= objective
	return 1

/datum/game_mode/outer_colonies/post_setup(var/announce = 0)
	. = ..()
	faction_safe_time = world.time + faction_safe_duration

/datum/game_mode/outer_colonies/check_finished()

	round_end_reasons = list()
	. = evacuation_controller.round_over()
	if(.)
		round_end_reasons += "an early round end was voted for"
		return .

	for(var/datum/faction/F in factions)

		//check if flagship destroyed
		if(F.has_flagship)
			var/obj/effect/overmap/flagship = F.get_flagship()
			if(!flagship || !flagship.loc)
				if(F.flagship_slipspaced)
					round_end_reasons += "the [F.name] ship has gone to slipspace and left the system"
					/*var/datum/faction/covenant/C = locate() in factions
					C.ignore_players_dead = 1*/
				else
					round_end_reasons += "the [F.name] ship has been destroyed"

		if(F.has_base)
			var/obj/effect/overmap/base = F.get_base()
			if(base)
				if(base.nuked)
					round_end_reasons += "the [F.name] [F.base_desc] [base.name] has been nuked"
				if(base.glassed)
					round_end_reasons += "the [F.name] [F.base_desc] [base.name] has been glassed"

		/*
		//if all faction players have been killed/captured... only check 1 faction
		if(faction_safe_time - world.time < 2 MINUTES)
			var/safe_expire_warning_check = 0
			if(!F.players_alive() && !F.ignore_players_dead)
				if(world.time >= faction_safe_time)
					round_end_reasons += "the [F.name] presence in the system has been destroyed"
					factions_destroyed++

				else if(!safe_expire_warning)
					safe_expire_warning_check = 1
					message_admins("GAMEMODE WARNING: Faction safe time expiring in 2 minutes and the [F.name] have no living players.")
			if(safe_expire_warning_check)
				safe_expire_warning = 1
				*/

	/*
	var/end_round_triggers = round_end_reasons.len
	//only count 1 destroyed faction towards the end round triggers
	if(factions_destroyed > 0)
		end_round_triggers -= factions_destroyed
		end_round_triggers += 1
		*/

	//if 2 or more end conditions are met, end the game
	return (round_end_reasons.len >= 2)

/datum/game_mode/outer_colonies/declare_completion()

	var/announce_text = ""

	announce_text += "<h4>The round ended because "
	announce_text += english_list(round_end_reasons)
	announce_text += "</h4>"

	to_world(announce_text)

	//work out survivors
	var/clients = 0
	var/surviving_humans = 0
	var/surviving_total = 0
	var/ghosts = 0
	//var/escaped_humans = 0
	//var/escaped_total = 0

	for(var/mob/M in GLOB.player_list)
		if(M.client)
			clients++
			if(M.stat != DEAD)
				surviving_total++
				if(ishuman(M))
					surviving_humans++
				/*var/area/A = get_area(M)
				if(A && is_type_in_list(A, GLOB.using_map.post_round_safe_areas))
					escaped_total++
					if(ishuman(M))
						escaped_humans++*/
			else if(isghost(M))
				ghosts++

	var/text = ""
	if(surviving_total > 0)
		text += "<br>There [surviving_total>1 ? "were <b>[surviving_total] survivors</b>" : "was <b>one survivor</b>"]"
	else
		text += "There were <b>no survivors</b> (<b>[ghosts] ghosts</b>)."

	text += "<br><br>"

	//work out faction points
	var/datum/faction/winning_faction
	var/datum/faction/second_faction
	var/all_points = 0
	for(var/datum/faction/faction in factions)
		text += "<h3>[faction.name] Objectives</h3>"
		if(!winning_faction)
			winning_faction = faction
		else if(!second_faction && winning_faction != faction)
			second_faction = faction
		for(var/datum/objective/objective in faction.all_objectives)
			var/result = objective.check_completion()
			if(result == 1)
				text += "<span class='good'>Completed (+[objective.get_win_points()]): [objective.short_text]</span><br>"
				faction.points += objective.get_win_points()
			else if(result == 2)
				text += "<span class='mixed'>Partially Completed (+[objective.get_win_points()]): [objective.short_text]</span><br>"
				faction.points += objective.get_win_points()
			else if(objective.lose_points)
				text += "<span class='bad'>Failed (-[objective.get_lose_points()]): [objective.short_text]</span><br>"
				faction.points -= objective.get_lose_points()
			else
				text += "<span class='prefix'>Not Completed: [objective.short_text]</span><br>"

		if(faction.points > 0)
			all_points += faction.points
		if(winning_faction != faction && faction.points >= winning_faction.points)		//<= is necessary to correctly track second place
			second_faction = winning_faction
			winning_faction = faction
		text += "<h4>Total [faction.name] Score: [faction.points] points</h4><br>"

	//these victory tiers will need balancing depending on objectives and points
	if(second_faction.points == winning_faction.points)
		text += "<h2>Tie! [winning_faction.name] and [second_faction.name] ([winning_faction.points] points)</h2>"
	else if(all_points <= 0)
		text += "<h2>Stalemate! All factions failed in their objectives.</h2>"
	else
		//check if only the winning faction scored, then treat them slightly differently
		//this rates the victory based on how many objectives are completed... disabling it means victories are only rated compared to other factions
		if(all_points == winning_faction.points)
			all_points = winning_faction.max_points

		var/win_type = "Pyrrhic"
		var/win_ratio = winning_faction.points/all_points
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

		text += "<h2>[win_type] [winning_faction.name] Victory!</h2>"
	to_world(text)

	if(clients > 0)
		feedback_set("round_end_clients",clients)
	if(ghosts > 0)
		feedback_set("round_end_ghosts",ghosts)
	if(surviving_humans > 0)
		feedback_set("survived_human",surviving_humans)
	if(surviving_total > 0)
		feedback_set("survived_total",surviving_total)
	/*if(escaped_humans > 0)
		feedback_set("escaped_human",escaped_humans)
	if(escaped_total > 0)
		feedback_set("escaped_total",escaped_total)*/

	send2mainirc("A round of [src.name] has ended - [surviving_total] survivor\s, [ghosts] ghost\s.")

	return 0

/datum/game_mode/outer_colonies/handle_mob_death(var/mob/M, var/unsc_capture = 0)
	. = ..()

	if(M.mind.assigned_role in list("Insurrectionist","Insurrectionist Commander","Insurrectionist Officer") || M.mind.faction == "Insurrectionist")
		var/datum/faction/unsc/unsc = locate() in factions
		if(unsc)
			var/datum/objective/capture_innies/capture_innies = locate() in unsc.all_objectives
			if(capture_innies)
				if(unsc_capture)
					capture_innies.minds_captured.Add(M.mind)
				else
					capture_innies.minds_killed.Add(M.mind)

	if(M.mind)
		for(var/datum/faction/F in factions)
			if(M.mind in F.assigned_minds)
				F.living_minds -= M.mind
				break

/datum/game_mode/outer_colonies/handle_slipspace_jump(var/obj/effect/overmap/ship/ship)
	var/datum/faction/F = GLOB.factions_by_name[ship.faction]
	if((F && F == F.get_flagship()) || (!F && F.has_flagship))
		//record a round end condition
		F.flagship_slipspaced = 1

		//lock in any covenant objectives now so they arent failed by the ship despawning
		for(var/datum/objective/objective in objectives_slipspace_affected)

			//a 1 here means the objective was successful
			objective.override = objective.check_completion()

			//a 0 means it fails so we set -1 to lock in a 0 result
			if(!objective.override)
				objective.override = -1
