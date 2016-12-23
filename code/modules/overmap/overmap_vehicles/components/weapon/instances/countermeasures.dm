//treated as a weapon because duplicate functionality
//COUNTERMEASURES

/obj/structure/vehicle_component/weapon/countermeasures
	name = "countermeasures package"
	mount_size = MOUNT_SMALL
	var/spawn_effect_type
	var/thermal_interference = 1
	var/mass_interference = 1
	var/num_proj = 4
	install_requires = INSTALL_WELDED|INSTALL_CABLED||INSTALL_SCREWED|INSTALL_PIPED//INSTALL_WELDED|INSTALL_CABLED|INSTALL_BOLTED|INSTALL_SCREWED|INSTALL_PIPED
	//
	reload_time = 2
	fire_rate = 2
	heat_per_shot = 25
	mag_size = 3
	ammo_spare = 6
	ammo_name = "charges"

/obj/structure/vehicle_component/weapon/countermeasures/flare
	name = "flare countermeasures package"
	component_name = "flare countermeasures launcher"
	icon_state = "flare"
	hud_icon_state = "flare"
	thermal_interference = 3
	spawn_effect_type = /obj/item/device/flashlight/flare/on//obj/effect/effect/sparks

/obj/structure/vehicle_component/weapon/countermeasures/chaff
	name = "chaff countermeasures package"
	component_name = "chaff countermeasures launcher"
	icon_state = "chaff"
	hud_icon_state = "chaff"
	mass_interference = 3
	spawn_effect_type = /obj/effect/effect/smoke

/obj/structure/vehicle_component/weapon/countermeasures/fire(var/atom/A, var/params)
	if(..())
		//update weapon stuff
		last_shot_time = world.time
		mag -= 1
		screen_mag.update_icon()
		heat_up(heat_per_shot)

		//world << "/obj/structure/vehicle_component/weapon/countermeasures/fire([A], [params])"

		//setup a graphical effect to show we triggered countermeasures
		if(spawn_effect_type)
			var/turf_width = Ceiling(owned_vehicle.bound_width / 32)
			var/turf_height = Ceiling(owned_vehicle.bound_height / 32)

			var/turf/spawn_turf = locate(owned_vehicle.x, owned_vehicle.y, owned_vehicle.z)
			var/atom/movable/effect1 = PoolOrNew(spawn_effect_type, spawn_turf)
			//effect1.loc = spawn_turf
			//world << "	[effect1] [effect1.type] ([effect1.x],[effect1.y],[effect1.z])"
			//world << "		[spawn_turf] [spawn_turf.type] ([spawn_turf.x],[spawn_turf.y],[spawn_turf.z])"
			spawn(0)
				while(effect1 && effect1.loc)
					step(effect1, SOUTHWEST)
					sleep(2)
			spawn(20)
				qdel(effect1)
			//
			spawn_turf = locate(owned_vehicle.x, owned_vehicle.y + turf_height, owned_vehicle.z)
			var/atom/movable/effect2 = PoolOrNew(spawn_effect_type, spawn_turf)
			//effect2.loc = spawn_turf
			//world << "	[effect2] [effect2.type] [effect2.loc] ([effect2.x],[effect2.y],[effect2.z])"
			//world << "		[spawn_turf] [spawn_turf.type] ([spawn_turf.x],[spawn_turf.y],[spawn_turf.z])"
			spawn(0)
				while(effect2 && effect2.loc)
					step(effect2, NORTHWEST)
					sleep(2)
			spawn(20)
				qdel(effect2)
			//
			spawn_turf = locate(owned_vehicle.x + turf_width, owned_vehicle.y, owned_vehicle.z)
			var/atom/movable/effect3 = PoolOrNew(spawn_effect_type, spawn_turf)
			//effect3.loc = spawn_turf
			//world << "	[effect3] [effect3.type] [effect3.loc] ([effect3.x],[effect3.y],[effect3.z])"
			//world << "		[spawn_turf] [spawn_turf.type] ([spawn_turf.x],[spawn_turf.y],[spawn_turf.z])"
			spawn(0)
				while(effect3 && effect3.loc)
					step(effect3, SOUTHEAST)
					sleep(2)
			spawn(20)
				qdel(effect3)
			//
			spawn_turf = locate(owned_vehicle.x + turf_width, owned_vehicle.y + turf_height, owned_vehicle.z)
			var/atom/movable/effect4 = PoolOrNew(spawn_effect_type, spawn_turf)
			//effect4.loc = spawn_turf
			//world << "	[effect4] [effect4.type] [effect4.loc] ([effect4.x],[effect4.y],[effect4.z])"
			//world << "		[spawn_turf] [spawn_turf.type] ([spawn_turf.x],[spawn_turf.y],[spawn_turf.z])"
			spawn(0)
				while(effect4 && effect4.loc)
					step(effect4, NORTHEAST)
					sleep(2)
			spawn(20)
				qdel(effect4)

		//interfere with any missiles nearby
		var/total_interference = thermal_interference + mass_interference
		for(var/obj/item/projectile/missile/M in view(14, owned_vehicle))
			//just blow em up for now, we can worry about other fuckery once we have actual guided/tracking/homing missiles
			var/total_pierce = M.sensors_thermal + M.sensors_mass
			var/chance = 100 * (total_interference / (total_pierce + total_interference))
			//world << "checking CM interference of [M] with prob [chance]%"
			if(!total_pierce || prob(chance))
				//kablooey
				var/turf/T = M.loc
				qdel(M)
				explosion(T, M.expl_range-4, M.expl_range-2, M.expl_range, M.expl_range, 0)
