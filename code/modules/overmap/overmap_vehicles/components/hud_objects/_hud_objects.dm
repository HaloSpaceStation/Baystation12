/obj/vehicle_hud
	name = ""
	icon = 'code/modules/overmap/overmap_vehicles/icons/overmap_vehicle_hud.dmi'
	icon_state = "blank"
	var/panel_icon_state = "weapon"
	layer = 2
	var/obj/machinery/overmap_vehicle/my_vehicle
	var/obj/structure/vehicle_component/weapon/my_weapon

/obj/vehicle_hud/New(var/obj/machinery/overmap_vehicle/overmap_vehicle, var/obj/structure/vehicle_component/vehicle_component)
	//dont call ..()
	src.loc = vehicle_component
	if(panel_icon_state)
		underlays += panel_icon_state
	if(istype(vehicle_component))
		my_weapon = vehicle_component		//i don give a fuck about types, i'm casting like the world is about to end~
	if(istype(overmap_vehicle))
		my_vehicle = overmap_vehicle
	update_icon()

/obj/vehicle_hud/update_icon()
	//handle the full gamut of visual updates...
	//icon, icon state, overlay and underlay fuckery, maptext, appearance shenaniganery etc
	//override in children so we dont use the parent proc
