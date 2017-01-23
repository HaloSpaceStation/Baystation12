

//Add scanner for everything

/datum/scanner_manager/proc/add_sector_scanner(var/datum/waypoint_controller/scanner)
	//ship_scanners.Add(scanner)
	//scanner.add_new_ships(all_ships)
	//
	//station_scanners.Add(scanner)
	//scanner.add_new_stations(all_stations)
	//
	//asteroid_scanners.Add(scanner)
	//scanner.add_new_asteroidfields(all_asteroidfields)
	//
	sector_vehicle_scanners.Add(scanner)
	scanner.add_sector_vehicles(sector_vehicles)


//Remove scanner from everything

/datum/scanner_manager/proc/remove_generic_scanner(var/datum/waypoint_controller/scanner)
	ship_scanners.Remove(scanner)
	station_scanners.Remove(scanner)
	asteroid_scanners.Remove(scanner)
	overmap_vehicle_scanners.Remove(scanner)


//Scanners for specific types

/datum/scanner_manager/proc/add_ship_scanner(var/datum/waypoint_controller/scanner)
	ship_scanners.Add(scanner)
	scanner.add_new_ships(all_ships)

/datum/scanner_manager/proc/add_station_scanner(var/datum/waypoint_controller/scanner)
	station_scanners.Add(scanner)
	scanner.add_new_stations(all_stations)

/datum/scanner_manager/proc/add_asteroid_scanner(var/datum/waypoint_controller/scanner)
	asteroid_scanners.Add(scanner)
	scanner.add_new_asteroidfields(all_asteroidfields)

/datum/scanner_manager/proc/add_overmap_vehicle_scanner(var/datum/waypoint_controller/scanner)
	overmap_vehicle_scanners.Add(scanner)
	scanner.add_overmap_vehicles(overmap_vehicles)
