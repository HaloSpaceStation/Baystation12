
/turf/simulated/shuttle/hull
	name = "wall"
	icon = 'icons/turf/shuttle.dmi'
	icon_state = "wall"
	density = 1
	opacity = 1
	var/obj/machinery/overmap_vehicle/shuttle/my_shuttle
	blocks_air = 1

/turf/simulated/shuttle/hull/floor
	name = "floor"
	icon = 'icons/turf/shuttle.dmi'
	icon_state = "floor"
	density = 0
	opacity = 0
	blocks_air = 0

/turf/simulated/shuttle/hull/window
	name = "window"
	icon = 'icons/obj/podwindows.dmi'
	icon_state = "1"
	opacity = 0

//look outside the window
/turf/simulated/shuttle/hull/window/verb/look_outside()
	set name = "Observe outside"
	set category = "Vehicle"
	set src in view(2)

	if(ishuman(usr))
		usr.set_machine(my_shuttle)
		my_shuttle.check_eye(usr)

//handle damage procs

/turf/simulated/shuttle/hull/ex_act(var/severity)
	my_shuttle.ex_act(severity)

/turf/simulated/shuttle/hull/bullet_act(obj/item/projectile/P, def_zone)
	my_shuttle.bullet_act(P, def_zone)

/turf/simulated/shuttle/hull/emp_act(var/severity)
	my_shuttle.emp_act(severity)
