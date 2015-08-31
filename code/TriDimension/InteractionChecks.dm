
//------------------------------------------------------
// Cross-z interaction checks
//------------------------------------------------------

/turf/proc/ztransit_enabled(var/checkdir)
	if(checkdir & UP)
		return ztransit_enabled_up()
	if(checkdir & DOWN)
		return ztransit_enabled_down()
	return 0

//Check turf above
/turf/proc/ztransit_enabled_up()
	return check_ztransit_up(src.z)

/proc/check_ztransit_up(var/curZ)
	if(curZ == 1)
		return 0

	while(z_transit_enabled.len < curZ)
		z_transit_enabled.Add(0)

	if(!z_transit_enabled[curZ])
		return 0

	return z_transit_enabled[curZ - 1]


//Check turf below
/turf/proc/ztransit_enabled_down()
	return check_ztransit_down(src.z)

/proc/check_ztransit_down(var/curZ)
	while(z_transit_enabled.len < curZ)
		z_transit_enabled.Add(0)

	if(!z_transit_enabled[curZ])
		return 0

	if(curZ == z_transit_enabled.len)
		return 0

	return z_transit_enabled[curZ + 1]
