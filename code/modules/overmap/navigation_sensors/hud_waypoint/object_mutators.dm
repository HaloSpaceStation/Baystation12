
/obj/vehicle_hud/hud_waypoint/proc/set_colour(var/image_colour)
	//apply the colour
	if(image_colour)
		src.color = image_colour
		if(source_image)
			source_image.color = image_colour

/obj/vehicle_hud/hud_waypoint/proc/set_height_underlay(var/height_dir = 0)
	if(height_dir & UP)
		underlays += upper_underlay
		underlays -= lower_underlay
	else if(height_dir & DOWN)
		underlays -= upper_underlay
		underlays += lower_underlay
	else
		underlays -= upper_underlay
		underlays -= lower_underlay

/obj/vehicle_hud/hud_waypoint/proc/get_waypoint_center_turf()
	return waypoint.get_center_turf()
