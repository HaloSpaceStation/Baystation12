/datum/map/stranded_desert_outpost
	name = "Stranded: Desert Outpost"
	full_name = "Stranded gamemode on Desert Outpost map"

	lobby_icon = 'code/modules/halo/splashworks/title4.jpg'
	id_hud_icons = 'maps/firefight/hud_icons.dmi'

	path = "stranded_desert_outpost"
	station_levels = list()
	admin_levels = list()
	accessible_z_levels = list()

	boss_name     = "United Nations Space Command"
	company_name  = "United Nations Space Command"
	overmap_size= 5
	overmap_event_tokens = 0

	use_overmap = 1
	allowed_gamemodes = list("stranded")
	allowed_jobs = list(\
		/datum/job/unsc/marine/firefight,\
		/datum/job/unsc/marine/squad_leader/firefight,\
		/datum/job/unsc/odst/firefight,\
		/datum/job/unsc/odst/squad_leader/firefight,\
		/datum/job/unsc/spartan_two/firefight,\
		/datum/job/colonist/firefight)
