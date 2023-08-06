
/obj/autolight_init/ks7
	targ_area = /area/exo_ice_facility/exterior/autolight
	autolight_chance = 70
	weathers = list(/datum/weather/windy/p10,/datum/weather/ash/p20,/datum/weather/snow/blizzard/p20,/datum/weather/snow/p45)

/area/exo_ice_facility
	name =  "KS7-535 \"New Pompeii\""
	base_turf = /turf/simulated/floor/exoplanet/snow
	has_gravity = 1
	dynamic_lighting = 0

/area/exo_ice_facility/interior
	name = "KS7-535 Interiors"
	requires_power = 0
	dynamic_lighting = 1
	sound_env = SMALL_ENCLOSED

/area/exo_ice_facility/exterior
	dynamic_lighting = 0
	sound_env = RURAL_OPEN

/area/exo_ice_facility/exterior/autolight

/area/exo_ice_facility/exterior/caves
	dynamic_lighting = 1
	icon_state = "blue2"
	sound_env = TUNNEL_ENCLOSED

/area/exo_ice_facility/exterior/caves/underground
	name = "KS7 - Underground"
	requires_power = 0

/area/exo_ice_facility/exterior/caves/volcano
	name = "Volcano"

/area/exo_ice_facility/interior/bar
	name = "KS7 - Shatter Point Bar"

/area/exo_ice_facility/interior/museum_library
	name = "KS7 - Museum / Library"

/area/exo_ice_facility/interior/biodome
	sound_env = LARGE_SOFTFLOOR

/area/exo_ice_facility/interior/biodome/left
	name = "KS7 - Left Biodome"

/area/exo_ice_facility/interior/biodome/right
	name = "KS7 - Right Biodome"

/area/exo_ice_facility/interior/biodome/professional
	name = "KS7 - Hydroponics Biodome"
	sound_env = SMALL_ENCLOSED

/area/exo_ice_facility/interior/biodome/worker_station
	name = "KS7 - Biodome Technicians"
	sound_env = SMALL_ENCLOSED

/area/exo_ice_facility/interior/aerodrome
	name = "KS7 - Aerodrome"
	sound_env = LARGE_ENCLOSED

/area/exo_ice_facility/interior/housing
	name = "KS7 - Housing Block 1"

/area/exo_ice_facility/interior/housing/biodome
	name = "KS7 - Housing Block 2"

/area/exo_ice_facility/interior/housing/lake
	name = "KS7 - Lake House"

/area/exo_ice_facility/interior/police
	name = "KS7 - Police Station"

/area/exo_ice_facility/interior/police/floor2
	name = "KS7 - Police Station Second Floor"

/area/exo_ice_facility/interior/police/floor3
	name = "KS7 - Police Station Basement"

/area/exo_ice_facility/interior/hospital
	name = "KS7 - Hospital"

/area/exo_ice_facility/interior/pharmacy
	name = "KS7 - Pharmacy"

/area/exo_ice_facility/interior/casino
	name = "KS7 - Casino"
	sound_env = MEDIUM_SOFTFLOOR

/area/exo_ice_facility/interior/pirate_camp/left
	name = "KS7 - Pirate Camp Aux Armory"

/area/exo_ice_facility/interior/pirate_camp/right
	name = "KS7 - Pirate Camp"

/area/exo_ice_facility/interior/pirate_camp/armory
	name = "KS7 - Pirate Camp Vault"

/area/exo_ice_facility/interior/organlegger_den
	name = "KS7 - Organlegger's Den"

/area/exo_ice_facility/interior/umbi_west
	name = "KS7 - West Umbilical"

/area/exo_ice_facility/interior/umbi_east
	name = "KS7 - East Umbilical"

/area/exo_ice_facility/interior/radio_shack
	name = "KS7 - Comms Relay Shack"
