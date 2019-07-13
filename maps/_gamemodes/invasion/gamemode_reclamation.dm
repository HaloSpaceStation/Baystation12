
/datum/game_mode/outer_colonies/reclamation
	name = "Reclamation"
	config_tag = "reclamation"
	round_description = "The Covenant ransack the outer edges of human space for Forerunner artifacts."
	extended_round_description = "The Covenant ransack the outer edges of human space for Forerunner artifacts."
	required_players = 0
	factions = list(/datum/faction/unsc, /datum/faction/covenant, /datum/faction/human_civ)
	overmap_hide = list(/obj/effect/overmap/sector/exo_listen, /obj/effect/overmap/ship/soe_osprey)
	disabled_jobs_types = list(\
		/datum/job/soe_commando,\
		/datum/job/soe_commando_officer,\
		/datum/job/soe_commando_captain,\
		/datum/job/geminus_innie,\
		/datum/job/geminus_innie/officer,\
		/datum/job/geminus_innie/commander,\
		/datum/job/police,\
		/datum/job/police_chief)
