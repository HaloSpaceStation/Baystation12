
//a pocket of 25x25 tiles inside a "pocket" universe
//little bit hacky but it should work nicely to do what i want (flyable shuttles around the main ships)
/obj/effect/virtual_area
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	dir = 1
	invisibility = 101
	var/map_dimx = 0
	var/map_dimy = 0

	var/process_delay = 0
	var/obj/effect/marker
	var/obj/effect/overmapobj/vehicle/overmap_eject_object
	var/list/blockers = list()

/turf/unsimulated/blocker
	name = "blocker"
	icon = 'virtual_area.dmi'
	icon_state = "black"
	density = 1
	opacity = 1
	luminosity = 1
	dynamic_lighting = 0
	var/obj/effect/virtual_area/virtual_area

/datum/controller/process/overmap/var/virtual_area_dims = 28
/datum/controller/process/overmap/var/obj/effect/zlevelinfo/virtual_zlevel
/datum/controller/process/overmap/var/list/virtual_areas_sorted = list()
/datum/controller/process/overmap/var/list/virtual_areas_unused = list()
/datum/controller/process/overmap/var/list/virtual_areas_used = list()
/datum/controller/process/overmap/var/obj/effect/virtual_area/hidden_holding_area

//don't call this more than once until someone writes a proc to reset the entire zlevel
/datum/controller/process/overmap/proc/init_virtual_areas()
	virtual_zlevel = get_or_create_cached_zlevel()
	virtual_zlevel.name = "virtual level (shuttle interiors)"

	//add on 2 for a 2 tile margin on the bottom and left corners of the area
	var/num_per_side = round(255 / (virtual_area_dims + 2))
	for(var/row_num = 1, row_num < num_per_side, row_num++)
		for(var/col_num = 1, col_num < num_per_side, col_num++)
			//add 2 again
			var/obj/effect/virtual_area/new_area = new(locate(1 + (row_num - 1) * virtual_area_dims + 2, 1 + (col_num - 1) * virtual_area_dims + 2, virtual_zlevel.z))
			virtual_areas_sorted.Add(new_area)
			new_area.name = "virtual_area #[virtual_areas_sorted.len] ([row_num],[col_num])"
			new_area.make_area_blockers()

	virtual_areas_unused = virtual_areas_sorted.Copy()

	hidden_holding_area = get_virtual_area()

//make sure you are properly using and clearing the /obj/effect/virtual_area after calling this proc
/datum/controller/process/overmap/proc/get_virtual_area()
	var/obj/effect/virtual_area/new_area
	if(virtual_areas_unused.len)
		new_area = virtual_areas_unused[1]
		virtual_areas_unused -= new_area
		virtual_areas_used += new_area
	return new_area

/datum/controller/process/overmap/proc/recycle_virtual_area(var/obj/effect/virtual_area/old_area)
	virtual_areas_used -= old_area
	virtual_areas_unused += old_area

/obj/effect/virtual_area/proc/get_mapped_turfs()
	var/list/mapped_turfs = list()

	var/maxdims = map_dimx > map_dimy ? map_dimx : map_dimy
	for(var/curx = 0, curx < maxdims, curx++)
		for(var/cury = 0, cury < maxdims, cury++)
			var/turf/curturf = locate(src.x + curx, src.y + cury, src.z)
			mapped_turfs.Add(curturf)

	return mapped_turfs

/obj/effect/virtual_area/proc/make_area_blockers()
	blockers = list()
	//start at -2 to give a 2 tile margin on the bottom and left edges
	for(var/curx = -2, curx < overmap_controller.virtual_area_dims, curx++)
		for(var/cury = -2, cury < overmap_controller.virtual_area_dims, cury++)
			var/turf/unsimulated/blocker/T = new(locate(src.x + curx, src.y + cury, src.z))
			T.virtual_area = src
			blockers.Add(T)

			//see through unless it's an edge turf
			if(curx == -2 || cury == -2 || curx == overmap_controller.virtual_area_dims || cury == overmap_controller.virtual_area_dims)
				T.opacity = 1
			else
				T.opacity = 0
			T.opacity = 0

