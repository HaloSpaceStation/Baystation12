
#define DEFAULT_LIGHT_STRING "#a0a080"

/obj/machinery/button/toggle/alarm_button
	var/area/area_base = null
	var/alert_message = "<font color='green'><b>Automated Alert System</b> coldly states, </font><font size ='4' color='red'><b>''Red Alert. All hands to battlestations.''</b></font>"
	var/un_alert_message = "<font color='green'><b>Automated Alert System</b> coldly states, </font><font size ='4' color='red'><b>''Green alert. All clear.''</b></font>"
	var/alarm_color_string = "#ff9696"
	var/sound/alarm_sound = 'code/modules/halo/sounds/r_alert_alarm_loop.ogg'
	var/alarm_loop_time = 13.896 SECONDS //The amount of time it takes for the alarm sound to end. Used for restarting the sound.
	var/currently_alarming
	var/starting_sound = null
	var/ending_sound = null

/obj/machinery/button/toggle/alarm_button/activate(var/mob/user)
	if(operating)
		return
	operating = 1
	active = !active
	use_power(5)
	if(active)
		if(!isnull(starting_sound))
			playsound(src, starting_sound, 150, 0, 500, 0,1)
		toggle_alert(1)
	else
		if(!isnull(ending_sound))
			playsound(src, ending_sound, 150, 0, 500, 0,1)
		toggle_alert(0)
	update_icon()
	operating = 0

/obj/machinery/button/toggle/alarm_button/proc/toggle_alert(var/on = 1)
	//First, tell all players in the ship-area that an alert has started.
	for(var/mob/m in GLOB.player_list)
		if(isturf(m.loc) && istype(m.loc.loc,area_base))
			var/message_using = on ? alert_message : un_alert_message
			to_chat(m,"<span class = 'danger'>[message_using]</span>")
	//Then, sound the alarm.
	if(on)
		currently_alarming = 1
		spawn(-1)
			while(currently_alarming)
				playsound(src, alarm_sound, 150, 0, 500, 0,1)
				sleep(alarm_loop_time)
	else
		currently_alarming = 0
	//Then, switch all lights to ominous red.
	for(var/obj/machinery/light/l in GLOB.machines)
		if(!istype(l.loc.loc,area_base))
			continue
		if(on)
			if(l.brightness_color == DEFAULT_LIGHT_STRING) //Only switch the color of lights that haven't been touched already.
				l.brightness_color = alarm_color_string
		else if (l.brightness_color == alarm_color_string)
			l.brightness_color = DEFAULT_LIGHT_STRING //The base light-color.
		l.update()

//Stupid snowflake button for both sound and door control at the same time
/obj/machinery/button/remote/blast_door/firing_sequence
	var/area/area_base = null
	var/sound_cooldown = 200
	var/last_used = 0
	var/alarm_sound = 'code/modules/halo/sounds/station_firing_sequence.ogg'
	var/door_cooldown = 50
	var/state = 1

/obj/machinery/button/remote/blast_door/firing_sequence/trigger()
	if((last_used + door_cooldown)<world.time)
		if(state)
			for(var/mob/m in GLOB.player_list)
				if(isturf(m.loc) && istype(m.loc.loc,area_base))
					to_chat(m,"<font color='green'><b>Automated Alert System</b> coldly states, </font><font size ='4' color='red'><b>''Station firing sequence has been initialized.''</b></font>")
					if((last_used + sound_cooldown)<world.time)
						m << alarm_sound
		state = !state

		for(var/obj/machinery/door/blast/M in world)
			if(M.id == src.id)
				if(M.density)
					spawn(0)
						M.open()
				else
					spawn(0)
						M.close()
	last_used = world.time

/obj/machinery/button/toggle/alarm_button/evacuation
	name = "Evacuation Alert"
	alarm_sound = 'sound/effects/siren.ogg'
	alarm_color_string = "#fedc56"
	alert_message = "<font color='green'><b>Automated Alert System</b> coldly states, </font><font size ='4' color='yellow'><b>''DELTA ALERT. EVACUATE IMMEDIATELY.''</b></font>"
	un_alert_message = "<font color='green'><b>Automated Alert System</b> coldly states, </font><font size ='4' color='red'><b>''Evacuation cancelled. Return to your stations.''</b></font>"