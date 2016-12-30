
/datum/waypoint/sector/get_center_turf()
	var/turf/T
	if(source)
		T = atom_center_turf(source)//locate(overmapobj.x + (get_center_pixelx_overmap() / 32), overmapobj.y + (get_center_pixely_overmap() / 32), OVERMAP_ZLEVEL)
	else
		T = locate(coords_x, coords_y, coords_z)

	if(!T)
		world << "[src] [src.type] couldn't locate sector turf with source: [source] (coords_x,coords_y,coords_z):([coords_x],[coords_y],[coords_z])"

	return T
