
/datum/signal
	var/obj/effect/overmapobj/transmit_sector
	var/transmit_strength = 1
	var/datum/language/language
	/*
	var/mob/speaker		//a hack for existing compatability... we should remove this eventually
	var/vname = "Unknown"
	var/vauth = "????"
	*/
/*
/datum/overcomms_radio_signal/New(var/datum/overcomms_radio_signal/original_signal)
	if(original_signal)
		for(var/V in original_signal.vars)
			src.vars[V] = original_signal.vars[V]
	else
		signal_id = "\ref[src]"
*/