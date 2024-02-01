/datum/map/stranded_desert_outpost
	name = "Outpost"
	full_name = "Desert Outpost"
	system_name = "Colonized System"

	path = "desert_outpost"
	station_levels = list()
	admin_levels = list()
	accessible_z_levels = list()

	station_name  = "Desert Outpost"
	station_short = "Outpost"
	dock_name     = "Landing Pad"
	boss_name     = "United Nations Space Command"
	boss_short    = "UNSC HIGHCOM"
	company_name  = "United Nations Space Command"
	company_short = "UNSC"
	overmap_size= 5
	overmap_event_tokens = 50

	use_overmap = 1
	allowed_gamemodes = list("stranded")

	area_coherency_test_exempt_areas = list(
		/area/space,
		/area/exoplanet,
		/area/exoplanet/desert,
		/area/exoplanet/grass,
		/area/exoplanet/snow,
	)
