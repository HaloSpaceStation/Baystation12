/obj/vehicle_hud/fuzz
	name = ""
	icon = 'code/modules/overmap/overmap_vehicles/icons/overmap_vehicle_hud.dmi'
	icon_state = "fuzz"
	panel_icon_state = ""
	invisibility = 101
	screen_loc = "15,15"

/obj/vehicle_hud/fuzz/New()
	..()
	var/matrix/M = matrix()
	M.Scale(21,21)
	src.transform = M
