
/obj/vehicle_hud/deselect
	name = "Deselect ship/strike craft"
	icon_state = "select"
	panel_icon_state = "weapon"

/obj/vehicle_hud/deselect/Click(location,control,params)
	my_vehicle.selected_overmapobj = null
	my_vehicle.selected_vehicle = null
	icon_state = "select"
	my_vehicle.hud_vehicle_select.loc = null
	my_vehicle.hud_overmap_select.loc = null

/obj/machinery/overmap_vehicle/machineClickOn(var/atom/A, var/params)
	//world << "[src] [src.type] machineClickOn([A], [params])"
	var/pre_state = selected_vehicle || selected_overmapobj
	var/success = 0

	if(istype(A, /obj/effect/overmapobj/vehicle))
		//world << "check1"
		var/obj/effect/overmapobj/vehicle/overmapobj = A
		selected_overmapobj = overmapobj
		hud_overmap_select.loc = selected_overmapobj
		//
		selected_vehicle = overmapobj.overmap_vehicle
		hud_vehicle_select.loc = selected_vehicle
		//
		success = 1

	else if(istype(A, /obj/effect/overmapobj))
		//world << "check2"
		var/obj/effect/overmapobj/overmapobj = A
		selected_overmapobj = overmapobj
		hud_overmap_select.loc = selected_overmapobj
		//
		selected_vehicle = null
		hud_vehicle_select.loc = null
		//
		success = 1

	else if(istype(A, /obj/machinery/overmap_vehicle))
		//world << "check3"
		var/obj/machinery/overmap_vehicle/overmap_vehicle = A
		selected_vehicle = overmap_vehicle
		hud_vehicle_select.loc = selected_vehicle
		//
		selected_overmapobj = selected_vehicle.overmap_object
		hud_overmap_select.loc = selected_overmapobj
		//
		success = 1

	if(success)
		//scale the selection images to be same size as the selected ships
		if(selected_vehicle)
			/*var/matrix/M = matrix()
			M.Scale(selected_vehicle.bound_width / 32, selected_vehicle.bound_height / 32)
			hud_vehicle_select.transform = M
			hud_vehicle_select.pixel_x = selected_vehicle.bound_width / 2
			hud_vehicle_select.pixel_y = selected_vehicle.bound_height / 2*/
			scale_and_position_underlay(hud_vehicle_select, 32, 32, selected_vehicle, selected_vehicle.bound_width, selected_vehicle.bound_height)

		if(selected_overmapobj)
			/*var/matrix/M = matrix()
			M.Scale(selected_overmapobj.bound_width / 32, selected_overmapobj.bound_height / 32)
			hud_overmap_select.transform = M
			hud_overmap_select.pixel_x = selected_overmapobj.bound_width / 2
			hud_overmap_select.pixel_y = selected_overmapobj.bound_height / 2*/
			scale_and_position_underlay(hud_overmap_select, 32, 32, selected_overmapobj, selected_overmapobj.bound_width, selected_overmapobj.bound_height)

		//let the player know we can now deselect it
		if(!pre_state)
			deselect_button.icon_state = "deselect"

	return success

//todo: this could be a very useful proc if made more generic
/obj/machinery/overmap_vehicle/proc/scale_and_position_underlay(var/image/I, var/image_width, var/image_height, var/atom/A, var/atom_width, var/atom_height)
	//scale the image so that it matches the destination size
	var/matrix/M = matrix()
	M.Scale(atom_width / 32, atom_height / 32)
	I.transform = M

	//there's probably a nicer way to do this but fuck it
	if(atom_width != 32 || atom_height != 32)
		//reposition the image so that its centered
		//I.pixel_x = atom_width / 2 - image_width / 2 + A.pixel_x
		I.pixel_x = atom_width / 2 + A.pixel_x
		//I.pixel_y = atom_height / 2 - image_height / 2 + A.pixel_y
		I.pixel_y = atom_height / 2 + A.pixel_y
