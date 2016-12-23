
/obj/machinery/datanet_berth_console
	name = "Docking Berth Controller"
	icon = 'icons/obj/airlock_machines.dmi'
	icon_state = "airlock_control_standby"

	//the datanet isnt strictly needed (only the logic modules) but its nice to know about
	var/datum/datanet/datanet
	var/datum/datanet_logic/airlock/datanet_airlock
	var/datum/datanet_logic/berth/datanet_berth

/obj/machinery/datanet_berth_console/datanet_linked(var/datum/datanet/new_datanet)
	//world << "/obj/machinery/datanet_berth_console/datanet_linked([new_datanet.type]) [datanet_tag]"
	datanet = new_datanet
	//tell our parent network which logic modules we require
	new_datanet.require_logic_module(/datum/datanet_logic/airlock)
	new_datanet.require_logic_module(/datum/datanet_logic/berth)

/obj/machinery/datanet_berth_console/datanet_logic_linked(var/logic_module)
	//world << "/obj/machinery/datanet_berth_console/datanet_logic_linked([logic_module:type]) [datanet_tag]"
	//only link to the logic modules we care about
	if(istype(logic_module, /datum/datanet_logic/airlock))
		datanet_airlock = logic_module
	else if(istype(logic_module, /datum/datanet_logic/berth))
		datanet_berth = logic_module

/obj/machinery/datanet_berth_console/attack_ai(mob/user as mob)
	src.ui_interact(user)

/obj/machinery/datanet_berth_console/attack_hand(mob/user as mob)

	if(!user.IsAdvancedToolUser())
		return 0

	src.ui_interact(user)

/obj/machinery/datanet_berth_console/proc/get_berthed_vehicle()
	if(datanet_berth)
		return datanet_berth.berthed_vehicle

/obj/machinery/datanet_berth_console/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	var/data[0]

	//misc data
	data = list(
		"netstat" = datanet ? 1 : 0,
		"datanet_tag" = src.datanet_tag
		)

	//berth specific data
	if(datanet_berth)
		data |= list(
		"bnetstat" = 1
		)
	else
		data |= list(
		"bnetstat" = 0
		)

	//vehicle specific data
	var/obj/machinery/overmap_vehicle/my_vehicle = get_berthed_vehicle()
	if(my_vehicle)
		data |= list(
		"occuname" = my_vehicle.name,
		"occudesc" = my_vehicle.desc
		)
	else
		data |= list(
		"occuname" = "No occupant",
		"occudesc" = "NA"
		)

	//airlock specific data
	if(datanet_airlock)
		data |= list(
		"anetstat" = 1,
		"cyclestat" = datanet_airlock.state,
		"pressure" = datanet_airlock.get_chamber_pressure(),
		"extclosed" = datanet_airlock.exterior_closed,
		"intclosed" = datanet_airlock.interior_closed
		)
	else
		data |= list(
		"anetstat" = 0,
		"cyclestat" = 0,
		"pressure" = 0,
		"extclosed" = 0,
		"intclosed" = 0
		)

	ui = nanomanager.try_update_ui(user, src, ui_key, ui, data, force_open)

	if (!ui)
		ui = new(user, src, ui_key, "berth_console.tmpl", name, 500, 600)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/machinery/datanet_berth_console/Topic(href, href_list)
	if(..())
		return

	usr.set_machine(src)
	src.add_fingerprint(usr)

	var/clean = 0
	switch(href_list["command"])	//anti-HTML-hacking checks
		if("cycle_ext")
			clean = 1

			//cycling out means something might be leaving, so schedule a rescan in 15 seconds to give them time to leave if necessary
			spawn(150)
				if(datanet_berth)
					datanet_berth.refresh_berthed_vehicle()
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

		if("refresh_vehicle")
			if(datanet_berth)
				datanet_berth.refresh_berthed_vehicle()
				/*var/out_message = "Scan complete. Berth \'[datanet_tag]\' has no occupying vehicle."
				var/obj/machinery/overmap_vehicle/my_vehicle = get_berthed_vehicle()
				if(my_vehicle)
					out_message = "Scan complete. Berth \'[datanet_tag]\' is occupied by \'[my_vehicle.name]\'"
				src.visible_message(out_message)*/

	if(clean)
		datanet_airlock.enact_command(href_list["command"])

	return 1
