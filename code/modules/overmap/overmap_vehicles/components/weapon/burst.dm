
/obj/structure/vehicle_component/weapon/proc/reset_weapon_bursts()
	//reset bursts for all weapons
	for(var/datum/vehicle_mount/mount in owned_vehicle.system_mounts)
		var/obj/structure/vehicle_component/weapon/weapon = owned_vehicle.system_mounts[mount]
		weapon.reset_burst()

/obj/structure/vehicle_component/weapon/proc/reset_burst()
	shots_this_burst = 0
	burst_pause_time = 0
