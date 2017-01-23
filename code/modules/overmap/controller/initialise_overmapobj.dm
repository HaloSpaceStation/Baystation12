
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

		//so no other data overwrites this one
		overmapobj.initialised = 1
