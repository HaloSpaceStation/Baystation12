
//ASGM-10 MISSILES
//Air-Space-Ground Missiles with a variety of different modes
//A jack of all trades with average stats and capable of multiple uses

/obj/structure/vehicle_component/weapon/missilerack_asgm
	name = "fighter mounted missile rack"
	component_name = "ASGM-10 missile launcher"
	icon_state = "missilerack"
	hud_icon_state = "rocket"
	install_requires = INSTALL_WELDED|INSTALL_CABLED||INSTALL_SCREWED|INSTALL_PIPED|INSTALL_BOLTED//INSTALL_WELDED|INSTALL_CABLED|INSTALL_BOLTED|INSTALL_SCREWED|INSTALL_PIPED
	mag_size = 1
	ammo_spare = 3
	reload_time = 4
	fire_rate = 0.5
	heat_per_shot = 10
	num_firemodes = 2
	projectile_pixel_speed = 24
	//
	required_mount_types = list(\
		/datum/vehicle_mount/fourbyfour/right,\
		/datum/vehicle_mount/fourbyfour/left,\
		/datum/vehicle_mount/fourbyfour/centre/dorsal,\
		/datum/vehicle_mount/fourbyfour/centre/ventral,\
	)
	//
	var/obj/machinery/overmap_vehicle/locked_vehicle

/obj/structure/vehicle_component/weapon/missilerack_asgm/apply_firemode()
	switch(fire_mode)
		if(1)
			projectile_type = null
		if(2)
			projectile_type = /obj/item/projectile/missile/asgm10

/obj/structure/vehicle_component/weapon/missilerack_asgm/get_firemode_maptext()
	switch(fire_mode)
		if(1)
			return "TRK"
		if(2)
			return "DMB"

/obj/structure/vehicle_component/weapon/missilerack_asgm/get_firemode_name()
	switch(fire_mode)
		if(1)
			return "starfighter tracking"
		if(2)
			return "dumbfire"

/obj/structure/vehicle_component/weapon/missilerack_asgm/fire(var/atom/A, var/params)
	if(..() == 1)
		if(locked_vehicle)
			usr << "Firing at [locked_vehicle]"
		else
			usr << "\icon[src] <span class='warning'>[src] cannot fire in this mode without locking on first!</span> (disabled for HS13-ALPHA)"
