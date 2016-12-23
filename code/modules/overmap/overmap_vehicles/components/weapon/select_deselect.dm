
/obj/structure/vehicle_component/weapon/select()
	//world << "[src] [src.type] /obj/structure/vehicle_component/weapon/select()"
	if(my_mount.screen_bg.set_status(1))
		//world << "	check1"
		//select this weapon
		owned_vehicle.selected_components |= src

		return 1

/obj/structure/vehicle_component/weapon/deselect()
	//world << "[src] [src.type] /obj/structure/vehicle_component/weapon/deselect()"
	if(my_mount.screen_bg.set_status(0))
		//world << "	check1"
		//deselect this weapon
		owned_vehicle.selected_components -= src

		return 1

/obj/structure/vehicle_component/weapon/select_deselect(var/direction = 0)
	//world << "[src] [src.type] /obj/structure/vehicle_component/weapon/select_deselect([direction])"
	if(direction > 0)
		//world << "	check1"
		select()
	else if(direction < 0)
		//world << "	check2"
		deselect()
	else
		//world << "	check3"
		if(!select())
			//world << "	check4"
			deselect()
