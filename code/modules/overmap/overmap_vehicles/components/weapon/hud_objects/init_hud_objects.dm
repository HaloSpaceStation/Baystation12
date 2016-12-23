
/obj/structure/vehicle_component/weapon/init_hud_objects()
	..()

	//select_box.icon.Blend(rgb(0,0,255,128))
	//
	screen_mag = new(owned_vehicle, src)
	screen_ammo = new(owned_vehicle, src)
	screen_cyclegroup = new(owned_vehicle, src)
	screen_firemode = new(owned_vehicle, src)
	screen_dmg = new(owned_vehicle, src)
	screen_heat = new(owned_vehicle, src)

	hud_objects += screen_icon
	hud_objects += screen_mag
	hud_objects += screen_ammo
	hud_objects += screen_cyclegroup
	hud_objects += screen_firemode
	hud_objects += screen_dmg
	hud_objects += screen_heat
