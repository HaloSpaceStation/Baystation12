
/mob/living/carbon/human/proc/focus_view()
	set category = "Abilities"
	set name = "Focus View"
	set desc = "Focus your eyes on distant objects."

	if(last_special > world.time)
		return

	if((src.client.pixel_y != 0)||(src.client.pixel_x != 0))
		src.client.pixel_y = 0
		src.client.pixel_x = 0
		return

	switch(src.dir)
		if(NORTH)
			src.client.pixel_y = 320
		if(SOUTH)
			src.client.pixel_y = -320
		if(EAST)
			src.client.pixel_x = 320
		if(WEST)
			src.client.pixel_x = -320
