

/obj/machinery/overmap_vehicle
	name = "vehicle"
	desc = "A vehicle"
	//icon = 'longsword_test.dmi'
	//icon_state = "longsword_test0"
	dir = 1
	density = 1
	anchored = 1
	layer = MOB_LAYER + 1.1
	use_power = 0

	var/hovering_underlay = "hovering"
	var/client_screen_size = 14

	var/spawn_dir = 1

	var/list/occupants = list()
	var/occupants_max = 1
	var/move_dir = 0
	var/move_forward = 0
	var/turn_dir = 0
	var/autobraking = 0

	var/mob/living/pilot
	var/obj/structure/vehicle_component/ejector/pilot_ejector_module
	var/obj/structure/vehicle_component/radio/vehicle_radio
	var/obj/structure/vehicle_component/radio_antenna/vehicle_antenna

	var/iff_faction_broadcast			//set this to a faction
	var/sensor_icon_state = "unknown"	//the icon state for this vehicle on other vehicle's sensors

	var/datum/waypoint_controller/waypoint_controller
	var/datum/hud_waypoint_controller/hud_waypoint_controller

	//var/list/tracking_hud_controllers = list()

	var/obj/effect/overmapobj/vehicle/overmap_object
	var/obj/effect/virtual_area/transit_area

	var/obj/effect/zlevelinfo/target_entry_level

	var/armour = 100
	var/hull_remaining = 100
	var/hull_max = 100
	var/hull_default = 100
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
	var/engines_cycling = 0
	var/jitter_x = 0
	var/jitter_y = 0

	var/stealth_baffling = 0
	var/sensor_strength = 0

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

	//these three set which equipment spawns in at creation
	//external mounts are unique mounts whereas internal and crew mounts are interchangeable, so external is handled differently
	var/list/external_loadout = list()
	var/list/internal_loadout = list()
	var/list/crew_loadout = list()

	//nanoui interface for installing and uninstalling components
	var/list/mount_strings = list()
	var/list/mount_sizes = list()
	var/list/mount_types = list()

	var/list/comp_strings = list()
	var/list/comp_status = list()
	var/list/comp_status_req = list()

	var/list/system_mounts = list()
	//
	var/list/component_groups = list()
	var/datum/component_group/sole_selected_group

	//vehicle mounts displayed on each side of the screen
	var/list/hud_bar_left = list()
	var/list/hud_bar_top = list()
	var/list/hud_bar_right = list()

	var/list/selected_components = list()

	//misc hud things
	var/list/misc_hud_objects = list()
	var/list/misc_hud_images = list()		//todo: try and integrate this into some other system
	var/obj/vehicle_hud/autobrake/autobrake_button
	var/fire_control_mode = 0	//0 = single shot, 1 = continuous firing
	var/continue_firing = 0

	hud_type = /datum/hud/vehicle

	//ship select hud elements
	//
	var/obj/machinery/overmap_vehicle/selected_vehicle
	var/obj/effect/overmapobj/selected_overmapobj
	var/image/hud_overmap_select
	var/image/hud_vehicle_select
	//
	var/obj/vehicle_hud/deselect/deselect_button
	var/obj/vehicle_hud/autodock/autodock_button
	var/obj/vehicle_hud/observe_overmap/observe_overmap_button
	var/obj/vehicle_hud/floodlights/floodlights
