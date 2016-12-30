
/datum/vehicle_mount/fourbyfour/right
	name = "Right Wing (under)"
	name_abbr = "WING (R-U)"
	mount_type = MOUNT_EXT
	mount_size = MOUNT_LARGE

/datum/vehicle_mount/fourbyfour/right/small
	name = "Right Wing (over)"
	name_abbr = "WING (R)"
	mount_size = MOUNT_SMALL

/datum/vehicle_mount/fourbyfour/right/position_weapon(var/obj/structure/vehicle_component/weapon/weapon)
	var/oriented_dir = angle2dir(my_vehicle.pixel_transform.heading)
	//hardcode the values... this seems easier than working out an exact algorithm
	switch(oriented_dir)
		if(NORTH)
			weapon.proj_start = locate(my_vehicle.x+3, my_vehicle.y+1, my_vehicle.z)
		if(EAST)
			weapon.proj_start = locate(my_vehicle.x+1, my_vehicle.y+0, my_vehicle.z)
		if(SOUTH)
			weapon.proj_start = locate(my_vehicle.x+0, my_vehicle.y+2, my_vehicle.z)
		if(WEST)
			weapon.proj_start = locate(my_vehicle.x+2, my_vehicle.y+3, my_vehicle.z)

		//same as cardinals because i cbb doing them exactly
		if(NORTHEAST)
			weapon.proj_start = locate(my_vehicle.x+3, my_vehicle.y+0, my_vehicle.z)
		if(SOUTHEAST)
			weapon.proj_start = locate(my_vehicle.x+0, my_vehicle.y+0, my_vehicle.z)
		if(SOUTHWEST)
			weapon.proj_start = locate(my_vehicle.x+0, my_vehicle.y+3, my_vehicle.z)
		if(NORTHWEST)
			weapon.proj_start = locate(my_vehicle.x+3, my_vehicle.y+3, my_vehicle.z)