/obj/effect/virtual_area/proc/sprite_area_space()
	//start at -2 to give a 2 tile margin on the bottom and left edges
	for(var/curx = -2, curx < overmap_controller.virtual_area_dims, curx++)
		for(var/cury = -2, cury < overmap_controller.virtual_area_dims, cury++)
			var/turf/unsimulated/blocker/T = locate(src.x + curx, src.y + cury, src.z)
			if(istype(T))
				T.icon = 'icons/turf/space.dmi'
				T.icon_state = "[rand(0,25)]"

/obj/effect/virtual_area/proc/sprite_area_dark()
	//start at -2 to give a 2 tile margin on the bottom and left edges
	for(var/curx = -2, curx < overmap_controller.virtual_area_dims, curx++)
		for(var/cury = -2, cury < overmap_controller.virtual_area_dims, cury++)
			var/turf/unsimulated/blocker/T = locate(src.x + curx, src.y + cury, src.z)
			if(istype(T))
				T.icon = 'virtual_area.dmi'
				T.icon_state = "black"

/obj/effect/virtual_area/proc/sprite_area_transit(var/transitdir = "ns")
	//todo: i couldnt get the icon to flip for some reason (using both icon/Flip() and scaling the transform)
	//world << "sprite_area_transit([transitdir])"
	//var/matrix/M = matrix()
	//var/flipdir = 0
	switch(transitdir)
		if("sn")
			//world << "	flipping matrix Y"
			//M.Scale(1, -1)
			//flipdir = NORTH
			transitdir = "ns"
		if("we")
			//world << "	flipping matrix X"
			//M.Scale(-1, 1)
			//flipdir = WEST
			transitdir = "ew"

	//start at -2 to give a 2 tile margin on the bottom and left edges
	for(var/curi = -2, curi < overmap_controller.virtual_area_dims, curi++)
		var/curnum = rand(1, 15)
		for(var/curj = -2, curj < overmap_controller.virtual_area_dims, curj++)
			var/turf/unsimulated/blocker/T
			if(transitdir == "ns")
				T = locate(src.x + curi, src.y + curj, src.z)
			else
				T = locate(src.x + curj, src.y + curi, src.z)
			if(istype(T))
				T.icon = 'icons/turf/space.dmi'
				T.icon_state = "speedspace_[transitdir]_[curnum++]"
				//T.transform = M
				/*if(flipdir)
					var/icon/I = T.icon
					I.Flip(flipdir)
					T.icon = I*/
				if(curnum > 15)
					curnum = 1

