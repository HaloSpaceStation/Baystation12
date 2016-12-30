
//setup other miscellaneous hud elements
/obj/machinery/overmap_vehicle/proc/init_hud_misc()

	//create the fire control panel
	var/obj/vehicle_hud/firecontrolmode/firecontrolmode = new(src)
	firecontrolmode.screen_loc = "13,1"
	misc_hud_objects += firecontrolmode

	//fire selected weapons button
	var/obj/vehicle_hud/fire/fire = new(src)
	fire.screen_loc = "14,1"
	misc_hud_objects += fire
	firecontrolmode.fire_button = fire

	//reload selected weapons button
	var/obj/vehicle_hud/reload_selected/reload_selected = new(src)
	reload_selected.screen_loc = "16,1"
	misc_hud_objects += reload_selected

	//customise system preferences button
	var/obj/vehicle_hud/customise/customise = new(src)
	customise.screen_loc = "[client_screen_size * 2 + 1],1"
	misc_hud_objects += customise

	//switch between sensor modes
	var/obj/vehicle_hud/sensor_overlay_switch/sensor_switch = new(src)
	sensor_switch.screen_loc = "[client_screen_size * 2],1"
	misc_hud_objects += sensor_switch
	misc_hud_objects += sensor_switch.mapfuzz

	//autobrake toggle
	autobrake_button = new(src)
	autobrake_button.screen_loc = "[client_screen_size * 2 - 1],1"
	misc_hud_objects += autobrake_button

	//ship select underlay
	hud_overmap_select = image('code/modules/overmap/overmap_vehicles/icons/overmap_vehicle_hud.dmi', "lockon")
	hud_overmap_select.layer = 2.1
	hud_vehicle_select = image('code/modules/overmap/overmap_vehicles/icons/overmap_vehicle_hud.dmi', "lockon")
	hud_vehicle_select.layer = 2.1
	misc_hud_images += hud_overmap_select
	misc_hud_images += hud_vehicle_select
	//
	deselect_button = new(src)
	deselect_button.screen_loc = "[client_screen_size * 2 - 2],1"
	misc_hud_objects += deselect_button

	//autodocking sequnce
	autodock_button = new(src)
	autodock_button.screen_loc = "[client_screen_size * 2 - 3],1"
	misc_hud_objects += autodock_button

	//observe overmap
	observe_overmap_button = new(src)
	observe_overmap_button.screen_loc = "[client_screen_size * 2 - 4],1"
	misc_hud_objects += observe_overmap_button

	//flood lights
	floodlights = new(src)
	floodlights.screen_loc = "[client_screen_size * 2 - 5],1"
	misc_hud_objects += floodlights

/obj/machinery/overmap_vehicle/proc/get_misc_hud_objects()
	return misc_hud_objects

/obj/machinery/overmap_vehicle/proc/get_misc_hud_images()
	return misc_hud_images
