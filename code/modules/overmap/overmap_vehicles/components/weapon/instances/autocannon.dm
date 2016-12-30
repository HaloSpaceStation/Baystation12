
//AUTO CANNON
//Slow fire rate, medium-high damage, high AP, high(er) accuracy
//A high damage punch to a vulnerable target

/obj/structure/vehicle_component/weapon/autocannon
	name = "fighter mounted auto cannon"
	component_name = "120mm autocannon"
	icon_state = "autocannon"
	hud_icon_state = "120mm"
	//
	mag_size = 10
	ammo_spare = 100
	num_firemodes = 3
	//
	reload_time = 3
	fire_rate = 1.5
	heat_per_shot = 7
	burst_delay = 2
	//
	projectile_angle_variance = 0.5
	projectile_pixel_speed = 48
	projectile_type = /obj/item/projectile/autocannon120
	//
	required_mount_types = list(\
		/datum/vehicle_mount/fourbyfour/right,\
		/datum/vehicle_mount/fourbyfour/left,\
		/datum/vehicle_mount/fourbyfour/centre/dorsal,\
		/datum/vehicle_mount/fourbyfour/centre/ventral,\
	)

/obj/structure/vehicle_component/weapon/autocannon/apply_firemode()
	switch(fire_mode)
		if(1)
			projectile_angle_variance = 0.5
			fire_rate = 1.5
			heat_per_shot = 7
			shots_per_burst = 0
			projectile_pixel_speed = 48
			shot_damage_mod = 0
		if(2)
			projectile_angle_variance = 3
			fire_rate = 10
			heat_per_shot = 9
			shots_per_burst = 2
			projectile_pixel_speed = 48
			shot_damage_mod = 0
		if(3)
			projectile_angle_variance = 0
			fire_rate = 0.5
			heat_per_shot = 20
			shots_per_burst = 0
			projectile_pixel_speed = 64
			shot_damage_mod = 200

/obj/structure/vehicle_component/weapon/autocannon/get_firemode_maptext()
	switch(fire_mode)
		if(1)
			return "S"
		if(2)
			return "2B"
		if(3)
			return "MAG"

/obj/structure/vehicle_component/weapon/autocannon/get_firemode_name()
	switch(fire_mode)
		if(1)
			return "sustained"
		if(2)
			return "2 shot burst"
		if(3)
			return "magnetic accelerated"
