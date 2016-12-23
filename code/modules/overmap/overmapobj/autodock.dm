
/obj/effect/overmapobj
	var/list/autopilot_routes = list()

/obj/effect/overmapobj/proc/add_route_beacon(var/obj/machinery/autopilot_beacon/new_beacon)
	//check if there is a route already we can slot this beacon into
	autopilot_routes[new_beacon.route_name] = new_beacon
	/*var/list/autopilot_route = autopilot_routes[new_beacon.route_id]
	if(autopilot_route)
		//lets loop through the route and find out where it goes
		var/success = 0
		for(var/index = 1, index <= autopilot_route.len, index++)
			var/obj/machinery/autopilot_beacon/autopilot_beacon = autopilot_route[index]
			if(autopilot_beacon.route_id > new_beacon.route_id)
				//ok, it goes here
				autopilot_route.Insert(index, new_beacon)
				success = 1
				break

		if(!success)
			//oh well add it to the end
			autopilot_route.Add(new_beacon)
	else
		//this route does not exist yet, so lets create it
		autopilot_route = list(new_beacon)
		autopilot_routes[new_beacon.route_id] = autopilot_route

	new_beacon.my_route = autopilot_route*/
/*
/obj/effect/overmapobj/verb/autodock()
	set name = "Autodock strike craft..."
	set src in view(9)
	set category = "Overmap"

	var/list/valid_routes = autopilot_routes | list("Cancel")
	var/target_route_name = input(usr, "Enter route ID name", "Pick route") in valid_routes
	var/list/target_route = autopilot_routes[target_route_name]
	if(!target_route)
		testing("WARNING: autodock failed invalid route \'[target_route_name]\'")
		//usr << "<span class='warning'>Warning: Unable to locate dock route \'[route_name]\'</span>"
		return

	//this is the beginning of a control interaction interface for ships on overmap
	//lets try and make it nicer later if we can
	var/obj/machinery/overmap_vehicle/overmap_vehicle
	if(istype(usr:machine, /obj/machinery/overmap_vehicle))
		overmap_vehicle = usr:machine
	else if(istype(usr:machine, /obj/machinery/computer/shuttle_helm))
		var/obj/machinery/computer/shuttle_helm/H = usr:machine
		overmap_vehicle = H.my_shuttle

	if(overmap_vehicle)
		//set the target autodock route
		overmap_vehicle.current_dock_route = target_route

		//set the starting zlevel when we enter the sector
		//todo: this might be a bit exploitative? seems fine for now, ask me about it later when we have a ~metagame~
		var/obj/machinery/autopilot_beacon/starting_beacon = target_route[1]
		overmap_vehicle.target_entry_level = locate("zlevel[starting_beacon.z]")
		/*var/obj/machinery/autopilot_beacon/starting_beacon = V.current_dock_route[1]

		//for testing, just jump straight to the ship and start running through it
		var/obj/effect/overmapobj/current_sector = map_sectors["[V.z]"]
		var/obj/effect/overmapobj/target_sector = src

		V.leaving_sector(current_sector, target_sector)
		var/obj/effect/zlevelinfo/entry_level = locate("zlevel[starting_beacon.z]")
		var/turf/dest = locate(nx, ny, entry_level.z)
		if(dest)
			A.loc = dest
		V.enter_new_sector(target_sector, entry_level)*/
	else
		usr << "<span class='warning'>ERROR: usr:machine validation check failed in /obj/effect/overmapobj/ship/verb/autodock() (must be piloting an overmapvehicle)</span>"
*/