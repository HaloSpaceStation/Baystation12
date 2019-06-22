
/turf/simulated/wall/tech/fake/attack_hand(mob/user)
	if(isliving(user))
		src.visible_message("<span class='info'>[src] slides back to reveal a hidden area!</span>")
		src.ChangeTurf(/turf/simulated/floor/plating/fakewall)
	else
		. = ..()

/turf/simulated/floor/plating/fakewall
	var/revert_time = 0
	var/open_duration = 50

/turf/simulated/floor/plating/fakewall/New()
	. = ..()
	revert_time = world.time + open_duration
	GLOB.processing_objects.Add(src)

/turf/simulated/floor/plating/fakewall/process()
	if(world.time >= revert_time)
		src.visible_message("<span class='info'>[src] slides forward to hide its contents.</span>")
		src.ChangeTurf(/turf/simulated/wall/tech/fake)
