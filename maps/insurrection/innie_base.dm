#if !defined(using_map_DATUM)

	#include "insurrection.dm"
	#include "insurrection_items.dm"
	#include "insurrection_outfits.dm"
	#include "insurrection_jobs.dm"
	#include "insurrection_spawns.dm"

	#include "innie_base_areas.dm"
	#include "innie_base2.dmm"
	#include "innie_base1.dmm"
	#include "ODST_staging.dmm"

	#define using_map_DATUM /datum/map/innie_base

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring InnieBase

#endif
