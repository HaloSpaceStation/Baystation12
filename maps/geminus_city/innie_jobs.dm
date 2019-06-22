
/datum/job/geminus_innie
	title = "Insurrectionist"
	spawn_faction = "Insurrection"
	latejoin_at_spawnpoints = 1
	total_positions = -1
	spawn_positions = -1
	access = list(632)
	outfit_type = /decl/hierarchy/outfit/job/colonist
	selection_color = "#ff0000"
	spawnpoint_override = "Geminus Innie"
	alt_titles = list(\
	"Insurrectionist Ship Crew",
	"Insurrectionist Technician",
	"Insurrectionist Machine Gunner",
	"Insurrectionist Field Medic",
	"Insurrectionist Bartender",
	"Insurrectionist Janitor",
	"Insurrectionist Breacher",
	"Insurrectionist Engineer",
	"Insurrectionist Guard",
	"Insurrectionist Negotiator",
	"Insurrectionist Interrogator",
	"Insurrectionist Tracker",
	"Insurrectionist Trainer",
	"Insurrectionist Bombmaker",
	"Insurrectionist Mechanic",
	"Insurrectionist Pilot",
	"Insurrectionist Marksman",
	"Insurrectionist Trooper",
	"Insurrectionist Smuggler",\
	"Insurrectionist Broker",\
	"Insurrectionist Recruiter",\
	"Insurrectionist Saboteur",\
	"Insurrectionist Infiltrator")

/datum/job/geminus_innie/officer
	title = "Insurrectionist Officer"
	spawn_faction = "Insurrection"
	latejoin_at_spawnpoints = 1
	total_positions = 2
	spawn_positions = 2
	access = list(632)
	selection_color = "#ff0000"
	spawnpoint_override = "Geminus Innie"
	alt_titles = null

/datum/job/geminus_innie/commander
	title = "Insurrectionist Commander"
	department_flag = COM
	spawn_faction = "Insurrection"
	latejoin_at_spawnpoints = 1
	total_positions = 1
	spawn_positions = 1
	access = list(632,633)
	selection_color = "#ff0000"
	spawnpoint_override = "Geminus Innie"
	faction_whitelist = "Insurrection"
	alt_titles = null
