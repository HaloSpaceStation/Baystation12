

//ship mounted turret weaponry

/obj/machinery/overmap_turret
	name = "heavy turret"
	desc = "A heavy weapon mounted on a turret for ships or stations."
	anchored = 1
	density = 1
	icon = 'overmap_turrets.dmi'
	var/miss_arc = 0	//inaccuracy in degrees
	var/turret_id
	var/obj/machinery/overmap_turret_controlseat/owned_controller
	var/aim_angle = 0
	var/fire_arc_type = 0	//0 = straight line
							//1 = 15 degree cone
							//2 = 45 degree cone
							//3 = 90 degree cone
							//4 = 135 degree cone
	var/continuous_firing = 0
	var/projectile_type
	var/degrees_inaccurate = 0

	var/overmap_projectile_type
	var/overmap_range = 14
	var/overmap_pixel_speed = 5

	var/icon/crosshairs_icon
	var/image/crosshairs
	//
	var/overlay_angle = -1
	var/icon/target_overlay_icon
	var/image/target_overlay

	var/mob/living/control_mob
	var/obj/effect/map/ship/linked

	var/obj/item/projectile/overmap/last_fired_overmap_projectile

/obj/machinery/overmap_turret/initialize()
	linked = map_sectors["[src.z]"]

	if(linked)
		linked.my_turrets += src

	aim_angle = dir2angle(dir)
	rebuild_images()

	processing_objects.Add(src)

	//make sure we have a valid fir arc type for our targetting overlay
	fire_arc_type = round(fire_arc_type)
	if(fire_arc_type > 4)
		fire_arc_type = 4
	if(fire_arc_type < 0)
		fire_arc_type = 0

	//create the icon we will use
	target_overlay_icon = new/icon('overmap_turrets.dmi', "target_overlay[fire_arc_type]")

/obj/machinery/overmap_turret/proc/rebuild_images()

	//if overmap isnt setup for this zlevel, we wont need any targetting overlays
	if(!linked)
		return

	//create a virtual image to represent the firing arc for our turret
	target_overlay = image(target_overlay_icon, linked)

	//have it appear under the ship so it doesn't block anything important
	target_overlay.layer = TURF_LAYER + 0.1

	//make sure the overlay turns with the ship, and make it twice the size of the ship
	var/matrix/M = target_overlay.transform
	M.Turn(dir2angle(src.dir) + linked.get_heading())
	M.Scale(2)
	target_overlay.transform = M

/obj/machinery/overmap_turret/proc/rotate_targetting_overlay(var/amount_to_rotate = 0)
	//to save overhead, only rotate the targetting overlay with the ship if someone is manning the turret
	if(control_mob && target_overlay && amount_to_rotate)
		var/matrix/M = target_overlay.transform
		M.Turn(amount_to_rotate)
		target_overlay.transform = M

/obj/machinery/overmap_turret/process()
	//check if the gunner has stopped gunning without telling us
	if(control_mob)
		if(!control_mob.client || !linked || control_mob.client.eye != linked)
			take_control(null)

/obj/machinery/overmap_turret/proc/take_control(var/mob/living/M)
	//if someone is already controlling the turret, get rid of them
	if(control_mob)
		control_mob.unset_machine()
		control_mob.reset_view(null, 0)
		if(control_mob.client)
			control_mob.client.images -= target_overlay
			control_mob.client.mouse_pointer_icon = null
		if(linked)
			linked.my_observers.Remove(control_mob)		//so we can avoid doubleups
		control_mob = null

	//setup the view for the new controller
	if(M)
		control_mob = M
		if(control_mob.client)
			rebuild_images()
			control_mob.client.images += target_overlay
			if(owned_controller)
				control_mob.client.mouse_pointer_icon = owned_controller.crosshair_icon
		if(linked)
			control_mob.reset_view(linked, 0)
			linked.my_observers.Remove(control_mob)		//so we can avoid doubleups
			linked.my_observers.Add(control_mob)

/obj/machinery/overmap_turret/proc/get_max_fire_angle(var/arc_type = 0)
	switch(arc_type)
		if(1)
			return 15
		if(2)
			return 45
		if(3)
			return 90
		if(4)
			return 135

	return 0

/obj/machinery/overmap_turret/verb/force_fire()
	set category = "Force fire overmap turret"
	set src in range(7)

	fire()

