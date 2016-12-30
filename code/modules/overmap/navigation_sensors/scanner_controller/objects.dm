

//Capital Ships

/datum/scanner_manager/proc/add_ship(var/obj/effect/overmapobj/ship/ship)
	all_ships.Add(ship)
	for(var/datum/waypoint_controller/scanner in ship_scanners)
		scanner.add_new_ship(ship)


//Stations

/datum/scanner_manager/proc/add_station(var/obj/effect/overmapobj/station)
	all_stations.Add(station)
	for(var/datum/waypoint_controller/scanner in station_scanners)
		scanner.add_new_station(station)


//Asteroid fields

/datum/scanner_manager/proc/add_asteroidfield(var/datum/asteroidfield/new_field)
	all_asteroidfields.Add(new_field)
	for(var/datum/waypoint_controller/scanner in asteroid_scanners)
		scanner.add_new_asteroidfields(new_field)

/datum/scanner_manager/proc/add_asteroidfields(var/list/asteroid_fields)
	all_asteroidfields.Add(asteroid_fields)
	for(var/datum/waypoint_controller/scanner in asteroid_scanners)
		scanner.add_new_asteroidfields(asteroid_fields)


//Overmap vehicles on the overmap (fighters, shuttles etc)

/datum/scanner_manager/proc/add_overmap_vehicle(var/obj/effect/overmapobj/vehicle/overmap_vehicle_obj)
	overmap_vehicles.Add(overmap_vehicle_obj)
	for(var/datum/waypoint_controller/scanner in overmap_vehicle_scanners)
		scanner.add_overmap_vehicle(overmap_vehicle_obj)

/datum/scanner_manager/proc/remove_overmap_vehicle(var/obj/effect/overmapobj/vehicle/overmap_vehicle_obj)
	if(overmap_vehicles.Remove(overmap_vehicle_obj))
		for(var/datum/waypoint_controller/scanner in overmap_vehicle_scanners)
			scanner.remove_overmap_vehicle(overmap_vehicle_obj)


//Overmap vehicles in a sector (fighters, shuttles etc)

/datum/scanner_manager/proc/add_sector_vehicle(var/obj/machinery/overmap_vehicle/overmap_vehicle)
	//world << "/datum/scanner_manager/proc/add_sector_vehicle([overmap_vehicle])"
	sector_vehicles.Add(overmap_vehicle)
	//world << "	new sector_vehicles.len:[sector_vehicles.len]"
	//world << "	sector_vehicle_scanners.len:[sector_vehicle_scanners.len]"
	for(var/datum/waypoint_controller/scanner in sector_vehicle_scanners)
		//world << "		check1"
		scanner.add_sector_vehicle(overmap_vehicle)

/datum/scanner_manager/proc/remove_sector_vehicle(var/obj/machinery/overmap_vehicle/overmap_vehicle)
	if(sector_vehicles.Remove(overmap_vehicle))
		for(var/datum/waypoint_controller/scanner in sector_vehicle_scanners)
			scanner.remove_sector_vehicle(overmap_vehicle)
