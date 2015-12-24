//see starsystem.dm for procedural asteroid field generation

/obj/effect/overmapobj/bigasteroid
	name = "large asteroid"
	icon = 'icons/obj/meteor.dmi'
	icon_state = "large"
	opacity = 1
	var/datum/asteroidfield/owner

/obj/effect/overmapobj/bigasteroid/New()
	if(prob(50))
		icon_state = "small"
	desc = pick("It must be almost a kilometre across!",\
	"This asteroid is huge, dwarfing the others around it.",\
	"It's an enormous asteroid, easily the same size as a warship.")

/obj/effect/overmapobj/asteroidsector
	name = "asteroid field"
	icon = 'icons/obj/meteor.dmi'
	icon_state = "dust"
	desc = "A load of rocky debris unpredictably bouncing off each other. Probably a bad idea to linger nearby."
	opacity = 1
	var/datum/asteroidfield/owner

/obj/effect/overmapobj/asteroidsector/Crossed(atom/movable/O)
	world << "[src] crossed by [O]"
	if(istype(O, /obj/effect/overmapobj))
		var/obj/effect/overmapobj/S = O
		S.start_meteors()
		world << "	meteors enabled"

/obj/effect/overmapobj/asteroidsector/Uncrossed(atom/movable/O)
	world << "[src] uncrossed by [O]"
	if(istype(O, /obj/effect/overmapobj))
		var/obj/effect/overmapobj/S = O
		S.stop_meteors()
		world << "	meteors disabled"

/datum/asteroidfield
	var/list/big_asteroids = list()
	var/list/fieldsectors = list()
	var/centre_x = 127
	var/centre_y = 127
	var/obj/effect/starsystem/my_starsystem

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

	var/num_big_asteroids = pick(3,4)		//can't have too many, each is a separate zlevel
	while(num_big_asteroids > 0 && fieldsectors.len > 0)
		num_big_asteroids -= 1
		var/obj/effect/overmapobj/asteroidsector/spawn_sector = pick(fieldsectors)
		fieldsectors -= spawn_sector

		var/obj/effect/overmapobj/bigasteroid/new_asteroid = new(spawn_sector.loc)
		big_asteroids.Add(new_asteroid)
		new_asteroid.owner = src

		qdel(spawn_sector)


//for debugging
/obj/effect/asteroid_field_generator
	icon = 'icons/obj/meteor.dmi'
	icon_state = "flaming"
	var/datum/asteroidfield/myfield

/obj/effect/asteroid_field_generator/New()
	myfield = new()
	myfield.centre_x = src.x
	myfield.centre_x = src.y

	myfield.generate()
