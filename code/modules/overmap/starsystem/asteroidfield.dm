//see starsystem.dm for asteroid field placement

/datum/asteroidfield
	var/centre_x = 127
	var/centre_y = 127
	var/list/fieldsectors = list()
	//
	var/obj/effect/starsystem/my_starsystem
	//
	var/list/big_asteroids = list()
	//var/list/big_asteroids_generating = list()

	/*
/datum/asteroidfield/proc/run_steps(var/steps_this_cycle = 0)
	set background = 1
	. = 1

	/*var/start_stage = -1
	var/finish_stage = 0*/

	var/num_skipped = 0
	while(big_asteroids_generating.len && steps_this_cycle > 0)
		var/obj/effect/overmapobj/bigasteroid/bigasteroid = big_asteroids_generating[1]

		if(!bigasteroid.generating)
			num_skipped++
			if(num_skipped >= big_asteroids_generating.len)
				break
			else
				continue

		/*if(start_stage < 0)
			start_stage = bigasteroid.gen_stage*/

		//a value greater than 0 means it hasnt finished generation and needs to keep stepping
		//a value greater than 1 means its going through an intensive stage and should be done with less steps than other stages
		var/retval = bigasteroid.step_generation()
		steps_this_cycle -= retval
		if(!retval)
			big_asteroids_generating -= bigasteroid

		steps_this_cycle -= 1
		if(overmap_controller.asteroid_gen_config.interrupting)
			sleep(-1)

		//finish_stage = bigasteroid.gen_stage

	//world << "/datum/asteroidfield/proc/process() start_stage:[start_stage] finish_stage:[finish_stage]"

	//no more asteroids to process
	if(!big_asteroids_generating.len)
		. = 0*/

/datum/asteroidfield/proc/generate()
	set background = 1

	//fill out the asteroid fields
	var/max_dist = 30
	var/max_turfs = 2500
	var/turf/centre_turf = locate(centre_x, centre_y, OVERMAP_ZLEVEL)
	var/list/turfs_to_process = circlerangeturfs(centre_turf, max_dist)

	while(turfs_to_process.len)
		//limit the number of turfs so it doesnt explode
		if(fieldsectors.len >= max_turfs)
			break

		//get adjacent unprocessed tiles up to a certain distance from the centre
		var/turf/current_turf = pop(turfs_to_process)
		var/cur_dist = get_dist(current_turf, centre_turf)
		/*turfs_processed.Add(current_turf)
		if(cur_dist > max_dist)
			continue*/

		//this seems a fairly nice number that leaves some space between asteroid sectors while being more densely packed at the centre of the field
		var/chance = 40 * (1 - (cur_dist / max_dist))
		if(prob(chance))
			var/obj/effect/overmapobj/asteroidsector/newsector = new(current_turf)
			newsector.owner = src
			fieldsectors.Add(newsector)

		//grab adjacent turfs for the next process loop
		/*for(var/turf/T in orange(1, current_turf))
			if(!(T in turfs_to_process) && !(T in turfs_processed) )
				turfs_to_process.Add(T)*/

/datum/asteroidfield/proc/place_bigasteroid()

	//pick a random spot in the field to spawn it
	var/obj/effect/overmapobj/asteroidsector/spawn_sector = pick(src.fieldsectors)
	var/obj/effect/overmapobj/bigasteroid/new_asteroid = new(spawn_sector.loc)

	//clear the meteors out from that spot
	src.fieldsectors -= spawn_sector
	qdel(spawn_sector)

	//some last stuff
	src.big_asteroids.Add(new_asteroid)
	new_asteroid.owner = src
	/*new_asteroid.myzlevel = overmap_controller.get_asteroid_zlevel()
	if(new_asteroid.myzlevel)
		new_asteroid.myzlevel.begin_generation()
	else
		new_asteroid.myzlevel = overmap_controller.get_or_create_cached_zlevel()
		new_asteroid.myzlevel.begin_generation(1)

	new_asteroid.linked_zlevelinfos += new_asteroid.myzlevel*/

	//we'll generate it step by step over the round to avoid lag at round start
	//big_asteroids_generating += new_asteroid

	/*
	var/starttime = world.time
	log_admin("Generating mineable asteroid...")
	generate_asteroid_mask(new_asteroid.myzlevel.z)
	log_admin("	Done generate_asteroid_mask() ([(world.time - starttime) / 10]s).")
	*/

//the corresponding overmapobj
/obj/effect/overmapobj/asteroidsector
	name = "asteroid field"
	icon = 'icons/obj/meteor.dmi'
	icon_state = "dust"
	desc = "A load of rocky debris unpredictably bouncing off each other. Probably a bad idea to linger nearby."
	opacity = 1
	var/datum/asteroidfield/owner

/obj/effect/overmapobj/asteroidsector/Crossed(atom/movable/O)
	if(istype(O, /obj/effect/overmapobj))
		var/obj/effect/overmapobj/S = O
		S.start_meteors()

/obj/effect/overmapobj/asteroidsector/Uncrossed(atom/movable/O)
	if(istype(O, /obj/effect/overmapobj))
		var/obj/effect/overmapobj/S = O
		S.stop_meteors()


//for debugging
/*
/obj/effect/asteroid_field_generator
	icon = 'icons/obj/meteor.dmi'
	icon_state = "flaming"
	var/datum/asteroidfield/myfield

/obj/effect/asteroid_field_generator/New()
	myfield = new()
	myfield.centre_x = src.x
	myfield.centre_x = src.y

	myfield.generate()
*/
