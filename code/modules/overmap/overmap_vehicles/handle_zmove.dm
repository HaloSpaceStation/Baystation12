
//override in children if necessary
/obj/machinery/overmap_vehicle/proc/handle_zmove(var/target_dir)
	//world << "handle_zmove([target_dir])"

	var/list/bumplist = list()
	var/atom/blocking
	var/atom/blocking_other
	var/level_string
	var/target_dir_string
	var/source_string

	if(target_dir > 0)
		//try to move up a level
		level_string = "upper"
		target_dir_string = "upwards"
		source_string = "below"
		target_dir = UP
		//world << "check1"
	else if(target_dir < 0)
		//try to move down a level
		level_string = "lower"
		target_dir_string = "downwards"
		source_string = "above"
		target_dir = DOWN
		//world << "check2"
	else
		//world << "[src]/[usr]/[usr.key] tried to cross zlevels with target_dir:0"
		//world << "check3"
		return

	//make sure there is a level there
	var/obj/effect/zlevelinfo/nextz = GetAboveBelow(src, target_dir)
	if(nextz)
		//world << "check4"
		//make sure we're able to freely move down
		for(var/turf/T in src.locs)
			if(target_dir == DOWN && !istype(T, /turf/space) && !istype(T, /turf/simulated/floor/open))
				blocking = T
				break

			//loop through contents to see if any are blockers
			for(var/atom/movable/A in T)
				if(A == src)
					continue

				if(A.anchored)
					blocking = A
					break
				else
					bumplist.Add(A)

			if(blocking)
				break

			//get the adjacent turf
			var/turf/other_turf = GetAboveBelow(T, target_dir)
			if(target_dir == UP && !istype(other_turf, /turf/space) && !istype(other_turf, /turf/simulated/floor/open))
				blocking_other = other_turf
				break

			//check for any blocking items
			for(var/atom/movable/A in other_turf)
				if(A.anchored)
					blocking_other = A
					break
				else
					bumplist.Add(A)

			if(blocking_other)
				break
	else
		pilot << "<span class='warning'>There is nothing of interest [dir2text(target_dir)] there.</span>"
		return 0

		//world << "check5"

	if(blocking)
		//something on this level is blocking the move
		impact_occupants_major()
		var/viewers_message = "\icon[src] <span class='warning'>[src] bumps into [blocking] while trying to move [target_dir_string].</span>"
		var/occupants_message = "\icon[src] <span class='warning'>You bump into [blocking] while trying to move [target_dir_string].</span>"
		message_viewers(viewers_message, occupants_message)
		//world << "check6"
		return 0
	else if(blocking_other)
		//something on the other level is blocking the move
		impact_occupants_major()
		var/viewers_message = "\icon[src] <span class='warning'>[src] bumps into [blocking_other] on the [level_string] level while trying to move [target_dir_string].</span>"
		var/occupants_message = "\icon[src] <span class='warning'>You bump into [blocking_other] on the [level_string] level while trying to move [target_dir_string].</span>"
		message_viewers(viewers_message, occupants_message)
		//world << "check7"
		return 0

	//success!
	var/turf/newloc = GetAboveBelow(src, target_dir)
	//world << "check8"
	var/viewers_message = "\icon[src] <span class='info'>[src] appears, moving from [source_string].</span>"
	var/occupants_message = "\icon[src] <span class='info'>You move [target_dir_string] to level [newloc.GetLevelNum()]/[src.GetNumLevels()].</span>"
	for(var/atom/movable/A in bumplist)
		viewers_message += "\n	<span class='info'>[A] gets knocked to the side of [src].</span>"
		occupants_message += "\n	<span class='info'>[A] gets knocked to the side of [src].</span>"
		//pick a random edge
		var/bumpdir = pick(cardinal)
		switch(bumpdir)
			if(NORTH)
				A.y = src.y + 1 + bound_height / 32
			if(SOUTH)
				A.y = src.y - 1 - bound_height / 32
			if(EAST)
				A.x = src.x + 1 + bound_width / 32
			if(WEST)
				A.x = src.x - 1 - bound_width / 32

	message_viewers(viewers_message, occupants_message)

	//to the target level
	//world << "changing zlevels with dir [target_dir] newloc: ([newloc.x],[newloc.y],[newloc.z]) oldloc: ([src.x],[src.y],[src.z])"
	src.Move(newloc)
	hud_waypoint_controller.enter_new_zlevel(nextz)

	return 1
