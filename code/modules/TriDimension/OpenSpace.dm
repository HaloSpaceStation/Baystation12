
//init the image overlays for open space on the map at roundstart
//this is necessary because turf/New is run before obj/New which means zlevels are init later
/hook/roundstart/proc/open_space_turfs()
	for(var/turf/simulated/floor/open/O in world)
		O.init()
	return 1

/turf/simulated/floor/open
	name = "open space"
	icon = 'icons/turf/space.dmi'
	icon_state = "black"
	density = 0
	pathweight = 100000 //Seriously, don't try and path over this one numbnuts
	var/list/z_overlays
	var/image/turf_underlay
	blocks_air_downwards = 0

/turf/simulated/floor/open/New()
	..()
	init()

/turf/simulated/floor/open/proc/init()
	if(map_sectors.len)
		if(HasBelow(src.z))
			levelupdate()
		else
			ChangeTurf(get_base_turf(src.z))

// override to make sure nothing is hidden
/turf/simulated/floor/open/levelupdate()
	for(var/obj/O in src)
		if(O.level == 1)
			O.hide(0)

	//this code has an issue with lighting overlays being stuck permanently pitch black
	/*
	//loop through all turfs underneath and give players an image of the first ground turf we get to
	var/turf/T = src
	var/levels_high = 0
	while(T && istype(T, /turf/simulated/floor/open))
		T = locate(x, y, z + 1)
		levels_high += 1

		//accessways count as "ground" turfs
		if(istype(T, /turf/simulated/floor/open/accessway))
			break
	levels_high = min(levels_high, 4)

	//clear out the old images
	if(turf_underlay)
		underlays -= turf_underlay
		qdel(turf_underlay)

	//temporarily mess with the lighting layer so that weird stuff doesnt happen
	if(T.lighting_overlay)
		T.overlays -= T.lighting_overlay
	turf_underlay = image(T, dir=T.dir, layer = TURF_LAYER + 0.04)
	//restore the lighting layer
	if(T.lighting_overlay)
		T.overlays += T.lighting_overlay

	//add the new image of the lower turf go go in the hole
	//turf_underlay.color = rgb(127,127,127)
	turf_underlay.overlays += T.overlays
	underlays += turf_underlay
	//src.icon.SwapColor(0,0,0, 0)	//255 * (levels_high / 7)
	*/

