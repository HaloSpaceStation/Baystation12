
/obj/machinery/overmap_vehicle/proc/fire_weapon(var/atom/A, var/params, var/reset_bursts = 1)
	//world << "[usr] shooting via [src] at [A] with params [text2list(params)]"
	for(var/obj/structure/vehicle_component/weapon/weapon in selected_components)
		//world << "	[weapon] [weapon.type]"

		if(reset_bursts)
			weapon.reset_burst()
		weapon.fire(A, params)

/obj/structure/vehicle_component/weapon/proc/fire(var/atom/A, var/params)
	. = 0
	//world << "/obj/structure/vehicle_component/weapon/proc/fire([A], [params])"
	//world << "WARNING: virtual proc /obj/structure/vehicle_component/weapon/fire([A], [params2list(params)]) [src] [src.type]"
	//first check if we are able to fire...
	if(can_fire())
		. = 1
		//update the weapon position for multitile vehicles
		//there's probably a more OO friendly way to do this
		//also it doesnt need to be done every shot... optimise this out later
		my_mount.position_weapon(src)

		//different weapon types handling firing differently
		//lets only have projectiles for now
		if(projectile_type)
			fire_projectile(A, params)
			. = 2

/obj/structure/vehicle_component/weapon/proc/fire_projectile(var/atom/A, var/params)
	//world << "/obj/structure/vehicle_component/proc/fire_projectile([A], [params2list(params)]) [src] [src.type]"

	//update weapon stuff
	last_shot_time = world.time
	mag -= 1
	screen_mag.update_icon()
	heat_up(heat_per_shot)

	//handle burst fire
	if(shots_per_burst > 0)
		//next shot in the burst
		shots_this_burst += 1

		//if we've hit the limit this burst, pause for a moment
		if(shots_this_burst >= shots_per_burst)
			burst_pause_time = world.time
			shots_this_burst = 0

			//shortcut to enable cooling between bursts
			is_heating = 0

	//create the projectile
	var/obj/item/projectile/OP = new projectile_type(proj_start)
	OP.pixel_x = owned_vehicle.pixel_x + projectile_pixel_offsetx
	OP.pixel_y = owned_vehicle.pixel_y + projectile_pixel_offsety
	OP.firer = owned_vehicle
	OP.kill_count = 100
	OP.damage += shot_damage_mod

	if(params)
		OP.set_clickpoint(params)

	//this will only choose cardinals, but it's just a sanity check so it shouldn't ever happen
	/*if(!target_atom)
		world << "firing down last calculated aim angle"
		target_atom = get_step(linked, angle2dir(fire_angle))*/

	//add a bit of inaccuracy to the shots
	var/fire_angle = my_mount.my_vehicle.pixel_transform.heading
	fire_angle += rand(-projectile_angle_variance, projectile_angle_variance)

	//when we fire, slow down pixel speed to a more overmap-friendly one
	OP.launch_heading(fire_angle, projectile_pixel_speed)

/obj/structure/vehicle_component/weapon/proc/can_fire()
	//loop through all the various checks and vars in this proc
	//override in children if necessary
	if(last_shot_time + 10*(1/fire_rate) > world.time)
		return 0
	if(overheat)
		return 0
	if(is_reloading)
		return 0
	if(damage >= 100)
		return 0
	if(mag <= 0)
		return 0
	if(burst_pause_time + burst_delay*10 > world.time)
		return 0

	return 1

/obj/structure/vehicle_component/weapon/proc/heat_up(var/new_heat)
	//add some new heat and start the cooling cycle
	if(new_heat > 0)
		is_heating = 1
		heat += new_heat
		set_processing()
		screen_heat.update_icon()

		if(heat >= 100)
			overheat = 1
			screen_heat.overlays += "overheat"
			damage += rand(5,15)
			screen_dmg.update_icon()
