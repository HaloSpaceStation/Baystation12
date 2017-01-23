
var/list/available_quadrants = list()

/obj/effect/starsystem
	var/list/static_objs = list()
	var/list/ships = list()
	var/list/asteroid_fields = list()

/obj/effect/starsystem/New()
	name = pick(outer_colony_systems)

/obj/effect/starsystem/proc/generate_asteroid_fields()
	set background = 1

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
	var/amount = pick(3,4)
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
		current_field.centre_x = spawnloc.x_pos * 255 - 30 + rand(0, 97)
		current_field.centre_y = spawnloc.y_pos * 255 - 30 + rand(0, 97)

		//spawn a field around it that is about

	//reset the quadrants list
	available_quadrants += used_quadrants

	for(var/datum/asteroidfield/current_field in asteroid_fields)
		current_field.generate()
