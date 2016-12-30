
/obj/vehicle_hud/mount_background
	icon = 'code/modules/overmap/overmap_vehicles/icons/mount_background.dmi'
	icon_state = "background"
	panel_icon_state = null
	layer = 1
	var/selected = 0

/obj/vehicle_hud/mount_background/proc/set_status(var/new_stat)
	if(new_stat)
		if(!selected)
			overlays += "select"
			selected = 1
			return 1

	else if(selected)
		selected = 0
		overlays -= "select"
		return 1

	return 0

/obj/vehicle_hud/mount_background/proc/toggle_status()
	if(selected)
		overlays -= "select"
	else
		overlays += "select"
	selected = !selected
