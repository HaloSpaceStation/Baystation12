
/obj/vehicle_hud/customise
	name = "Vehicle system preferences"
	icon_state = "customise"//"weapon_left"

/obj/vehicle_hud/customise/Click(location,control,params)
	//ui_interact(usr)

/*
/obj/item/device/aicard/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1, var/datum/topic_state/state = inventory_state)
	var/data[0]
	data["has_ai"] = carded_ai != null
	if(carded_ai)
		data["name"] = carded_ai.name
		data["hardware_integrity"] = carded_ai.hardware_integrity()
		data["backup_capacitor"] = carded_ai.backup_capacitor()
		data["radio"] = !carded_ai.aiRadio.disabledAi
		data["wireless"] = !carded_ai.control_disabled
		data["operational"] = carded_ai.stat != DEAD
		data["flushing"] = flush

		var/laws[0]
		for(var/datum/ai_law/AL in carded_ai.laws.all_laws())
			laws[++laws.len] = list("index" = AL.get_index(), "law" = sanitize(AL.law))
		data["laws"] = laws
		data["has_laws"] = laws.len

	ui = nanomanager.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "aicard.tmpl", "[name]", 600, 400, state = state)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)
*/
