/obj/vehicle_hud/cycle_airlock_ext
	name = "Cycle airlock to exterior"
	icon_state = "airlock_ext"
	panel_icon_state = "weapon_left"

/obj/vehicle_hud/cycle_airlock_ext/Click(location,control,params)
	my_vehicle.cycle_airlock_exterior()

/obj/vehicle_hud/cycle_airlock_int
	name = "Cycle airlock to interior"
	icon_state = "airlock_int"
	panel_icon_state = "weapon_right"

/obj/vehicle_hud/cycle_airlock_int/Click(location,control,params)
	my_vehicle.cycle_airlock_interior()