/turf/simulated/floor/open/Enter(var/atom/movable/falling_atom)
	. = 1	//TODO make this check if gravity is active (future use) - Sukasa

	//if AM is being thrown just fly over (dont worry about arcing flight)
	if(falling_atom.throw_source)
		return 1

	//leave anchored stuff alone for now
	if(falling_atom.anchored)
		return 1

	//if there is a ladder or lattice secured in this turf, mobs can walk across it
	var/mob/living/falling_mob
	if(istype(falling_atom, /mob/living/))
		falling_mob = falling_atom
		var/obj/structure/ladder/L = locate() in contents
		if(L && L.anchored)
			falling_mob << "You cross the top of the ladder."
			return 1
		var/obj/structure/lattice/A = locate() in contents
		if(A)
			falling_mob << "You cross the lattice."
			return 1

	//otherwise, we'll fall down onto the zlevel below
	if(falling_atom && istype(falling_atom) && HasBelow(src.z))
		//if there are stairs below, move smoothly down a level without "falling"
		var/turf/floorbelow = locate(x, y, z + 1)
		if(istype(floorbelow, /turf/simulated/floor/stairs))
			//if we came up from the stairs, just stand at the top of them
			if(falling_atom.loc == floorbelow)
				return 1

			//check for anything blocking the stairs - note we can still get on "top" of the stairs, just not walk down them
			for(var/obj/obstacle in floorbelow)
				if(!obstacle.CanPass(falling_atom, floorbelow))
					falling_atom << "<span class='notice'>The top of \the [floorbelow] is blocked by \the [obstacle].</span>"
					return 1
			spawn(0)
				falling_atom.Move(floorbelow)
			return 1

		//if there is a dense turf below, "walk" across it
		if(!floorbelow.CanPass(falling_atom, floorbelow))
			return 1

		// only start falling in defined areas (read: areas with artificial gravitiy)
		var/area/areacheck = get_area(src)
		if(areacheck.name != "Space" || (falling_mob && falling_mob.falling_stacks) )

			//if we're a mob, take damage depending how far we fell
			//if we're an atom, deal damage to mobs we fall on depending on how far we fell
			if(!falling_atom.falling_stacks)
				falling_atom << "<span class='warning'>You fall!</span>"
			falling_atom.falling_stacks += 1

			//if it's a space turf below, fly off into the distance
			if(istype(floorbelow, /turf/space))
				falling_atom.falling_stacks = 0
				spawn(0)
					falling_atom.touch_map_edge()
				return 1

			//force AM to move down a level so players can't walk across machines, structures, pipes etc (use a lattice if you want to be parkour man)
			if(!falling_atom.Move(floorbelow))
				falling_atom.loc = floorbelow

			//if it's not more open space, apply our cumulative fall damage
			if(!istype(floorbelow, /turf/simulated/floor/open))
				playsound(floorbelow, 'sound/machines/door_close.ogg', 100, 1)
				if(falling_mob)
					//land on some random bodyparts
					var/fall_damage = 5 * falling_mob.falling_stacks

					if(prob(25))
						var/blocked = falling_mob.run_armor_check("head","melee")
						falling_mob.apply_damage(fall_damage, BRUTE, "head", blocked, 0, "Falling")
					if(prob(50))
						var/blocked = falling_mob.run_armor_check("chest","melee")
						falling_mob.apply_damage(fall_damage, BRUTE, "chest", blocked, 0, "Falling")
					if(prob(50))
						var/blocked = falling_mob.run_armor_check("l_leg","melee")
						falling_mob.apply_damage(fall_damage, BRUTE, "l_leg", blocked, 0, "Falling")
					else
						var/blocked = falling_mob.run_armor_check("r_leg","melee")
						falling_mob.apply_damage(fall_damage, BRUTE, "r_leg", blocked, 0, "Falling")
					if(prob(50))
						var/blocked = falling_mob.run_armor_check("l_arm","melee")
						falling_mob.apply_damage(fall_damage, BRUTE, "l_arm", blocked, 0, "Falling")
					else
						var/blocked = falling_mob.run_armor_check("r_arm","melee")
						falling_mob.apply_damage(fall_damage, BRUTE, "r_arm", blocked, 0, "Falling")

					//briefly stunned from our fall
					falling_mob.Stun(falling_mob.falling_stacks + 1)

				//if there are any mobs on the turf below, we'll land on one of them
				var/mob/living/mob_underneath
				for(var/mob/living/L in floorbelow)
					if(L == falling_atom)
						continue

					mob_underneath = L
					break

				if(mob_underneath)
					var/fall_damage = 5
					if(isobj(falling_atom))
						var/obj/O = falling_atom
						fall_damage = O.force
					fall_damage *= falling_atom.falling_stacks

					//pick either head, left arm or right arm (head and shoulders) to fall on
					if(prob(50))
						var/blocked = mob_underneath.run_armor_check("head","melee")
						mob_underneath.apply_damage(fall_damage, BRUTE, "head", blocked, 0, "Falling")
					else if(prob(50))
						var/blocked = mob_underneath.run_armor_check("l_arm","melee")
						mob_underneath.apply_damage(fall_damage, BRUTE, "l_arm", blocked, 0, "Falling")
					else if(prob(50))
						var/blocked = mob_underneath.run_armor_check("r_arm","melee")
						mob_underneath.apply_damage(fall_damage, BRUTE, "r_arm", blocked, 0, "Falling")

					mob_underneath.Stun(falling_atom.falling_stacks + 1)

				falling_atom.falling_stacks = 0

				//display a warning message to everyone nearby if a mob had something fall on them
				if(mob_underneath)
					if(falling_mob)
						mob_underneath.visible_message("<span class='warning'>[falling_mob] has landed on [mob_underneath]!</span>",\
						"<span class='warning'>[falling_mob] has landed on you!</span>")
					else
						mob_underneath.visible_message("<span class='warning'>[mob_underneath] has been hi by a falling [falling_atom].</span>",\
						"<span class='warning'>You have been hit by a falling [falling_atom]!</span>")

//overwrite the attackby of space to transform it to openspace if necessary
/*/turf/space/attackby(obj/item/C as obj, mob/user as mob)
	if (istype(C, /obj/item/stack/cable_coil) && HasBelow(src.z))
		var/turf/simulated/floor/open/W = src.ChangeTurf(/turf/simulated/floor/open)
		W.attackby(C, user)
		return
	..()*/

/turf/simulated/floor/open/ex_act(severity)
	// cant destroy empty space with an ordinary bomb
	return

/turf/simulated/floor/open/attackby(obj/item/C as obj, mob/user as mob)
	(..)
	if (istype(C, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/cable = C
		cable.turf_place(src, user)
		return

	if (istype(C, /obj/item/stack/rods))
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(L)
			return
		var/obj/item/stack/rods/R = C
		if (R.use(1))
			user << "<span class='notice'>Constructing support lattice...</span>"
			playsound(src, 'sound/weapons/Genhit.ogg', 50, 1)
			ReplaceWithLattice()
		return

	if (istype(C, /obj/item/stack/tile/floor))
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(L)
			var/obj/item/stack/tile/floor/S = C
			if (S.get_amount() < 1)
				S.use(0)
				return
			qdel(L)
			playsound(src, 'sound/weapons/Genhit.ogg', 50, 1)
			S.use(1)
			src.ChangeTurf(/turf/simulated/floor/plating)
			return
		else
			user << "<span class='warning'>The plating is going to need some support.</span>"
	return
