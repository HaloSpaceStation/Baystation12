

/obj/machinery/overmap_vehicle
	name = "vehicle"
	desc = "A vehicle"
	//icon = 'longsword_test.dmi'
	//icon_state = "longsword_test0"
	dir = 1
	density = 1
	anchored = 1
	layer = MOB_LAYER

	var/hovering_underlay = "hovering"

	var/list/occupants = list()
	var/occupants_max = 1
	var/move_dir = 0
	var/move_forward = 0
	var/turn_dir = 0
	var/autobraking = 0

	var/mob/living/pilot

	var/iff_faction_broadcast			//set this to a faction
	var/sensor_icon_state = "unknown"	//the icon state for this vehicle on other vehicle's sensors

	var/datum/waypoint_controller/waypoint_controller
	var/datum/hud_waypoint_controller/hud_waypoint_controller

	//var/list/tracking_hud_controllers = list()

	var/obj/effect/overmapobj/vehicle/overmap_object
	var/obj/effect/virtual_area/transit_area

	var/armour = 100
	var/hull_remaining = 100
	var/hull_max = 100
	var/max_speed = 32			//pixels per ms
	var/accel_duration = 10		//how long until max speed in ms
	var/yaw_speed = 5
	var/z_move = 0				//whether the vehicle is moving up or down a level

	var/cruise_speed = 4		//overmap pixels per ms

	var/damage_state = 0
	var/icon/damage_overlay

	var/datum/pixel_transform/pixel_transform

	var/default_controlscheme_type = /datum/vehicle_controls
	var/datum/vehicle_controls/vehicle_controls
	var/datum/gas_mixture/internal_atmosphere

	var/list/my_turrets = list()
	var/list/my_observers = list()

	var/main_update_start_time = -1
	var/update_interval = 1

	var/next_shot_loc = 0

	var/engines_active = 0

	//forward motion on nongravity/space turfs
	//pixels per sec
	/*var/datum/overmap_vehicle_component/thruster = new()
	//turn rate on nongravity/space turfs
	//degrees per sec
	var/datum/overmap_vehicle_component/thruster_turn = new()
	//forward motion on on gravity turfs
	//pixels per sec
	var/datum/overmap_vehicle_component/wheels = new()
	//turn rate on gravity turfs
	//degrees per sec
	var/datum/overmap_vehicle_component/wheels_turn = new()
	//speed in slipspace
	//pixels tiles per sec
	var/datum/overmap_vehicle_component/slipspace = new()
	//main energy generator
	//watts per sec
	var/datum/overmap_vehicle_component/power_gen = new()*/

/obj/machinery/overmap_vehicle/New()
	//InitComponents()

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
	waypoint_controller.add_listening_hud(hud_waypoint_controller)

	var/obj/effect/overmapobj/spawning_sector = map_sectors["[src.z]"]
	if(spawning_sector)
		waypoint_controller.set_current_sector(spawning_sector, src.z)
		//
		spawning_sector.scanner_manager.add_sector_scanner(waypoint_controller)
		spawning_sector.scanner_manager.add_sector_vehicle(src)
		//
		var/obj/effect/zlevelinfo/spawnz = locate("zlevel[src.z]")
		hud_waypoint_controller.enter_new_zlevel(spawnz)

	if(src.dir != NORTH)
		pixel_transform.turn_to_dir(src.dir, 360)

/*
/obj/machinery/overmap_vehicle/proc/InitComponents()
	//setup component verbs here
	if(thruster)
		if(!thruster.rate)
			thruster.rate = max_speed
		verbs += /datum/overmap_vehicle_component/verb/enable_hover
	//setup component stats in child objs
	*/
