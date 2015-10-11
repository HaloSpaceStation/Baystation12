/obj/machinery/power/engine/electric
	name = "Shaw-Fujikawa Drive"
	desc = "Moves the ship, stay clear"
	icon = 'icons/obj/engine2.dmi'
	icon_state = "Still_Off"
	var/on = 1
	var/theta = 0
	var/r = 1
	var/dx
	var/dy
	var/ship

/obj/machinery/power/engine/electric/initialize()
	ship = map_sectors["[z]"]
	if(ship && istype(ship, /obj/effect/map/ship)
		testing("SF Drive at level [z] has linked to ship object [ship.name]")
	else
		testing("SF Drive at level [z] unable to find overmap object!")