
//ROTARY CANNON
//Fast fire rate, low-medium damage
//Weapon of choice against fast targets

/obj/structure/vehicle_component/weapon/rotarycannon
	name = "fighter mounted rotary cannon"
	component_name = "110mm rotary cannon"
	icon_state = "rotarycannon"
	hud_icon_state = "110mmrotary"
	//
	mag_size = 15
	ammo_spare = 150
	num_firemodes = 3
	//
	reload_time = 2
	fire_rate = 5
	heat_per_shot = 4
	burst_delay = 1
	//
	projectile_angle_variance = 3
	projectile_type = /obj/item/projectile/rotary110
	//
	required_mount_types = list(\
		/datum/vehicle_mount/fourbyfour/right,\
		/datum/vehicle_mount/fourbyfour/left,\
		/datum/vehicle_mount/fourbyfour/centre/dorsal,\
		/datum/vehicle_mount/fourbyfour/centre/ventral,\
	)

/obj/structure/vehicle_component/weapon/rotarycannon/apply_firemode()
	switch(fire_mode)
		if(1)
			projectile_angle_variance = 3
			fire_rate = 5
			heat_per_shot = 4
			shots_per_burst = 0
		if(2)
			projectile_angle_variance = 4
			fire_rate = 10
			heat_per_shot = 6
			shots_per_burst = 3

		if(3)
			projectile_angle_variance = 5
			fire_rate = 15
			heat_per_shot = 7
			shots_per_burst = 0

/obj/structure/vehicle_component/weapon/rotarycannon/get_firemode_maptext()
	switch(fire_mode)
		if(1)
			return "S"
		if(2)
			return "3B"
		if(3)
			return "FA"

/obj/structure/vehicle_component/weapon/rotarycannon/get_firemode_name()
	switch(fire_mode)
		if(1)
			return "sustained"
		if(2)
			return "three shot burst"
		if(3)
			return "full-auto"
