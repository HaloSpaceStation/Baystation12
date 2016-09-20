
var/list/available_quadrants = list()

/obj/effect/starsystem
	var/list/static_objs = list()
	var/list/ships = list()
	var/list/asteroid_fields = list()
	//var/list/asteroid_fields_processing = list()
	var/list/big_asteroids = list()

/obj/effect/starsystem/New()
	name = pick(outer_colony_systems)

/obj/effect/starsystem/proc/place_asteroid_fields()
	set background = 1

	world << "<span class='danger'>Populating asteroid fields for the [src] system...</span>"

	//create 2-4 asteroid fields
	//to keep the asteroids nicely spread out, we'll puit one in each "quadrant" (corner) of the star system
	//don't run this in a spawn()
	if(!available_quadrants || available_quadrants.len < 4)
		available_quadrants = list()
		//
		var/datum/coords/curloc = new()
		curloc.x_pos = 0.25
		curloc.y_pos = 0.25
		available_quadrants.Add(curloc)
		//
		curloc = new()
		curloc.x_pos = 0.75
		curloc.y_pos = 0.25
		available_quadrants.Add(curloc)
		//
		curloc = new()
		curloc.x_pos = 0.25
		curloc.y_pos = 0.75
		available_quadrants.Add(curloc)
		//
		curloc = new()
		curloc.x_pos = 0.75
		curloc.y_pos = 0.75
		available_quadrants.Add(curloc)

	//scatter the asteroid fields around
	var/amount = 3
	var/list/used_quadrants = list()
	while(amount > 0)
		amount -= 1
		var/datum/asteroidfield/current_field = new()
		asteroid_fields.Add(current_field)

		//get a random quadrant
		var/datum/coords/spawnloc = pick(available_quadrants)
		available_quadrants -= spawnloc
		used_quadrants += spawnloc

		//margin of 24 tiles around the edge
		current_field.centre_x = spawnloc.x_pos * 255 - 30 + rand(0, 93)
		current_field.centre_y = spawnloc.y_pos * 255 - 30 + rand(0, 93)

	//tell us to start processing while our big asteroids fill themselves out
	processing_objects.Add(src)

	//reset the quadrants list
	available_quadrants += used_quadrants

	//some fields might get extra mineable asteroids
	var/bonus_asteroids = overmap_controller.asteroid_zlevels_loading_unassigned.len + overmap_controller.asteroid_zlevels_ready.len - 3

	//generate asteroid fields
	for(var/datum/asteroidfield/current_field in asteroid_fields)
		//generate a nice diverse meteor field
		current_field.generate()

		//give them one free mineable asteroid
		current_field.place_bigasteroid()

		//chance of extra mineable asteroids
		if(bonus_asteroids > 0)
			current_field.place_bigasteroid()
			bonus_asteroids -= 1

	//asteroid_fields_processing |= asteroid_fields
/*
/obj/effect/starsystem/var/looping = 0

/obj/effect/starsystem/process()
	var/list/finished = list()

	//split the total step allocation up between all busy asteroid fields
	var/steps_per_asteroid = overmap_controller.asteroid_gen_config.asteroid_steps_per_process
	steps_per_asteroid /= asteroid_fields_processing.len
	for(var/datum/asteroidfield/asteroidfield in asteroid_fields_processing)
		if(asteroidfield.big_asteroids_generating.len)
			asteroidfield.run_steps(steps_per_asteroid)
		else
			finished += asteroidfield

	//if we're finished, stop processing
	asteroid_fields_processing -= finished
	if(!asteroid_fields_processing.len)
		processing_objects.Remove(src)
*/