
/datum/waypoint/sector/vehicle/get_icon_state()
	var/obj/machinery/overmap_vehicle/vehicle = source
	if(vehicle)
		return vehicle.sensor_icon_state

	return ..()

/datum/waypoint/sector/vehicle/get_faction()
	var/obj/machinery/overmap_vehicle/vehicle = source
	if(vehicle)
		return vehicle.iff_faction_broadcast

	return ..()

/datum/waypoint/sector/vehicle/get_heading()
	var/obj/machinery/overmap_vehicle/vehicle = source
	if(vehicle)
		return vehicle.pixel_transform.heading

	return ..()

/datum/waypoint/sector/vehicle/get_headingdir()
	var/obj/machinery/overmap_vehicle/vehicle = source
	if(vehicle)
		return angle2dir(vehicle.pixel_transform.heading)

	return ..()
