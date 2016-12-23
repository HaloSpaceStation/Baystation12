
/obj/vehicle_hud/autodock
	name = "Autodock with ship or station"
	icon_state = "docking"
	panel_icon_state = "weapon"

/obj/vehicle_hud/autodock/Click(location,control,params)
	my_vehicle.set_autodock()

/obj/machinery/overmap_vehicle/proc/set_autodock()
	/*set name = "Begin autodock sequence..."
	set category = "Vehicle"
	set src = usr.loc*/

	//todo: this is for testing, fix it
	if(!selected_overmapobj)
		usr << "<span class='warning'>You must select (click on) something to dock with first.</span>"
		return

	var/list/available_routes = selected_overmapobj.autopilot_routes
	var/list/select_from = available_routes | list("Cancel")		//please dont name your autodock routes "Cancel" or i will be a sad coder
	var/target_route_name = input(usr, "Enter route ID name", "Pick route") in select_from
	var/obj/machinery/autopilot_beacon/approach_beacon = available_routes[target_route_name]
	if(!approach_beacon)
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
	else if(istype(usr:machine, /obj/effect/overmapobj/vehicle))
		var/obj/effect/overmapobj/vehicle/V = usr:machine
		overmap_vehicle = V.overmap_vehicle
	else
		usr << "<span class='warning'>WARNING: unknown usr:machine [usr:machine] [usr:machine.type]</span>"

	if(overmap_vehicle)
		//set the target autodock route
		overmap_vehicle.docking_route = target_route_name

		//set the starting zlevel when we enter the sector
		//todo: this might be a bit exploitative? seems fine for now, ask me about it later when we have a ~metagame~
		overmap_vehicle.target_entry_level = locate("zlevel[approach_beacon.z]")
		autodock_button.icon_state = "dedocking"

		usr << "\icon[selected_overmapobj] <span class='info'>Docking route \'[target_route_name]\' locked in for [selected_overmapobj]. Navigate your craft into the sector to begin.</span>"

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
