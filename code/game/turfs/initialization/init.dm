/datum/turf_initializer/proc/initialize(var/turf/T)
	return

/area
	var/datum/turf_initializer/turf_initializer = null

/area/initialize()
	set background = 1
	..()
	for(var/turf/simulated/T in src)
		T.initialize()
		if(turf_initializer)
			turf_initializer.initialize(T)
