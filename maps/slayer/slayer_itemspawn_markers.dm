
/obj/effect/itemspawn_marker
	name = "Itemspawn Marker"
	invisibility = 101
	var/spawn_interval = 2 MINUTES
	var/time_next_item_spawn = 0
	var/obj/last_spawned_item //We track our last spawned item, until we realise it's moved off of our position.
	var/list/spawnables = list()

/obj/effect/itemspawn_marker/process()
	. = ..()
	if(last_spawned_item)
		if(last_spawned_item.loc != get_turf(loc)) //.loc is intentionally used here to disallow standing on the spawn tile
			//whilst holding the item and other such things.
			last_spawned_item = null
			time_next_item_spawn = world.time + spawn_interval
	else
		if(world.time >= time_next_item_spawn)
			spawn_item()

/obj/effect/itemspawn_marker/proc/spawn_item()
	var/turf/t = get_turf(loc)
	if(!t)
		return
	var/to_spawn = pick(spawnables)
	last_spawned_item = new to_spawn (t)

//Marker Variants//

/obj/effect/itemspawn_marker/melee

/obj/effect/itemspawn_marker/pistols

/obj/effect/itemspawn_marker/smgs

/obj/effect/itemspawn_marker/rifles

/obj/effect/itemspawn_marker/snipers

/obj/effect/itemspawn_marker/explosives

/obj/effect/itemspawn_marker/launchers