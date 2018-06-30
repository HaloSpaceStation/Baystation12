//code for spawn points for midway
GLOBAL_LIST_EMPTY(midway_spawns)

/datum/spawnpoint/midway_spawn
	display_name = "Midway Medical"
	restrict_job = list("Medical Ship Captain, Medical Ship Crew")
	msg = "has arrived on the ship"

/datum/spawnpoint/midwaymedical/New()
	..()
	turfs = GLOB.midway_spawns

/obj/effect/landmark/start/midwaymedical/midway_cap
	name = "Midway Medical - Captain"

/obj/effect/landmark/start/midwaymedical/midway_crew
	name = "Midway Medical - Crew"

/obj/effect/landmark/start/midwaymedical/midway_crew/New()
	..()
	GLOB.midway_spawns += loc

//Job Defines Code
/datum/job/medical_ship_captain
	title = "Medical Ship Captain"
	total_positions = 1
	spawn_positions = 1
	access = list(access_medical, access_engine, access_eva, access_all_personal_lockers, access_maint_tunnels, access_bar, access_janitor, access_construction, access_morgue, access_crematorium, access_kitchen, access_cargo, access_cargo_bot)
	selection_color = "#000000"
	spawnpoint_override = "Midway Captain Spawn"

/datum/job/medical_ship_crew
	title = "Medical Ship Crew"
	total_positions = 4
	spawn_positions = 4
	access = list(access_medical, access_engine, access_eva, access_all_personal_lockers, access_maint_tunnels, access_janitor, access_construction, access_morgue, access_crematorium, access_kitchen, access_cargo, access_cargo_bot)
	selection_color = "#000000"
	spawnpoint_override = "Midway Crew Spawn"
