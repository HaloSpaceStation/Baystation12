
//Move the unsc backup base to nullspace.
/obj/effect/overmap/complex046/Initialize()
	. = ..()
	loc = null

/obj/effect/overmap/ship/covenant_light_cruiser
	occupy_range = 2
	has_external_dropship_points = 0
	alpha = 0
	is_boardable = 0
	mouse_opacity = 0

/obj/effect/overmap/ship/unscDoO
	occupy_range = 2
	has_external_dropship_points = 0
	alpha = 0
	is_boardable = 0
	mouse_opacity = 0