//warning: make sure atoms in the contents can handle being rotated
//warning: mirroring is untested and might have a few kinks
//todo: update APC pixel offsets for the new direction
/obj/effect/virtual_area/proc/rotate_contents(var/rotate_direction = -1)
	//get the rotated direction
	var/rotate_angle
	if(rotate_direction < 0)
		//clockwise
		rotate_angle = -90
	else if(rotate_direction > 0)
		//counter-clockwise
		rotate_angle = 90
	else
		//mirrored
		rotate_angle = 180
	var/newdir = turn(dir, rotate_angle)

	//loop over all containing turfs
	if(!marker)
		marker = new(src.loc)
		marker.icon = 'icons/mob/screen1.dmi'
		marker.icon_state = "x"
		marker.layer = 4
		marker.invisibility = 101

	//i tried to figure out a way to do this without 3 loops over all turfs, i really did
	//in the meantime this works soundly and doesn't profile too bad i think
	var/list/interior_turfs = list()
	var/maxdims = map_dimx > map_dimy ? map_dimx : map_dimy
	for(var/curx = 0, curx < maxdims, curx++)
		for(var/cury = 0, cury < maxdims, cury++)

			sleep(process_delay)

			var/turf/curturf = locate(src.x + curx, src.y + cury, src.z)

			//check if we've already swapped this turf
			if(interior_turfs.Find(curturf))
				//world << "{[curx],[cury]} skipping ([curturf.x],[curturf.y])"

			else
				//get the other turf
				var/turf/target_turf
				if(rotate_direction < 0)
					target_turf = get_cw_turf(curturf)
				else if(rotate_direction > 0)
					target_turf = get_ccw_turf(curturf)
				else
					target_turf = get_mirrored_turf(curturf)

				//locate the turf to swap it to
				if(target_turf)

					//world << "{[curx],[cury]} swapping ([curturf.x],[curturf.y]) with ([target_turf.x],[target_turf.y])"
					swap_turfs(curturf, target_turf)
					interior_turfs.Add(target_turf)
				/*else
					world << "{[curx],[cury]} skipping ([curturf.x],[curturf.y]) as its calculated CW turf is out of bounds"*/

			//move marker to current processing turf
			marker.loc = curturf

	//loop over all turfs again to rotate their contents and grab all the shuttle turfs
	interior_turfs = list()
	var/bottom_x = src.x + overmap_controller.virtual_area_dims
	var/bottom_y = src.y + overmap_controller.virtual_area_dims
	for(var/curx = 0, curx < maxdims, curx++)
		for(var/cury = 0, cury < maxdims, cury++)
			//ignore it if it's a blocker turf
			var/turf/curturf = locate(src.x + curx, src.y + cury, src.z)
			if(!istype(curturf, /turf/unsimulated/blocker))

				//change the direction of the turf and its contents
				curturf.dir = turn(curturf.dir, rotate_angle)
				for(var/atom/movable/A in curturf)
					A.dir = turn(A.dir, rotate_angle)

					if(istype(A, /obj/structure/table))
						var/obj/structure/table/T = A
						T.update_connections()

					//adjust APC pixel offsets
					//todo: this isn't done correctly still
					if(istype(A, /obj/machinery/power/apc))
						A.pixel_x = (A.dir & 3)? 0 : (A.dir == 4 ? -24 : 24)
						A.pixel_y = (A.dir & 3)? (A.dir ==1 ? -24 : 24) : 0

				//remember it for later
				interior_turfs.Add(curturf)
				if(curturf.x < bottom_x)
					bottom_x = curturf.x
				if(curturf.y < bottom_y)
					bottom_y = curturf.y

	//now squash down the shuttle turfs into the bottom left corner of the space
	if(bottom_x != src.x || bottom_y != src.y)
		bottom_x -= src.x
		bottom_y -= src.y
		while(interior_turfs.len)
			var/turf/curturf = interior_turfs[1]
			interior_turfs -= curturf
			var/turf/target_turf = locate(curturf.x - bottom_x, curturf.y - bottom_y, src.z)
			swap_turfs(curturf, target_turf)

	//finally set the new direction
	dir = newdir

/obj/effect/virtual_area/proc/get_cw_turf(var/turf/start)
	var/offsetx = start.x - src.x
	var/offsety = start.y - src.y
	var/maxdims = map_dimx > map_dimy ? map_dimx : map_dimy
	//
	//return locate(src.x + offsety, src.y + offsetx, src.z)
	var/turf/out_turf = locate(src.x + offsety, src.y + (maxdims - offsetx) - 1, src.z)
	if(out_turf)
		if(out_turf.x < src.x)
			out_turf = null
		else if(out_turf.y < src.y)
			out_turf = null
	return out_turf

/obj/effect/virtual_area/proc/get_ccw_turf(var/turf/start)
	var/offsetx = start.x - src.x
	var/offsety = start.y - src.y
	var/maxdims = map_dimx > map_dimy ? map_dimx : map_dimy
	//
	var/turf/out_turf = locate(src.x + (maxdims - offsety) - 1, src.y + offsetx, src.z)
	if(out_turf)
		if(out_turf.x < src.x)
			out_turf = null
		else if(out_turf.y < src.y)
			out_turf = null
	return out_turf

/obj/effect/virtual_area/proc/get_mirrored_turf(var/turf/start)
	//var/maxdims = map_dimx > map_dimy ? map_dimx : map_dimy
	//
	return locate(src.x + map_dimx - start.x, src.y + map_dimy - start.y, src.z)
