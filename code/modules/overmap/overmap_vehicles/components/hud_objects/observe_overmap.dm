
/obj/vehicle_hud/observe_overmap
	name = "Observe Overmap"
	icon_state = "binocs"
	panel_icon_state = "weapon"

/obj/vehicle_hud/observe_overmap/Click(location,control,params)
	//world << "/obj/vehicle_hud/observe_overmap/Click(location,control,params)"
	if(usr.client.eye == my_vehicle.overmap_object)
		my_vehicle.overmap_object.cancel_camera(usr)
		my_vehicle.observe_overmap_button = "binocs"
	else
		my_vehicle.observe_space(usr)
		my_vehicle.observe_overmap_button = "binocs_on"
