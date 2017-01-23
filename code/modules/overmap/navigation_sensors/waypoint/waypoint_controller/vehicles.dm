/*
/datum/waypoint_controller/vehicle_scanner/check_waypoint_detectable(var/datum/waypoint/waypoint)
	var/obj/machinery/overmap_vehicle/V = waypoint.sectorsource
	return V.engines_active

/datum/waypoint_controller/vehicle_scanner/locate_new_waypoints()
	for(var/obj/machinery/overmap_vehicle/found_vehicle in range(overmap_range, current_sector))
		if(!all_waypoints.Find(found_vehicle))
			var/datum/waypoint/new_waypoint = new()
			//new_waypoint.curobj = overmap_vehicle		//aha aah, this isnt right
			all_waypoints[found_vehicle] = new_waypoint
			waypoints_hidden.Add(new_waypoint)
*/

/datum/waypoint_controller/proc/add_overmap_vehicles(var/list/vehiclelist)
	for(var/obj/effect/overmapobj/vehicle/overmap_vehicle_obj in vehiclelist)
		add_overmap_vehicle(overmap_vehicle_obj)

/datum/waypoint_controller/proc/add_overmap_vehicle(var/obj/effect/overmapobj/vehicle/overmap_vehicle_obj)

	//dont create a waypoint on ourself!
	if(overmap_vehicle_obj == owner)
		return

	var/datum/waypoint/overmapobj_vehicle/new_waypoint = new()
	new_waypoint.source = overmap_vehicle_obj.overmap_vehicle
	new_waypoint.overmapobj = overmap_vehicle_obj
	//
	all_waypoints.Add(new_waypoint)
	waypoints_by_source[overmap_vehicle_obj] = new_waypoint
	for(var/datum/hud_waypoint_controller/hud_waypoint_controller in listening_huds)
		hud_waypoint_controller.add_waypoint(new_waypoint)

/datum/waypoint_controller/proc/remove_overmap_vehicle(var/obj/effect/overmapobj/vehicle/overmap_vehicle_obj)
	//check if we have a waypoint already
	var/datum/waypoint/overmapobj_vehicle/old_waypoint = waypoints_by_source[overmap_vehicle_obj]
	if(old_waypoint)
		//we do, so let's clear it
		all_waypoints.Remove(old_waypoint)
		waypoints_by_source.Remove(overmap_vehicle_obj)

		//tell listening hud controllers to clear it
		for(var/datum/hud_waypoint_controller/hud_waypoint_controller in listening_huds)
			hud_waypoint_controller.clear_waypoint(old_waypoint)

		qdel(old_waypoint)
		return 1

	return 0
