
/obj/machinery/overmap_vehicle/pelican
	name = "D77-TC Pelican"
	desc = "Versatile dropship and support gunship."
	icon = 'pelican.dmi'
	icon_state = "pelican"
	bound_width = 128
	bound_height = 128
	internal_cells = 16
	max_speed_hover = 16
	max_speed = 16
	yaw_speed = 5
	accel_duration = 50
	max_crew = 11

/obj/machinery/overmap_vehicle/pelican/New()
	..()
	overmap_object.icon_state = "pelican"
	vehicle_transform.overlay_thrust_base = new('pelican.dmi', "thrust1")

/obj/machinery/overmap_vehicle/pelican/health_update()
	//update damage overlays
	var/dmg_percent = 1 - (hull_remaining / hull_max)
	var/new_damage_state = 0
	if(dmg_percent >= 0.9)
		new_damage_state = 5
	else if(dmg_percent >= 0.7)
		new_damage_state = 4
	else if(dmg_percent >= 0.5)
		new_damage_state = 3
	else if(dmg_percent >= 0.3)
		new_damage_state = 2
	else if(dmg_percent >= 0)
		new_damage_state = 1

	if(new_damage_state != damage_state)
		overlays -= damage_overlay
		if(new_damage_state)
			damage_overlay = new('pelican.dmi', "dam[damage_state]")
			damage_overlay.Turn(vehicle_transform.heading)
			overlays += damage_overlay

		damage_state = new_damage_state

	//let the parent proc handle damage processing
	..()
