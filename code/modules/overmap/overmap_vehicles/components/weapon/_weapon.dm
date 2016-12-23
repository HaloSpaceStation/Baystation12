/obj/structure/vehicle_component/weapon
	name = "fighter mounted component"
	mount_type = MOUNT_EXT
	mount_size = MOUNT_LARGE

	install_requires = INSTALL_WELDED|INSTALL_CABLED||INSTALL_SCREWED//INSTALL_WELDED|INSTALL_CABLED|INSTALL_BOLTED|INSTALL_SCREWED|INSTALL_PIPED

	var/turf/proj_start
	var/projectile_pixel_offsetx = 0
	var/projectile_pixel_offsety = 0
	var/projectile_type
	var/projectile_pixel_speed = 32
	var/projectile_angle_variance = 0

	var/mag = 0
	var/mag_size = 0
	//var/obj/vehicle_hud/screen_mag_text

	var/ammo_spare = 0
	var/ammo_name = "rounds"

	var/obj/vehicle_hud/reload/screen_mag
	var/obj/vehicle_hud/ammo/screen_ammo
	var/obj/vehicle_hud/cycle_component_group/screen_cyclegroup
	var/obj/vehicle_hud/firemode/screen_firemode
	var/obj/vehicle_hud/wep_temp/screen_heat
	var/obj/vehicle_hud/wep_dmg/screen_dmg

	var/fire_mode = 1
	var/num_firemodes = 1

	var/reload_time = 1		//seconds
	var/fire_rate = 1		//per second
	var/is_reloading = 0

	var/heat = 0			//up to 100 max
	var/heat_per_shot = 0	//per shot
	var/is_heating = 0
	var/overheat = 0

	var/shots_per_burst = 0
	var/shots_this_burst = 0
	var/burst_delay = 0
	var/burst_pause_time = 0
	var/last_shot_time = 0

	var/shot_damage_mod = 0		//added to the projectile damage

/obj/structure/vehicle_component/weapon/New()
	mag = mag_size
	..()

/*/obj/structure/vehicle_component/weapon/proc/update_mag_text()
	//tell the player how many shots are left
	screen_mag_text.maptext = "<div style=\"[HUD_CSS_STYLE]\">[mag]/[mag_size]</div>"*/

/obj/structure/vehicle_component/weapon/update_screen()
	..()

	screen_mag.screen_loc = "[1+screenpos_offsetx],[1+screenpos_offsety]"
	screen_ammo.screen_loc = "[2+screenpos_offsetx],[1+screenpos_offsety]"
	screen_cyclegroup.screen_loc = "[3+screenpos_offsetx],[1+screenpos_offsety]"
	screen_firemode.screen_loc = "[4+screenpos_offsetx],[1+screenpos_offsety]"
	//
	screen_dmg.screen_loc = "[2+screenpos_offsetx],[2+screenpos_offsety]"
	screen_heat.screen_loc = "[3+screenpos_offsetx],[2+screenpos_offsety]"

/obj/structure/vehicle_component/weapon/proc/cycle_firemode()
	//let the children handle the different stuff
	if(num_firemodes > 1)
		fire_mode += 1
		if(fire_mode > num_firemodes)
			fire_mode = 1
		apply_firemode()
		return 1

	return 0

/obj/structure/vehicle_component/weapon/proc/apply_firemode()
	//override in children
	return 0

/obj/structure/vehicle_component/weapon/proc/get_firemode_maptext()
	return "- -"

/obj/structure/vehicle_component/weapon/proc/get_firemode_name()
	return "default"

/obj/structure/vehicle_component/weapon/set_vehicle(var/obj/machinery/overmap_vehicle/overmap_vehicle)
	. = ..()
	if(.)
		//most of these might not need to know about the vehicle, but this is good practice anyway
		screen_mag.my_vehicle = overmap_vehicle
		screen_ammo.my_vehicle = overmap_vehicle
		screen_cyclegroup.my_vehicle = overmap_vehicle
		screen_firemode.my_vehicle = overmap_vehicle
		screen_heat.my_vehicle = overmap_vehicle
		screen_dmg.my_vehicle = overmap_vehicle

