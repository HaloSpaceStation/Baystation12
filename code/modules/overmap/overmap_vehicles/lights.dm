
/obj/machinery/overmap_vehicle/var/lightrange = 10
/obj/machinery/overmap_vehicle/var/lightstrength = 10
/obj/machinery/overmap_vehicle/var/lightcolour = "#ffffff"

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
