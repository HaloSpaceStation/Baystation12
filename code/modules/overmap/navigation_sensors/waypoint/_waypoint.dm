
/datum/waypoint
	var/overmap_x = 127
	var/overmap_y = 127
	var/coords_x = 127
	var/coords_y = 127
	var/coords_z = 1			//override this and make sure you update it
	var/obj/effect/overmapobj/overmapobj
	var/atom/movable/source			//overrides coords_x and _y
	var/onscreen_dist = 0
	var/colour_override
	var/sensor_icon_state

	var/dont_update = 0

/datum/waypoint/proc/get_icon()
	return 'code/modules/overmap/overmap_vehicles/icons/overmap_vehicle_hud.dmi'

/datum/waypoint/proc/get_icon_state()
	if(overmapobj)
		return overmapobj.sensor_icon_state

	if(sensor_icon_state)
		return sensor_icon_state

/datum/waypoint/proc/get_icon_state_overmap()
	//override in children

/datum/waypoint/proc/get_faction()
	if(overmapobj)
		return overmapobj.faction

	return "Unknown"

/datum/waypoint/proc/get_source()
	if(source)
		return source

	return get_center_turf()

/datum/waypoint/proc/get_center_turf()
	var/turf/T
	if(overmapobj)
		T = atom_center_turf(overmapobj)//locate(overmapobj.x + (get_center_pixelx_overmap() / 32), overmapobj.y + (get_center_pixely_overmap() / 32), OVERMAP_ZLEVEL)
	else
		T = locate(overmap_x, overmap_y, OVERMAP_ZLEVEL)

	if(!T)
		world << "[src] [src.type] couldn't locate overmap turf with overmapobj: [overmapobj] (overmap_x,overmap_y):([overmap_x],[overmap_y]) OVERMAP_ZLEVEL:[OVERMAP_ZLEVEL]"

	return T

/datum/waypoint/proc/get_zlevel()
	if(source)
		return source.z

	return coords_z

/datum/waypoint/proc/get_heading()
	if(source)
		return dir2angle(source.dir)

	return 0

/datum/waypoint/proc/get_headingdir()
	if(source)
		return source.dir

	return NORTH

/datum/waypoint/proc/get_name()
	if(source)
		return source.name

	if(overmapobj)
		return overmapobj.name

	return "Unknown"

/*
/datum/waypoint/proc/get_source_turf()
	var/turf/T
	if(source)
		T = atom_center_turf(source)//locate(source.x + (get_center_pixelx() / 32), source.y + (get_center_pixely() / 32), source.z)
	/*else
		T = locate(coords_x, coords_y, get_zlevel())*/		//make sure coords_z gets updated or overridden properly, it defaults to 1!
	return T
*/
/*
/datum/waypoint/proc/get_zlevel()

	return 1
*/
