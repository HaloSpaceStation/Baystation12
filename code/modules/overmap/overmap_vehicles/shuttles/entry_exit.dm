


// Door //

/obj/machinery/door/airlock/external/shuttle
	name = "Shuttle Airlock"
	anchored = 1
	var/obj/machinery/overmap_vehicle/shuttle/my_shuttle



// Exit //

/*/obj/structure/shuttle_door/Entered(atom/movable/Obj, atom/OldLoc)
	if(Obj.dir == src.dir && get_dist(src, OldLoc) <= 1)
		spawn(20)
			atom_exit_shuttle(Obj)

	return ..()*/

/obj/machinery/door/airlock/external/shuttle/verb/exit_shuttle()
	set name = "Exit shuttle"
	set category = "Vehicle"
	set src in range(1)

	//only ghosts can exit the shuttle through sealed airlocks
	if(isliving(usr) && density)
		var/turf/turfloc = get_turf(usr)
		if(istype(turfloc, /turf/simulated/shuttle/hull))
			usr << "<span class='warning'>You cannot exit the shuttle when [src] is sealed.</span>"
			return

	atom_exit_shuttle(usr)

/obj/machinery/door/airlock/external/shuttle/proc/atom_exit_shuttle(var/atom/movable/A)
	//always allow exit if we're not maglocked as the shuttle should never be "in" an impassable tile
	if(my_shuttle.loc != my_shuttle.interior.loc)
		if(my_shuttle.is_cruising())
			//this should handle all of the sector detection and placement logic
			overmap_controller.spawn_to_sector(my_shuttle.overmap_object.loc, A, my_shuttle.overmap_object)
		else
			A.loc = my_shuttle.get_external_turf(src)
		if(ismob(A))
			my_shuttle.occupants.Remove(A)



// Entry //

/obj/machinery/overmap_vehicle/shuttle/enter()
	set name = "Enter vehicle"
	set category = "Vehicle"
	set src in range(1)

	atom_enter_shuttle(usr, usr)

//this will allow players to move crates and other large stuff onto shuttles when they're not maglocked
/obj/machinery/overmap_vehicle/shuttle/MouseDrop_T(atom/dropping, mob/user)
	if(istype(dropping, /atom/movable))
		var/atom/movable/A = dropping
		if(!A.anchored)
			if(atom_enter_shuttle(A, user))
				user << "<span class='info'>You load [dropping] onto [src].</span>"
			return

	user << "<span class='info'>You can't load [dropping] onto [src].</span>"

/obj/machinery/overmap_vehicle/shuttle/proc/atom_enter_shuttle(var/atom/movable/AM, var/mob/user)

	if(interior && shuttle_area)
		//get the corresponding internal turf
		var/turf/internal_turf = get_internal_turf(get_turf(AM), src.loc)

		//let's try and find an airlock that's close enough
		for(var/obj/machinery/door/airlock/external/shuttle/D in shuttle_area)

			//find the first "adjacent" door on the inside to enter through
			var/distance = get_dist(D, internal_turf)
			/*spawn(0)
				world << "checking entry [usr] against [src] with dist [distance]"
			spawn(0)
				world << "	[D] ([D.x],[D.y])"
			spawn(0)
				world << "	internal_turf:([internal_turf.x],[internal_turf.y])"*/

			if(distance <= 1)

				//check if there is anything blocking access
				for(var/atom/movable/A in internal_turf)

					if(!A.CanPass(AM, A.loc, height = 1.5))

						//offload the blocking item if we can
						if(!A.anchored)
							if(user)
								user << "\icon[src] <span class='info'>[D] is being obstructed by [A] so you offload it.</span>"
							var/turf/external_turf = get_external_turf(A.loc)
							A.loc = external_turf

						else if(user)
							user << "\icon[src] <span class='info'>Access to [D] is being obstructed by [A]</span>"
						return

				//if it's not blocked we can now enter here so move onto the airlock tile
				AM.loc = internal_turf
				if(ismob(AM))
					occupants.Add(AM)
				return 1

		if(user)
			user << "\icon[src] <span class='info'>There are no accessible airlocks at this point in the hull.</span>"
		return
