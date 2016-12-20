
/obj/machinery/overmap_vehicle/var/lightrange = 10
/obj/machinery/overmap_vehicle/var/lightstrength = 10
/obj/machinery/overmap_vehicle/var/lightcolour = "#ffffff"

/obj/vehicle_hud/floodlights
	name = "Toggle external floodlights"
	icon_state = "floodlight0"
	panel_icon_state = "weapon"
	var/floodlights_enabled = 0

/obj/vehicle_hud/floodlights/Click(location,control,params)
	floodlights_enabled = !floodlights_enabled
	icon_state = "floodlight[floodlights_enabled]"
	if(floodlights_enabled)
		my_vehicle.set_light(my_vehicle.lightrange, my_vehicle.lightstrength, my_vehicle.lightcolour)
	else
		my_vehicle.set_light(0)

/*
/obj/machinery/overmap_vehicle/verb/enable_floodlights()
	set name = "Enable floodlights"
	set category = "Vehicle"
	set src = usr.loc

	usr << "<span class='info'>You enable vehicle floodlights.</span>"
	set_light(lightrange, lightstrength, lightcolour)
	verbs -= /obj/machinery/overmap_vehicle/verb/enable_floodlights
	verbs += /obj/machinery/overmap_vehicle/proc/disable_floodlights

/obj/machinery/overmap_vehicle/proc/disable_floodlights()
	set name = "Disable floodlights"
	set category = "Vehicle"
	set src = usr.loc

	usr << "<span class='info'>You disable vehicle floodlights.</span>"
	set_light(0)
	verbs -= /obj/machinery/overmap_vehicle/proc/disable_floodlights
	verbs += /obj/machinery/overmap_vehicle/verb/enable_floodlights
*/
