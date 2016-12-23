
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

/obj/machinery/overmap_vehicle/proc/get_misc_hud_objects()
	return misc_hud_objects
