
//------------------------------------------------------
// MultiZ 2.0
//------------------------------------------------------

/*
Thanks to Sukasa/Googolplexed for the original code. This implementation has been specifically linked into HS13's overmap

All zlevelinfo with matching names will have their zlevels considered linked across multiz
As long as overmap is setup those zlevels do not have to be adjacent depthwise
Make sure the maps for each zlevel are loaded in the right order (highest to lowest)
Mappers just make sure the maps are next to each other in the map list so they're loaded correctly

Notes: the previous implementation used '11' as down and '12' as up
Remember this in case its important later (byond defines up as 16 and down as 32, i've switched 11 and 12 over to 16 and 32 in most cases)
Disposal pipes state value remains as 11 and 12 because they're not strictly referring to z direction, just 2 unique pipe states which happen to be up and down
*/

//------------------------------------------------------
// Cross-z interaction checks
//------------------------------------------------------

/*
/proc/HasAboveBelow(var/curZ, var/zdir)
	if(zdir & UP)
		return HasAbove(curZ)
	if(zdir & DOWN)
		return HasBelow(curZ)
*/

/proc/GetAboveBelow(var/atom/atom, var/zdir)
	if(zdir & UP)
		return GetAbove(atom)
	if(zdir & DOWN)
		return GetBelow(atom)

//Check turf above
/*
/proc/HasAbove(var/curZ)
	if(curZ == 1)
		return 0

	var/turf/test_turf = locate(1, 1, curZ)
	if(GetAbove(test_turf))
		return 1
		*/

/proc/GetAbove(var/atom/atom, var/testing = 0)
	var/turf/base_turf = get_turf(atom)
	if(!base_turf)
		return null

	var/obj/effect/zlevelinfo/cur_level = locate("zlevel[base_turf.z]")
	if(cur_level)
		var/curz = base_turf.z - 1
		while(curz > 0)

			var/obj/effect/zlevelinfo/target_level = locate("zlevel[curz]")

			if(target_level && cur_level.name == target_level.name)
				if(testing)
					testing("[cur_level.name]: z[cur_level.z] and z[target_level.z] are connected")
				return locate(base_turf.x, base_turf.y, target_level.z)

			curz -= 1

	//testing("	There is not")
	return null


//Check turf below
/*
/proc/HasBelow(var/curZ)
//proc/check_ztransit_down(var/curZ)
	if(curZ == world.maxz)
		return 0

	var/turf/test_turf = locate(1, 1, curZ)
	if(GetBelow(test_turf))
		return 1
*/

/proc/GetBelow(var/atom/atom, var/testing = 0)
	var/turf/base_turf = get_turf(atom)
	if(!base_turf)
		return null

	//see if there is a linked turf
	var/obj/effect/zlevelinfo/cur_level = locate("zlevel[base_turf.z]")
	if(cur_level)
		var/curz = base_turf.z + 1
		while(curz <= world.maxz)

			var/obj/effect/zlevelinfo/target_level = locate("zlevel[curz]")

			if(target_level && cur_level.name == target_level.name)
				if(testing)
					testing("[cur_level.name]: z[cur_level.z] and z[target_level.z] are connected")
				return locate(base_turf.x, base_turf.y, target_level.z)

			curz += 1

	return null
