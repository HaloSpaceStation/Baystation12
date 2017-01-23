/obj/machinery/computer/helm
	name = "helm control console"
	icon_keyboard = "med_key"
	icon_screen = "steering"
	var/state = "status"
	var/obj/effect/overmapobj/ship/linked			//connected overmap object
	var/autopilot = 0
	var/manual_control = 0
	var/list/known_sectors = list()
	var/dx		//desitnation
	var/dy		//coordinates

	var/set_autobrake = 0

/obj/machinery/computer/helm/initialize()
	linked = map_sectors["[z]"]
	if (linked)
		/*if(!linked.nav_control)
			linked.nav_control = src*/
		testing("Helm console at level [z] found a corresponding overmap object '[linked.name]'.")
	else
		testing("Helm console at level [z] was unable to find a corresponding overmap object.")
	known_sectors = list()
	for(var/level in map_sectors)
		var/obj/effect/overmapobj/sector/S = map_sectors["[level]"]
		if (istype(S) && S.always_known)
			var/datum/data/record/R = new()
			R.fields["name"] = S.name
			R.fields["x"] = S.x
			R.fields["y"] = S.y
			known_sectors += R

/obj/machinery/computer/helm/proc/reinit()
	known_sectors = list()
	for(var/level in map_sectors)
		var/obj/effect/overmapobj/sector/S = map_sectors["[level]"]
		if (istype(S) && S.always_known)
			var/datum/data/record/R = new()
			R.fields["name"] = S.name
			R.fields["x"] = S.x
			R.fields["y"] = S.y
			known_sectors += R

/obj/machinery/computer/helm/process()
	..()

	/*if(linked && set_autobrake != linked.autobraking)
		linked.toggle_autobrake()*/

/*	if (autopilot && dx && dy)
		var/turf/T = locate(dx,dy,1)
		if(linked.loc == T)
			if(linked.is_still())
				autopilot = 0
			else
				linked.decelerate()

		var/brake_path = linked.get_brake_path()

		if(get_dist(linked.loc, T) > brake_path)
			linked.accelerate(get_dir(linked.loc, T))
		else
			linked.decelerate()

		return*/

/obj/machinery/computer/helm/relaymove(var/mob/user, direction)
	if(manual_control && linked)
		linked.relaymove(user,direction)
		return 1

/obj/machinery/computer/helm/proc/thrust_forward()
	if(manual_control && linked)
		linked.thrust_forward()
		return 1

/obj/machinery/computer/helm/check_eye(var/mob/user as mob)

	. = 0

	//a player is trying to manually fly the ship
	if(manual_control)
		//if it's a player we already know about, and we have a ship for them to control...
		if(manual_control == user && linked)
			//...but somehow they can't see where the ship is flying, let's reset their view for them
			if(user.client && user.client.eye != linked)
				user.reset_view(linked, 0)
				linked.my_observers.Remove(user)		//so we can avoid doubleups
				linked.my_observers.Add(user)

		//here are various fail conditions to check if the player needs to be looking via their own mob
		else
			. = -1
		if(get_dist(user, src) > 1 && !issilicon(user))
			. = -1
		if(user.blinded)
			. = -1
		if(!linked)
			. = -1
		if(user.stat)
			. = -1
	else
		if(!user)
			. = -1
		else if(user.client && user.client.eye == linked)
			. = -1

	//reset some custom view settings for ship control before resetting the view entirely
	if(. < 0 && user)
		if(linked)
			linked.my_observers.Remove(user)
		if(user.client)
			user.client.pixel_x = 0
			user.client.pixel_y = 0

/obj/machinery/computer/helm/attack_hand(var/mob/user as mob)
	if(..())
		user.unset_machine()
		manual_control = 0
		return

	if(!isAI(user))
		user.set_machine(src)

	ui_interact(user)

/obj/machinery/computer/helm/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	if(!linked)
		return

	var/data[0]
	data["state"] = state

	data["shipname"] = linked.ship_name		//currently unused
	data["sector"] = linked.current_sector ? linked.current_sector.name : "Deep Space"
	data["sector_info"] = linked.current_sector ? linked.current_sector.desc : "Not Available"
	data["s_x"] = linked.x
	data["s_y"] = linked.y
	data["dest"] = dy && dx
	data["d_x"] = dx
	data["d_y"] = dy
	data["speed"] = linked.get_speed() * 10
	data["accel"] = round(linked.get_acceleration())
	data["heading"] = linked.get_heading()
	data["autopilot"] = autopilot
	data["manual_control"] = manual_control
	data["autobraking"] = linked.autobraking

	var/list/locations[0]
	for (var/datum/data/record/R in known_sectors)
		var/list/rdata[0]
		rdata["name"] = R.fields["name"]
		rdata["x"] = R.fields["x"]
		rdata["y"] = R.fields["y"]
		rdata["reference"] = "\ref[R]"
		locations.Add(list(rdata))

	data["locations"] = locations

	ui = nanomanager.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "helm.tmpl", "[linked.name] Helm Control", 380, 560)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/machinery/computer/helm/Topic(href, href_list)
	if(..())
		return 1

	if (!linked)
		return

	if (href_list["add"])
		var/datum/data/record/R = new()
		var/sec_name = input("Input naviation entry name", "New navigation entry", "Sector #[known_sectors.len]") as text
		if(!sec_name)
			sec_name = "Sector #[known_sectors.len]"
		R.fields["name"] = sec_name
		switch(href_list["add"])
			if("current")
				R.fields["x"] = linked.x
				R.fields["y"] = linked.y
			if("new")
				var/newx = input("Input new entry x coordinate", "Coordinate input", linked.x) as num
				R.fields["x"] = Clamp(newx, 1, world.maxx)
				var/newy = input("Input new entry y coordinate", "Coordinate input", linked.y) as num
				R.fields["y"] = Clamp(newy, 1, world.maxy)
		known_sectors += R

	if (href_list["remove"])
		var/datum/data/record/R = locate(href_list["remove"])
		known_sectors.Remove(R)

	if (href_list["setx"])
		var/newx = input("Input new destiniation x coordinate", "Coordinate input", dx) as num|null
		if (newx)
			dx = Clamp(newx, 1, world.maxx)

	if (href_list["sety"])
		var/newy = input("Input new destiniation y coordinate", "Coordinate input", dy) as num|null
		if (newy)
			dy = Clamp(newy, 1, world.maxy)

	if (href_list["x"] && href_list["y"])
		dx = text2num(href_list["x"])
		dy = text2num(href_list["y"])

	if (href_list["reset"])
		dx = 0
		dy = 0

	if (href_list["move"])
		var/ndir = text2num(href_list["move"])
		linked.relaymove(usr, ndir)

	/*if (href_list["brake"])
		linked.decelerate()*/

	if (href_list["apilot"])
		autopilot = !autopilot

	if (href_list["abrake"])
		if(linked)
			linked.toggle_autobrake()

	if (href_list["manual"])
		if(manual_control)
			manual_control = null
			check_eye(manual_control)
		else if(ismob(usr))
			manual_control = usr
			check_eye(manual_control)

	if (href_list["state"])
		state = href_list["state"]
	add_fingerprint(usr)
	updateUsrDialog()

/obj/machinery/computer/helm/proc/thrust_forward_toggle()
	if(linked)
		linked.thrust_forward_toggle()
