
/obj/machinery/overmap_vehicle/longsword
	name = "GA-TL1 Longsword"
	desc = "Standard UNSC multirole starfighter"
	icon = 'code/modules/overmap/overmap_vehicles/icons/longsword.dmi'
	icon_state = "longsword"
	bound_width = 128
	bound_height = 128
	yaw_speed = 10
	accel_duration = 50
	sensor_icon_state = "longsword"
	iff_faction_broadcast = "UNSC"
	nosegun_enabled = 1

/obj/machinery/overmap_vehicle/longsword/New()
	..()
	overmap_object.icon_state = "longsword"
	pixel_transform.icon_state_thrust = "longsword_thruster"

/obj/machinery/overmap_vehicle/longsword/health_update()
	//update damage overlays
	var/dmg_percent = 1 - (hull_remaining / hull_max)
	var/new_damage_state = 0
	if(dmg_percent >= 0.7)
		new_damage_state = 4
	else if(dmg_percent >= 0.5)
		new_damage_state = 3
	else if(dmg_percent >= 0.3)
		new_damage_state = 2
	else if(dmg_percent >= 0.1)
		new_damage_state = 1

	if(new_damage_state != damage_state)
		overlays -= damage_overlay
		if(new_damage_state)
			damage_overlay = new('code/modules/overmap/overmap_vehicles/icons/longsword.dmi', "dam[damage_state]")
			overlays += damage_overlay

		damage_state = new_damage_state

	//let the parent proc handle damage processing
	..()
