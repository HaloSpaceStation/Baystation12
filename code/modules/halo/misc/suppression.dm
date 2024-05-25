
/mob/living/carbon/human/proc/suppression_act(var/obj/item/projectile/P)
	if(!client)
		return
	var/seconds_since_suppression = (world.time - time_last_suppressed)/10
	var/shake_chance = SUPPRESSION_SHAKE_CHANCE
	var/shake_intensity = 0
	if(seconds_since_suppression <= 1.5)
		overlay_fullscreen("suppress",SUPPRESSION_FULLSCREEN_TYPE, SUPPRESS_LARGE)
		shake_intensity = 1.25
		//severe supression effects
	else if(seconds_since_suppression <=4)
		overlay_fullscreen("suppress",SUPPRESSION_FULLSCREEN_TYPE, SUPPRESS_MID)
		shake_intensity = 0.75
		//medium supression effects
	else if(seconds_since_suppression <=8)
		overlay_fullscreen("suppress",SUPPRESSION_FULLSCREEN_TYPE, SUPPRESS_SMALL)
		shake_intensity = 0.25
		//low supression effects

	if(prob(shake_chance))
		shake_camera(src, round(0.25 SECONDS * shake_intensity), shake_intensity)
	if(prob(SUPPRESSION_SCREAM_CHANCE))
		emote("painscream",AUDIBLE_MESSAGE)
	time_last_suppressed = world.time