
datum/controller/process/overmap/proc/initialise_overmapobj(var/obj/effect/overmapobj/overmapobj, var/obj/effect/zlevelinfo/data)
	if(overmapobj && data)

		overmapobj.name = data.name
		overmapobj.tag = overmapobj.name
		overmapobj.always_known = data.known

		if(data.icon != 'icons/mob/screen1.dmi')
			overmapobj.icon = data.icon
			overmapobj.icon_state = data.icon_state

		if(data.desc)
			overmapobj.desc = data.desc

		if(data.landing_area)
			overmapobj.shuttle_landing = locate(data.landing_area)

		overmapobj.faction = data.faction

		overmapobj.bound_x = data.init_bounds_margin
		overmapobj.bound_y = data.init_bounds_margin
		//
		overmapobj.bound_width = data.init_bounds_dims
		overmapobj.bound_height = data.init_bounds_dims
		//
		overmapobj.max_turf_dimy = Ceiling(overmapobj.bound_height / 32)
		overmapobj.max_turf_dimx = Ceiling(overmapobj.bound_width / 32)

		//let the overmap object initialise it's stuff
		overmapobj.overmap_init()

		//so no other data overwrites this one
		overmapobj.initialised = 1
