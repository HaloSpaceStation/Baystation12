GLOBAL_VAR_INIT(popbalance_active,1)

/client/proc/pop_toggle()
	set category = "Fun"
	set name = "Toggle Popbalance"
	if(!check_rights(R_FUN))
		return

	var/message = ""
	if(GLOB.popbalance_active)
		message = "Population-based faction balance inactive"
	else
		message = "Population-based faction balance active"
	to_world("<span class = 'danger'>[message]</span>")
	GLOB.popbalance_active = !GLOB.popbalance_active