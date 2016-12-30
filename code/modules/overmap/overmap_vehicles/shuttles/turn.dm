
/*/obj/machinery/overmap_vehicle/shuttle/proc/turn_cw()
	turn_vehicle_to_dir(turn(src.dir, -90))

/obj/machinery/overmap_vehicle/shuttle/proc/turn_ccw()
	turn_vehicle_to_dir(turn(src.dir, 90))*/

/obj/machinery/overmap_vehicle/shuttle/handle_auto_turning()
	//world << "/obj/machinery/overmap_vehicle/shuttle/handle_auto_turning() turn_dir:[turn_dir]"
	if(turn_dir)
		if(is_cruising())
			return ..()

		else if(is_maglocked())
			//don't try to turn if maglocked
			turn_dir = 0

		else if(world.time > time_last_maneuvre + maneuvre_cooldown)
			time_last_maneuvre = world.time
			turn_dir = 0
			return turn_towards_dir(turn_dir)

	return 0

//don't just call this proc, it only turns the sprite on the sector map
//make sure you are handling rotation of the other stuff (see proc/turn_towards_dir)
/obj/machinery/overmap_vehicle/shuttle/proc/turn_towards_dir(var/targetdir, var/ignore_blockers = 0)

	//world << "turn_towards_dir([newdir])"
	if(targetdir == dir)
		return 0

	//for some reason, positive angles in byond = ccw while negative angles = cw so invert this value below
	var/turn_angle = -shortest_angle_to_dir(dir2angle(src.dir), targetdir, 90)
	var/newdir = turn(src.dir, turn_angle)

	//now lets check if there is something blocking the way
	//rotating doesn't really work for multitile atoms that are non-square, and shuttles are definitely non-square
	//therefore lets just snap to 90 degree turns (with a short cooldown)
	//later maybe we'll add an animation to it to make it seem smooth

	//save some data we will need later
	var/old_bound_width = bound_width
	var/old_bound_height = bound_height
	//
	var/new_bound_width = bound_height
	var/new_bound_height = bound_width

	//first, check if there's anything in the way

	//byond's multitile atom handling is based off the bottom left corner
	//therefore we're going to need to move the shuttle so that it looks like we "rotate" around a central point
	var/old_turf_width = round(old_bound_width / 32)
	var/old_turf_height = round(old_bound_height / 32)
	//
	//to prevent drifting when turning in a circle
	var/center_x = src.x + Ceiling(old_turf_width / 2)
	var/center_y = src.y + Ceiling(old_turf_height / 2)
	var/turf/center_turf = locate(center_x, center_y, src.z)
	//
	var/new_turf_width = round(new_bound_width / 32)
	var/new_turf_height = round(new_bound_height / 32)
	//
	var/new_x = center_turf.x - new_turf_width/2
	var/new_y = center_turf.y - new_turf_height/2
	var/turf/old_loc = src.loc
	src.loc = locate(new_x, new_y, center_turf.z)		//just turn on left corner for now

	//actually let's not, because any multitile object with even x and/or y dimensions is going to behaviour oddly
	//ss13 players know the code is shit anyway, they wont mind

	//now update the bounding box
	bound_width = new_bound_width
	bound_height = new_bound_height

	//loop over the covered turfs and see if there will be anything blocking the rotation
	if(!ignore_blockers)
		var/list/blockers = list()
		for(var/turf/T in locs)
			if(istype(T, /turf/unsimulated/blocker))
				continue

			//if a turf is dense, it will block our turning circle
			if(T.density)
				blockers.Add(T)
				continue

			//if there's something dense on the turf, just mark it as blocking then keep going
			for(var/atom/movable/A in T)
				if(A == src)
					continue
				if(A.density)
					blockers.Add(T)
					break

		if(blockers.len)
			//inform the player
			usr << "<span class='info'>Some turfs indicated by arrows are blocking [src] from rotating in that direction.</span>"

			//helpful indicator arrows
			var/list/arrows = list()
			for(var/turf/T in blockers)
				var/image/I = image('icons/mob/screen1.dmi', src.loc, "arrow", 11)
				arrows.Add(I)
				//I.color = "#FFCC00"		//light orange
				I.pixel_x = (T.x - src.x) * 32
				I.pixel_y = (T.y - src.y) * 32
				usr << I

			//clear arrows out after a bit
			spawn(20)
				for(var/image/I in arrows)
					qdel(I)

			//if someone was blocking us, reset everything
			//src.loc = old_loc
			bound_width = old_bound_width
			bound_height = old_bound_height

			//reset position and quit
			src.loc = old_loc
			return 0

	//make sure there are no turfs blocking the way
	/*for(var/xoffset = -new_turf_width/2, xoffset < new_turf_width/2, xoffset += 1)
		for(var/yoffset = -2/new_turf_height, yoffset < new_turf_height/2, yoffset += 1)
			var/turf/T = locate(src.x + xoffset, src.y + yoffset, src.z)
			if(T.density)
				usr << "<span class='info'>[T] is blocking [src] from rotating in that direction.</span>"
				return
			for(var/atom/movable/A in T)
				if(T.density)
					usr << "<span class='info'>[A] is blocking [src] from rotating in that direction.</span>"
					return*/

	//matrix transformations are centred while byond's multitile atom handling is based off the bottom left corner
	//this means we'll have to use special handling for the rectangular shuttles
	//note icon/proc/Turn() can't handle non-square items so we have to use matrices here... matrices are faster and (sort of) easier anyway
	var/matrix/M = matrix()
	src.dir = newdir

	//orient the matrix to face the new direction
	M.Turn(dir2angle(newdir))

	//update the pixel transforms with the new orientation and heading
	pixel_transform.heading = dir2angle(newdir)
	overmap_object.transform = M
	overmap_object.pixel_transform.heading = pixel_transform.heading

	if(newdir & (EAST|WEST))
		//let's translate the matrix so it's center is over the bottom left corner of the atom
		//M.Translate(-old_bound_width/2, -old_bound_height/2)
		//world << "translating ([-old_bound_width/2],[-old_bound_height/2])"

		//now translate the matrix so the sprite properly aligned with the new bounding box
		//M.Translate(new_bound_width/2, new_bound_height/2)
		//world << "translating ([bound_width/2],[bound_height/2])"

		//i dont know whats going on with the matrix randomly offsetting the sprite, but this seems to work now 18/6/16
		if(layout_x < 10)
			M.Translate(96,-96)
		else
			M.Translate(16,-16)

	/*
	//not sure why this is needed but it seems to work smoothly
	if(dir & (NORTH|SOUTH))
		M.Translate(new_bound_width/2, -new_bound_height/4)
		*/

	//apply the new transform
	transform = M

	//1 = cw turn, -1 = ccw turn, 0 = mirror ("depthwise" flip)
	src.interior.rotate_contents(turn_angle / 90)

	//reset existing speed and pixel offsets
	src.pixel_transform.pixel_speed_x = 0
	src.pixel_transform.pixel_speed_y = 0

	src.pixel_x = 0
	src.pixel_y = 0

	//objects in motion stay in motion ;P
	if(src.move_dir)
		src.move_dir = newdir

	//testing
	/*while(boundsmarkers.len <= locs.len)
		boundsmarkers.Add(new /obj/effect/boundsmarker(src))
	for(var/i=1, i <= locs.len, i++)
		var/obj/effect/boundsmarker/curmarker = boundsmarkers[i]
		var/turf/T = locs[i]
		curmarker.loc = T*/

	return 1

/obj/machinery/overmap_vehicle/shuttle/var/list/boundsmarkers = list()
/obj/effect/boundsmarker
	name = "boundsmarker"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
