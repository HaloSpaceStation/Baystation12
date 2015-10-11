
//------------------------------------------------------
// MultiZ 2.0
//------------------------------------------------------

/*
Thanks to Sukasa/Googolplexed for the original code.

When loading sectors, all sectors with matching sector_name will be considered part of the same sector
If the maps for each zlevel are loaded out of order however, they will be inaccessable via normal means (ladders, stairs, travelup/traveldown etc)
Mappers just make sure the maps are next to each other in the map list so they're loaded correctly

Notes: the previous implementation used '11' as down and '12' as up
Remember this in case its important later (byond defines up as 16 and down as 32, i've switched 11 and 12 over to 16 and 32 in most cases)
Disposal pipes state value remains as 11 and 12 because they're not strictly referring to z direction, just 2 unique pipe states which happen to be up and down
*/

//------------------------------------------------------
// Cross-z interaction checks
//------------------------------------------------------

/proc/HasAboveBelow(var/curZ, var/zdir)
	if(zdir & UP)
		return HasAbove(curZ)
	if(zdir & DOWN)
		return HasBelow(curZ)

/proc/GetAboveBelow(var/atom/atom, var/zdir)
	if(zdir & UP)
		return GetAbove(atom)
	if(zdir & DOWN)
		return GetBelow(atom)

/*/turf/proc/ztransit_enabled(var/checkdir)
	if(checkdir & UP)
		return ztransit_enabled_up()
	if(checkdir & DOWN)
		return HasBelow(src.z)
	return 0


//Check turf above
/turf/proc/ztransit_enabled_up()
	return check_ztransit_up(src.z)*/

/proc/HasAbove(var/curZ)
//proc/check_ztransit_up(var/curZ)
	if(curZ == 1)
		return 0

	/*
	while(z_transit_enabled.len < curZ)
		z_transit_enabled.Add(0)

	if(!z_transit_enabled[curZ])
		return 0

	return z_transit_enabled[curZ - 1]
	*/

	var/obj/effect/mapinfo/cur_level = locate("sector[curZ]")
	var/obj/effect/mapinfo/target_level = locate("sector[curZ - 1]")

	//check to make sure it exists and its part of the same sector
	if(cur_level && target_level && \
	cur_level.sectorname && target_level.sectorname && \
	cur_level.sectorname == target_level.sectorname)
		return 1

	return 0

proc/GetAbove(var/atom/atom)
	var/turf/turf = get_turf(atom)
	if(!turf)
		return null
	if(HasAbove(turf.z))
		return locate(turf.x, turf.y, turf.z - 1)
	return null


//Check turf below
/*/turf/proc/HasBelow(src.z)
	return check_ztransit_down(src.z)*/

/proc/HasBelow(var/curZ)
//proc/check_ztransit_down(var/curZ)

	/*
	if(!z_transit_enabled[curZ])
		return 0

	if(curZ == z_transit_enabled.len)
		return 0

	return z_transit_enabled[curZ + 1]
	*/

	var/obj/effect/mapinfo/cur_level = locate("sector[curZ]")
	var/obj/effect/mapinfo/target_level = locate("sector[curZ + 1]")

	if(cur_level && target_level && \
	cur_level.sectorname && target_level.sectorname && \
	cur_level.sectorname == target_level.sectorname)
		return 1

	return 0


proc/GetBelow(var/atom/atom)
	var/turf/turf = get_turf(atom)
	if(!turf)
		return null
	if(HasBelow(turf.z))
		return locate(turf.x, turf.y, turf.z + 1)
	return null
