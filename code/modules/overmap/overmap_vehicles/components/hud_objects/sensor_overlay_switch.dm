/obj/vehicle_hud/sensor_overlay_switch
	name = "Switch radar mode (currently: floating)"
	icon_state = "radarsides"
	var/obj/vehicle_hud/fuzz/mapfuzz

/obj/vehicle_hud/sensor_overlay_switch/New()
	..()
	mapfuzz = new()

/obj/vehicle_hud/sensor_overlay_switch/Click(location, control, params)
	//my_vehicle.hud_waypoint_controller.use_megamap = !my_vehicle.hud_waypoint_controller.use_megamap
	my_vehicle.hud_waypoint_controller.cycle_sensor_mode()
	my_vehicle.overmap_object.hud_waypoint_controller.cycle_sensor_mode()
	if(my_vehicle.hud_waypoint_controller.use_megamap)
		icon_state = "radarcenter"
		name = "Switch radar mode (currently: megamap)"
		usr << "\icon[my_vehicle] <span class='info'>Switched radar mode to megamap.</span>"
		mapfuzz.invisibility = 0
	else
		icon_state = "radarsides"
		name = "Switch radar mode (currently: floating)"
		usr << "\icon[my_vehicle] <span class='info'>Switched radar mode to floating.</span>"
		mapfuzz.invisibility = 101

	my_vehicle.hud_waypoint_controller.update_overlays()
	my_vehicle.overmap_object.hud_waypoint_controller.update_overlays()
