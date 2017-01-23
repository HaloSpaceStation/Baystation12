
//override parent proc
/obj/machinery/overmap_vehicle/shuttle/health_update()
	if(hull_remaining < 0)
		hull_remaining = 0		//so it doesn't trigger more than once

		//halt all movement
		move_dir = 0
		turn_dir = 0
		autobraking = 0
		pixel_transform.brake(pixel_transform.max_pixel_speed + 1)
		overmap_object.pixel_transform.brake(overmap_object.pixel_transform.max_pixel_speed + 1)

		//make sure our interior is in the real world
		init_maglock(forced = 1)

		shuttle_area.apc = null
		shuttle_area.power_light = 0
		shuttle_area.power_equip = 0
		shuttle_area.power_environ = 0

		shuttle_area.power_change()

		//disable update loop
		src.loc = null

		//loop over turfs and destroy or damage them
		var/list/apcs = list()
		for(var/turf/simulated/shuttle/hull/H in shuttle_area)

			//apply explosion damage to the contents
			for(var/atom/movable/M in H)
				if(istype(M, /obj/machinery/power/apc))
					apcs.Add(M)
				/*if(istype(H, /obj/machinery/computer))
					var/obj/machinery/computer/C = H
					C.set_broken()*/
				M.ex_act(3)

			//check if it's got a roof
			var/turf/above = GetAbove(H)
			if(above && istype(above, /turf/simulated/shuttle/hull))
				var/turf/simulated/shuttle/hull/R = above

				//if this roof is part of our shuttle, replace it with open space
				if(R.my_shuttle == src)
					R.ChangeTurf(/turf/simulated/floor/plating)
					R.ex_act(3)

			//simulate an explosion for the basic turfs
			if(!H.opacity)
				if(!H.density)
					//floors
					H.ChangeTurf(/turf/simulated/floor/tiled)
					H.ex_act(pick(2,3))
				else
					//windows
					H.ChangeTurf(/turf/simulated/floor/tiled)
					H.ex_act(pick(2,3))
					var/obj/structure/window/reinforced/W = new(H)
					W.ex_act(3)

			else if(H.density)
				//walls
				H.ChangeTurf(/turf/simulated/wall)
				H.ex_act(3)

		//just delete any engines, they're only props
		for(var/obj/structure/shuttle/engine/E in shuttle_area)
			qdel(E)

		var/area_name = shuttle_area.name
		qdel(shuttle_area)

		for(var/obj/machinery/power/apc/A in apcs)
			A.name = "[area_name] APC"
			//A.set_broken()

		qdel(src)

		overmap_controller.recycle_virtual_area(interior)

/*
/obj/machinery/overmap_vehicle/shuttle/Destroy()
	..()
*/