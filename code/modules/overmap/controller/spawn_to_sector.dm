
//note: source_sector is optional and the code will handle fine without it, but the destination and spawn location (or spawn edge) will be randomised
/datum/controller/process/overmap/proc/spawn_to_sector(var/turf/overmap_turf, var/atom/movable/A, var/obj/effect/overmapobj/source_sector, var/skip_recycle = 0)
	//world << "spawn_to_sector([overmap_turf], [A], [source_sector])"

	//first check if we can "lose" the object in deepspace and not have to do all this processing
	if(!skip_recycle && overmap_controller.attempt_recycle_deepspace_atom(A))
		return 2

	//attempt to locate a pre-existing object to spawn to (avoiding the source)
	var/obj/effect/overmapobj/spawn_sector = get_destination_sector(overmap_turf)		//see code\modules\overmap\controller\spacetravel.dm

	//calculate the x and y coordinates to spawn in on
	//TRANSITIONEDGE is defined at 7 whereas 1 pixel on the overmap represents 7.9 turfs so this shouldn't result in a jolt on the overmap
	var/spawnx = 0
	var/spawny = 0
	if(source_sector)
		//reverse engineer sector coordinates from the pixel offset of the source object
		spawnx = world.maxx * ((16 + source_sector.pixel_x) / 32)
		spawny = world.maxy * ((16 + source_sector.pixel_y) / 32)

		//make sure values are valid
		spawnx = Clamp(spawnx, TRANSITIONEDGE, world.maxx - TRANSITIONEDGE)
		spawny = Clamp(spawny, TRANSITIONEDGE, world.maxy - TRANSITIONEDGE)
	else
		//pick random coordinates
		spawnx = rand(TRANSITIONEDGE, world.maxx - TRANSITIONEDGE)
		spawny = rand(TRANSITIONEDGE, world.maxy - TRANSITIONEDGE)

	//grab the actual spawnsector and direction to start drifting in
	var/throwdir = 0
	var/obj/effect/zlevelinfo/target_zlevel
	if(spawn_sector && spawn_sector.linked_zlevelinfos.len)
		//pick a random zlevel to come into
		target_zlevel = pick(spawn_sector.linked_zlevelinfos)

		//spawn on the closest edge
		//there might be a more concise way to do this (one that avoids repetition) but at least this should run fairly fast
		if(spawnx < world.maxx / 2)
			//left half of the map
			if(spawny < world.maxy / 2)
				//bottom left quadrant
				if(spawnx < spawny)
					//left edge
					spawnx = TRANSITIONEDGE + 1
					//spawnturf = locate(TRANSITIONEDGE + 1, spawny, deep_space_sector.map_z)
					throwdir = EAST
				else
					//bottom edge
					spawny = TRANSITIONEDGE + 1
					//spawnturf = locate(spawnx, TRANSITIONEDGE + 1, deep_space_sector.map_z)
					throwdir = NORTH
			else
				//top left quadrant
				if(spawnx < world.maxy - spawny)
					//left edge
					spawnx = TRANSITIONEDGE + 1
					//spawnturf = locate(TRANSITIONEDGE + 1, spawny, deep_space_sector.map_z)
					throwdir = EAST
				else
					//top edge
					spawny = world.maxy - TRANSITIONEDGE - 1
					//spawnturf = locate(spawnx, world.maxy - TRANSITIONEDGE - 1, deep_space_sector.map_z)
					throwdir = SOUTH
		else
			//right half of the map
			if(spawny < world.maxy / 2)
				//bottom right quadrant
				if(world.maxx - spawnx < spawny)
					//right edge
					spawnx = world.maxx - TRANSITIONEDGE - 1
					//spawnturf = locate(world.maxx - TRANSITIONEDGE - 1, spawny, deep_space_sector.map_z)
					throwdir = WEST
				else
					//bottom edge
					spawny = TRANSITIONEDGE + 1
					//spawnturf = locate(spawnx, TRANSITIONEDGE + 1, deep_space_sector.map_z)
					throwdir = NORTH
			else
				//top right quadrant
				if(world.maxx - spawnx < world.maxy - spawny)
					//right edge
					spawnx = world.maxx - TRANSITIONEDGE - 1
					//spawnturf = locate(world.maxx - TRANSITIONEDGE - 1, spawny, deep_space_sector.map_z)
					throwdir = WEST
				else
					//top edge
					spawny = world.maxy - TRANSITIONEDGE - 1
					//spawnturf = locate(spawnx, world.maxy - TRANSITIONEDGE - 1, deep_space_sector.map_z)
					throwdir = SOUTH
	else
		//otherwise we're going to spawn to a temporary deepspace sector
		target_zlevel = get_or_create_cached_zlevel()
		target_zlevel.name = "Temporary space sector"

		//create a corresponding deep space sector so we can be found
		testing("	Adding new temporary space sector...")
		spawn_sector = new /obj/effect/overmapobj/temporary_sector(overmap_turf.x, overmap_turf.y, target_zlevel.z)
		spawn_sector:objects_preventing_recycle.Add(A)
		spawn_sector.linked_zlevelinfos.Add(target_zlevel)
		map_sectors["[target_zlevel.z]"] = spawn_sector

		//testing("Destination: z[nz] [target_obj]")

		//throw in the approximate direction we are travelling - this will clamp to 45 degree increments but that's ok because tile based movement
		//todo: it might not handle diagonal dirs nicely, so test this to make sure (restrict to cardinals if not)
		if(source_sector && istype(source_sector, /obj/effect/overmapobj/vehicle))
			var/obj/effect/overmapobj/vehicle/V = source_sector
			throwdir = angle2dir(V.pixel_transform.heading)
		else
			throwdir = pick(cardinal)

	//spawn in at the target location at the sector
	//world << "spawning to sector [spawnx],[spawny],[spawnz]"
	var/turf/spawn_turf = locate(spawnx, spawny, target_zlevel.z)
	A.loc = spawn_turf

	//if we're a mob start floating off in the calculated direction
	//todo: hack in throwcode here so that objs drift as well (most objs should have been already recycled at the start of this proc tho)
	A.last_move = throwdir
	spawn_turf.inertial_drift(A)

	if(istype(A, /obj/machinery/overmap_vehicle))
		var/obj/machinery/overmap_vehicle/V = A

		if(source_sector)
			V.leaving_sector(spawn_sector, source_sector)

		V.enter_new_sector(spawn_sector, target_zlevel)

	//inform the unfortunate atom they've been left behind
	if(source_sector)
		A << "\icon[source_sector] <span class='warning'>[source_sector] disappears into the distance. You drift into [spawn_sector].</span>"
	else
		A << "<span class='warning'>You drift into [spawn_sector].</span>"

	return 1
