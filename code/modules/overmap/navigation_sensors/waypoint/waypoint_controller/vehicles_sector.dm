
/datum/waypoint_controller/proc/add_sector_vehicles(var/list/vehiclelist)
	for(var/obj/machinery/overmap_vehicle/overmap_vehicle in vehiclelist)
		add_sector_vehicle(overmap_vehicle)

/datum/waypoint_controller/proc/add_sector_vehicle(var/obj/machinery/overmap_vehicle/overmap_vehicle)

	//dont create a waypoint on ourself!
	if(overmap_vehicle == owner)
		return

	var/datum/waypoint/sector/vehicle/new_waypoint = new()
	new_waypoint.source = overmap_vehicle
	//new_waypoint.overmapobj = overmap_vehicle.overmap_object
	//
	all_waypoints.Add(new_waypoint)
	waypoints_by_source[overmap_vehicle] = new_waypoint
	for(var/datum/hud_waypoint_controller/hud_waypoint_controller in listening_huds)
		hud_waypoint_controller.add_waypoint(new_waypoint)

/datum/waypoint_controller/proc/remove_sector_vehicle(var/obj/machinery/overmap_vehicle/overmap_vehicle)
	//check if we have a waypoint already
	var/datum/waypoint/sector/vehicle/old_waypoint = waypoints_by_source[overmap_vehicle]
	if(old_waypoint)
		//we do, so let's clear it
		all_waypoints.Remove(old_waypoint)
		waypoints_by_source.Remove(overmap_vehicle)

		//tell listening hud controllers to clear it
		for(var/datum/hud_waypoint_controller/hud_waypoint_controller in listening_huds)
			hud_waypoint_controller.clear_waypoint(old_waypoint)

		qdel(old_waypoint)
		return 1

	return 0
