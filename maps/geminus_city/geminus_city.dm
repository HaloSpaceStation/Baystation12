#if !defined(using_map_DATUM)

	#define using_map_DATUM /datum/map/geminus_city

	#include "areas.dm"

	#include "fakewall.dm"
	#include "sewer_tunnel_thin.dm"
	#include "bumpstairs.dm"

	#include "innie_outfits.dm"
	#include "innie_spawns.dm"
	#include "innie_jobs.dm"

	#include "geminus_city_spawns.dm"
	#include "geminus_city_overmap.dm"
	#include "geminus_city_outfits.dm"
	#include "geminus_city_map.dm"
	#include "geminus_city_jobs.dm"

	#include "innie_supply/_controller.dm"
	#include "innie_supply/computer.dm"
	#include "innie_supply/export.dm"
	#include "innie_supply/program.dm"
	#include "innie_supply/shuttle.dm"
	#include "innie_supply/area.dm"

	//#include "geminuscity_4.dmm"
	#include "geminuscity_3.dmm"
	#include "geminuscity_2.dmm"
	#include "geminuscity_1.dmm"
	#include "geminus_innie_base.dmm"

	//#include "geminus_city_jobdefs.dm"
	#include "invasion_geminus.dm"

	//#include "geminuscity_4.dmm"
	#include "geminuscity_3.dmm"
	#include "geminuscity_2.dmm"
	#include "geminuscity_1.dmm"
	#include "geminus_innie_base.dmm"

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring GeminusCity

#endif
