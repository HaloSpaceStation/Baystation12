
/obj/machinery/overmap_vehicle/shuttle/innie
	name = "Combat Shuttle"
	icon = 'innie_combat_shuttle.dmi'
	icon_state = "innie_shuttle"
	bound_width = 544
	bound_height = 864
	iff_faction_broadcast = "Insurrection"
	//num_turfs = 50
	//maglock_strength = 0

	armour = 100
	hull_remaining = 400
	hull_max = 400

/obj/machinery/overmap_vehicle/shuttle/innie/New()

	//grab a temp zlevel and use it to hold our "inside"
	if(!interior)
		interior = overmap_controller.get_virtual_area()

		//load the shuttle map over the top
		maploader.load_onto_turf('maps/shuttle_inniecombat1.dmm', interior.loc)
		//maploader.load_onto_turf('maps/unsc_personnel_shuttle1.dmm', locate(interior.x, interior.y, interior.z))
		interior.map_dimx = 17
		interior.map_dimy = 27

		maglock_strength = 10

	..()