/obj/machinery/overmap_turret/proc/fire(var/atom/target_atom, var/params)
	if(!projectile_type)
		return

	var/fire_angle = aim_angle
	var/max_fire_angle = get_max_fire_angle(fire_arc_type)

	//constrain the aiming to match the weapon cone
	var/centre_angle = dir2angle(dir)
	if(linked)
		centre_angle += linked.get_heading()
		if(centre_angle >= 360)
			centre_angle -= 360
		else if(centre_angle < 0)
			centre_angle += 360

	//adjust our point of reference so that we don't have odd edge cases with values near 0 or 360
	var/adjusted_aim_angle = aim_angle
	if(adjusted_aim_angle > 180)
		adjusted_aim_angle -= 360
	var/adjusted_centre_angle = centre_angle
	if(adjusted_centre_angle > 180)
		adjusted_centre_angle -= 360

	if(adjusted_aim_angle > adjusted_centre_angle + (max_fire_angle / 2))
		//aiming too far clockwise
		//world << "aiming too far clockwise with fire_angle [fire_angle]"
		fire_angle = centre_angle + (max_fire_angle / 2)
		if(fire_angle > 360)
			fire_angle -= 360
		//world << "	new fire_angle [fire_angle]"

	if(adjusted_aim_angle  < adjusted_centre_angle - (max_fire_angle / 2))
		//aiming too far counterclockwise
		//world << "aiming too far counterclockwise with fire_angle [fire_angle]"
		fire_angle = centre_angle - (max_fire_angle / 2)
		if(fire_angle < 0)
			fire_angle += 360
		//world << "	new fire_angle [fire_angle]"

	var/obj/item/projectile/P = new projectile_type(src.loc)

	//due to distances involved, from the gunner's perspective the projectile will just go straight away from the ship
	var/turf/target_turf = get_step(src, dir)
	P.launch(target_turf)

	//no sound in space... but the turret can still fire if it's in a pressurised area
	playsound(src, "sound/weapons/pulse.ogg", 100, 1)

	//check if some part of the ship is blocking the way
	if(linked && overmap_projectile_type && !check_blocked_forward())
		//fire an equivalent shot on the overmap
		//target_turf = get_step(linked.loc, dir)
		var/obj/item/projectile/overmap/OP = new overmap_projectile_type(linked.loc)
		OP.pixel_x = linked.pixel_x
		OP.pixel_y = linked.pixel_y
		last_fired_overmap_projectile = OP
		OP.firer = linked
		OP.kill_count = overmap_range

		if(params)
			OP.set_clickpoint(params)

		//this will only choose cardinals, but it's just a sanity check so it shouldn't ever happen
		/*if(!target_atom)
			world << "firing down last calculated aim angle"
			target_atom = get_step(linked, angle2dir(fire_angle))*/

		//add a bit of inaccuracy to the shots
		fire_angle += rand(0, degrees_inaccurate) - degrees_inaccurate / 2

		//when we fire, slow down pixel speed to a more overmap-friendly one
		OP.launch_heading(fire_angle, overmap_pixel_speed)

/obj/machinery/overmap_turret/proc/halt_fire()
	if(continuous_firing)
		continuous_firing = 0

/obj/machinery/overmap_turret/proc/check_blocked_forward()
	//make sure our projectiles have a clear path to the edge of the map
	var/turf/cur_turf = get_step(src.loc, dir)
	var/turf/next_turf
	while(cur_turf)
		next_turf = get_step(cur_turf, dir)
		if(next_turf && !cur_turf.CanPass(src, next_turf))
			break
		cur_turf = get_step(cur_turf, dir)

	return cur_turf

/obj/machinery/overmap_turret/machineClickOn(var/atom/A, var/params)
	. = 0
	if(linked && A.z == linked.z)
		. = 1
		aim_angle = Get_Angle(linked, A)

		var/click_pixel_x = 0
		var/click_pixel_y = 0

		if(params)
			var/list/mouse_control = params2list(params)
			if(mouse_control["icon-x"])
				click_pixel_x = text2num(mouse_control["icon-x"])
			if(mouse_control["icon-y"])
				click_pixel_y = text2num(mouse_control["icon-y"])

		//world << "click_pixel_x: [click_pixel_x] click_pixel_y: [click_pixel_y]"
		var/dy = (32 * A.y + click_pixel_y - 16) - (32 * linked.y + linked.pixel_y)
		var/dx = (32 * A.x + click_pixel_x - 16) - (32 * linked.x + linked.pixel_x)

		if(!dy)
			aim_angle = (dx >= 0) ? 90 : 270
		else
			aim_angle = arctan(dx / dy)

		if(dy < 0)
			aim_angle += 180
		else if(dx < 0)
			aim_angle += 360

		fire(A, params)
