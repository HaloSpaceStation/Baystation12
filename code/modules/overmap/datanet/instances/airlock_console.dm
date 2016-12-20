
/obj/machinery/datanet_airlock_console
	name = "Airlock Controller"
	icon = 'icons/obj/airlock_machines.dmi'
	icon_state = "airlock_control_standby"
	var/datum/datanet_logic/airlock/datanet

/obj/machinery/datanet_airlock_console/datanet_linked(var/datum/datanet/new_datanet)
	new_datanet.require_logic_module(/datum/datanet_logic/airlock)

/obj/machinery/datanet_airlock_console/datanet_logic_linked(var/datum/datanet_logic/logic_module)
	//if we have an old module, just forget about it
	datanet = logic_module

/obj/machinery/datanet_airlock_console/attack_ai(mob/user as mob)
	src.ui_interact(user)

/obj/machinery/datanet_airlock_console/attack_hand(mob/user as mob)

	if(!user.IsAdvancedToolUser())
		return 0

	src.ui_interact(user)

/obj/machinery/datanet_airlock_console/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	var/data[0]

	if(datanet)
		data = list(
			"chamber_pressure" = round(datanet.get_chamber_pressure()),
			"external_pressure" = 0,
			"internal_pressure" = ONE_ATMOSPHERE,
			"processing" = (datanet.state != STATE_IDLE),
			"purge" = (datanet.state == STATE_PURGE),
			"secure" = (datanet.exterior_closed && datanet.interior_closed)
		)
	else
		data = list(
			"chamber_pressure" = 0,
			"external_pressure" = 0,
			"internal_pressure" = 0,
			"processing" = 0,
			"purge" = 0,
			"secure" = 0
		)

	ui = nanomanager.try_update_ui(user, src, ui_key, ui, data, force_open)

	if (!ui)
		ui = new(user, src, ui_key, "advanced_airlock_console.tmpl", name, 470, 290)

		ui.set_initial_data(data)

		ui.open()

		ui.set_auto_update(1)

/obj/machinery/datanet_airlock_console/Topic(href, href_list)
	if(..())
		return

	usr.set_machine(src)
	src.add_fingerprint(usr)

	var/clean = 0
	switch(href_list["command"])	//anti-HTML-hacking checks
		if("cycle_ext")
			clean = 1
		if("cycle_int")
			clean = 1
		if("force_ext")
			clean = 1
		if("force_int")
			clean = 1
		if("abort")
			clean = 1
		if("purge")
			clean = 1
		if("secure")
			clean = 1

	if(clean)
		datanet.enact_command(href_list["command"])

	return 1
