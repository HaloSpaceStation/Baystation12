
/datum/vehicle_mount/fourbyfour/centre
	mount_type = MOUNT_EXT

/datum/vehicle_mount/fourbyfour/centre/dorsal
	name = "Dorsal (spine)"
	name_abbr = "DORS"
	mount_size = MOUNT_LARGE

/datum/vehicle_mount/fourbyfour/centre/ventral
	name = "Ventral (belly)"
	name_abbr = "VENT"
	mount_size = MOUNT_LARGE

/datum/vehicle_mount/fourbyfour/centre/left
	name = "Right Chassis"
	name_abbr = "CHAS (R)"
	mount_size = MOUNT_SMALL

/datum/vehicle_mount/fourbyfour/centre/right
	name = "Left Chassis"
	name_abbr = "CHAS (L)"
	mount_size = MOUNT_SMALL

/datum/vehicle_mount/fourbyfour/centre/position_weapon(var/obj/structure/vehicle_component/weapon/weapon)
	//easy - same position whichever way we face
	weapon.proj_start = locate(my_vehicle.x+1, my_vehicle.y+1, my_vehicle.z)
	weapon.projectile_pixel_offsetx = 16
	weapon.projectile_pixel_offsety = 16
