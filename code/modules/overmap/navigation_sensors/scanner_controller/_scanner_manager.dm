
/datum/scanner_manager
	var/obj/effect/overmapobj/my_sector

	var/list/ship_scanners = list()
	var/list/all_ships = list()
	//
	var/list/station_scanners = list()
	var/list/all_stations = list()
	//
	var/list/overmap_vehicle_scanners = list()
	var/list/overmap_vehicles = list()
	//
	var/list/sector_vehicle_scanners = list()
	var/list/sector_vehicles = list()
	//
	var/list/asteroid_scanners = list()
	var/list/all_asteroidfields = list()

/datum/scanner_manager/New(var/obj/effect/overmapobj/owning_sector)
	..()

	my_sector = owning_sector
