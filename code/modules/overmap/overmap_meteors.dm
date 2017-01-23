//see code\game\game_modes\meteor\meteors.dm

/obj/effect/overmapobj/proc/spawn_overmap_meteor()
	var/list/start = pick_overmap_meteor_start()

	var/startLevel = start[1]
	var/turf/pickedstart = start[2]
	var/startSide = start[3]
	var/turf/pickedgoal = spaceDebrisFinishLoc(startSide, startLevel)

	var/list/meteor_types
	if(prob(1))
		meteor_types = meteors_catastrophic
	else if(prob(5))
		meteor_types = meteors_threatening
	else
		meteor_types = meteors_normal
	var/Me = pickweight(meteor_types)
	var/obj/effect/meteor/M = new Me(pickedstart)
	M.dest = pickedgoal
	M.z_original = startLevel
	//world << "[world.time]: [M] spawned from dir [startSide] on level [startLevel]"
	spawn(0)
		walk_towards(M, M.dest, 1)
	return

/obj/effect/overmapobj/proc/pick_overmap_meteor_start()
	var/startSide = pick(cardinal)
	var/obj/effect/zlevelinfo/zlevel = pick(linked_zlevelinfos)
	var/pickedstart = spaceDebrisStartLoc(startSide, zlevel.z)

	return list(zlevel.z, pickedstart, startSide)

//meteor severity levels:
/*
/var/list/meteors_normal = list(/obj/effect/meteor/dust=3, /obj/effect/meteor/medium=8, /obj/effect/meteor/big=3, \
						  /obj/effect/meteor/flaming=1, /obj/effect/meteor/irradiated=3) //for normal meteor event

/var/list/meteors_threatening = list(/obj/effect/meteor/medium=4, /obj/effect/meteor/big=8, \
						  /obj/effect/meteor/flaming=3, /obj/effect/meteor/irradiated=3) //for threatening meteor event

/var/list/meteors_catastrophic = list(/obj/effect/meteor/medium=5, /obj/effect/meteor/big=75, \
						  /obj/effect/meteor/flaming=10, /obj/effect/meteor/irradiated=10, /obj/effect/meteor/tunguska = 1) //for catastrophic meteor event

/var/list/meteors_dust = list(/obj/effect/meteor/dust) //for space dust event
*/