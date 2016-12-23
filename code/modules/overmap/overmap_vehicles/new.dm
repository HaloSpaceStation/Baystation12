
/obj/machinery/overmap_vehicle/New()

	pixel_transform = init_pixel_transform(src)
	pixel_transform.my_observers = my_observers
	pixel_transform.heading = dir2angle(dir)
	pixel_transform.max_pixel_speed = max_speed

	vehicle_controls = new default_controlscheme_type(src)
	vehicle_controls.move_mode_absolute = 1

	layer += 0.1

	//just have approx 1 atm internal pressure along with a decent supply of air
	internal_atmosphere = new/datum/gas_mixture
	internal_atmosphere.temperature = T20C
	internal_atmosphere.group_multiplier = 1
	var/internal_cells = (bound_width * bound_height) / (32 * 32)
	internal_atmosphere.volume = CELL_VOLUME * internal_cells
	internal_atmosphere.adjust_multi("oxygen", MOLES_O2STANDARD * internal_cells, "carbon_dioxide", 0, "nitrogen", MOLES_N2STANDARD * internal_cells, "phoron", 0)

	//world << "[src] internal pressure: [internal_atmosphere.return_pressure()] kpa"

	overmap_object = new(src)//locate(src.x, src.y, OVERMAP_ZLEVEL)

	var/obj/effect/overmapobj/overmapobj = map_sectors["[src.z]"]
	if(overmapobj)
		overmap_object.loc = overmapobj.loc
	overmap_object.name = src.name
	overmap_object.overmap_vehicle = src
	pixel_transform.my_overmap_object = overmap_object
	//vehicle.overmap_icon_base = overmap_object.icon

	//verbs -= /obj/machinery/overmap_vehicle/verb/disable_cruise

	processing_objects.Add(src)

	waypoint_controller = new(src)
	hud_waypoint_controller = new(src)
	hud_waypoint_controller.expected_screen_width = client_screen_size
	waypoint_controller.add_listening_hud(hud_waypoint_controller)

	var/obj/effect/overmapobj/spawning_sector = map_sectors["[src.z]"]
	if(spawning_sector)
		waypoint_controller.set_current_sector(spawning_sector, src.z)
		//
		spawning_sector.scanner_manager.add_sector_scanner(waypoint_controller)
		spawning_sector.scanner_manager.add_sector_vehicle(src)
		//
		var/obj/effect/zlevelinfo/spawnz = locate("zlevel[src.z]")
		if(spawnz)
			hud_waypoint_controller.enter_new_zlevel(spawnz)
			/*world << "	check1 (success)"
		else
			world << "	check2 (fail)"*/
		/*
		waypoint_controller.set_current_sector(newsector, entryz.z)

		newsector.scanner_manager.add_sector_scanner(waypoint_controller)
		newsector.scanner_manager.add_sector_vehicle(src)

		hud_waypoint_controller.enter_new_zlevel(entryz)
		*/
		/*world << "FINISH SUCCESS"
	else
		world << "FINISH FAIL"*/
/*
	waypoint_controller.set_current_sector(newsector, entryz.z)

	newsector.scanner_manager.add_sector_scanner(waypoint_controller)
	newsector.scanner_manager.add_sector_vehicle(src)

	hud_waypoint_controller.enter_new_zlevel(entryz)
	*/

	if(src.dir != NORTH)
		pixel_transform.turn_to_dir(src.dir, 360)

	hull_remaining = hull_default
	hull_max = hull_default

	component_init_all()

	init_hud_misc()

/*
/obj/machinery/overmap_vehicle/proc/InitComponents()
	//setup component verbs here
	if(thruster)
		if(!thruster.rate)
			thruster.rate = max_speed
		verbs += /datum/overmap_vehicle_component/verb/enable_hover
	//setup component stats in child objs
	*/
