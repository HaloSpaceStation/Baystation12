
/datum/vehicle_mount/fourbyfour/nose
	name = "Nose"
	name_abbr = "NOSE"
	mount_type = MOUNT_EXT
	mount_size = MOUNT_SMALL

/datum/vehicle_mount/fourbyfour/nose/position_weapon(var/obj/structure/vehicle_component/weapon/weapon)
	var/oriented_dir = angle2dir(my_vehicle.pixel_transform.heading)
	//hardcode the values... this seems easier than working out an exact algorithm
	switch(oriented_dir)
		if(NORTH)
			weapon.proj_start = locate(my_vehicle.x+1, my_vehicle.y+3, my_vehicle.z)
			weapon.projectile_pixel_offsetx = 16
			weapon.projectile_pixel_offsety = 0
		if(EAST)
			weapon.proj_start = locate(my_vehicle.x+3, my_vehicle.y+2, my_vehicle.z)
			weapon.projectile_pixel_offsetx = 0
			weapon.projectile_pixel_offsety = -16
		if(SOUTH)
			weapon.proj_start = locate(my_vehicle.x+2, my_vehicle.y+0, my_vehicle.z)
			weapon.projectile_pixel_offsetx = -16
			weapon.projectile_pixel_offsety = 0
		if(WEST)
			weapon.proj_start = locate(my_vehicle.x+0, my_vehicle.y+1, my_vehicle.z)
			weapon.projectile_pixel_offsetx = 0
			weapon.projectile_pixel_offsety = 16

		//same as cardinals because i cbb doing them exactly
		if(NORTHEAST)
			weapon.proj_start = locate(my_vehicle.x+1, my_vehicle.y+3, my_vehicle.z)
			weapon.projectile_pixel_offsetx = 16
			weapon.projectile_pixel_offsety = 0
		if(SOUTHEAST)
			weapon.proj_start = locate(my_vehicle.x+3, my_vehicle.y+2, my_vehicle.z)
			weapon.projectile_pixel_offsetx = 0
			weapon.projectile_pixel_offsety = -16
		if(SOUTHWEST)
			weapon.proj_start = locate(my_vehicle.x+2, my_vehicle.y+0, my_vehicle.z)
			weapon.projectile_pixel_offsetx = -16
			weapon.projectile_pixel_offsety = 0
		if(NORTHWEST)
			weapon.proj_start = locate(my_vehicle.x+0, my_vehicle.y+1, my_vehicle.z)
			weapon.projectile_pixel_offsetx = 0
			weapon.projectile_pixel_offsety = 16
