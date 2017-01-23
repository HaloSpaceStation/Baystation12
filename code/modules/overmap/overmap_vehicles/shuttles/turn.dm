
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
/obj/machinery/overmap_vehicle/shuttle/proc/turn_towards_dir(var/targetdir)
	//world << "turn_towards_dir([newdir])"
	if(targetdir == dir)
		return

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
	var/old_turf_width = round(old_bound_width / 32)
	var/old_turf_height = round(old_bound_height / 32)
	//
	var/new_bound_width = bound_height
	var/new_bound_height = bound_width
	var/new_turf_width = round(new_bound_width / 32)
	var/new_turf_height = round(new_bound_height / 32)

	//first, check if there's anything in the way

	//byond's multitile atom handling is based off the bottom left corner
	//therefore we're going to need to move the shuttle so that it looks like we "rotate" around a central point
	var/turf/old_loc = src.loc
	var/turf/center_turf = locate(src.x + old_turf_width / 2, src.y + old_turf_height / 2, src.z)
	src.loc = locate(center_turf.x - new_turf_width/2, center_turf.y - new_turf_height/2, center_turf.z)

	//now update the bounding box
	bound_width = new_bound_width
	bound_height = new_bound_height

	var/success = 1
	//loop over the covered turfs and see if there will be anything blocking the rotation
	for(var/turf/T in locs)
		if(istype(T, /turf/unsimulated/blocker))
			continue

		if(T.density)
			usr << "\icon[T] <span class='info'>[T] is blocking [src] from rotating in that direction.</span>"
			success = 0
			break
		for(var/atom/movable/A in T)
			if(T.density)
				usr << "\icon[A] <span class='info'>[A] is blocking [src] from rotating in that direction.</span>"
				success = 0
				break

		if(!success)
			break

	//if someone was blocking us, reset everything
	if(!success)
		src.loc = old_loc
		bound_width = old_bound_width
		bound_height = old_bound_height
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

	//let's translate the matrix so it's center is over the bottom left corner of the atom
	M.Translate(-old_bound_width/2, -old_bound_height/2)
	//world << "translating ([-old_bound_width/2],[-old_bound_height/2])"

	//now translate the matrix so the sprite properly aligned with the new bounding box
	M.Translate(new_bound_width/2, new_bound_height/2)
	//world << "translating ([bound_width/2],[bound_height/2])"

	//not sure why this is needed but it seems to work smoothly
	if(dir & (NORTH|SOUTH))
		M.Translate(new_bound_width/2, -new_bound_height/4)

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

	return 1
