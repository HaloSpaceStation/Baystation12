
#define AUTOLIGHT_LIGHTINIT_CAP 500
#define AUTOLIGHT_LIGHTINIT_SLEEPTIME 10
/obj/daylight_mark
	opacity = 0
	mouse_opacity = 0
	invisibility = 61

/obj/daylight_mark/New()
	. = ..()
	set_light(8,8)

/obj/autolight_init
	var/targ_area = null
	var/light_type = /obj/daylight_mark
	var/autolight_chance = 70 //The chance that this autolight actually initialises their lights. For rng night-time.

/obj/autolight_init/Initialize()
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/autolight_init/LateInitialize()
	var/area/found = locate(targ_area)
	var/autolight_fail = 0
	if(!prob(autolight_chance))
		autolight_fail = 1
		found.luminosity = 0
		found.dynamic_lighting = 1
	var/ctr = 0
	for(var/turf/create_at in found.contents)
		if(autolight_fail)
			create_at.lighting_build_overlay()
		else
			var/create_light = 0
			for(var/t in trange(1,create_at))
				var/turf/adj_turf = t
				var/area/adj_turf_area = adj_turf.loc
				if(!istype(adj_turf_area,targ_area) && adj_turf_area.dynamic_lighting != 0)
					create_light = 1
				if(locate(light_type) in adj_turf.contents)
					create_light = 0
					break
			if(create_light)
				new light_type (create_at)
				ctr++
				if(ctr >= AUTOLIGHT_LIGHTINIT_CAP)
					ctr = 0
					sleep(AUTOLIGHT_LIGHTINIT_SLEEPTIME)
	qdel(src)

#undef AUTOLIGHT_LIGHTINIT_CAP
#undef AUTOLIGHT_LIGHTINIT_SLEEPTIME