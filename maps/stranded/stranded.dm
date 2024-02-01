#if !defined(using_map_DATUM)

	//gamemode
	#include "../_gamemodes/firefight/_all_includes.dm"

	//overmap define
	#include "../desert_outpost/desert_outpost_overmap.dm"
	#include "../desert_outpost/desert_outpost_map.dm"

	//lobby music
	#include "../../code/modules/halo/lobby_music/halo_music.dm"

	//subtype
	#include "../_gamemodes/firefight/subtypes/stranded.dm"
	#include "../_gamemodes/firefight/subtypes/jobs_colonist.dm"
	#include "../_gamemodes/firefight/subtypes/jobs_unsc.dm"

	//map def
	#include "map.dm"

	//map turfs
	#include "../desert_outpost/areas.dm"

	//map
//	#include "../desert_outpost/desert_outpost_old.dmm"
	#include "../desert_outpost/desert_outpost2.dmm"
	#include "../desert_outpost/desert_outpost1.dmm"

	#define using_map_DATUM /datum/map/stranded_desert_outpost

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Stranded: Desert Outpost

#endif
