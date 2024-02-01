
/turf/unsimulated/floor/grass9
	name = "grass"
	icon = 'code/modules/halo/turfs/flooring/grass.dmi'
	icon_state = "grass0"

/turf/unsimulated/floor/grass9/New()
	. = ..()
	icon_state = "grass[rand(0,3)]"
