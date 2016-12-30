
/obj/effect/overmapobj/var/time_next_meteor = 0

/obj/effect/overmapobj/process()
	if(in_meteor_sector)
		if(world.time > time_next_meteor)
			time_next_meteor = world.time + 5
			spawn_overmap_meteor()
	else
		return PROCESS_KILL
