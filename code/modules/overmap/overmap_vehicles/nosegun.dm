
/obj/machinery/overmap_vehicle/longsword/var/projectile_pixel_speed = 64

//this is all basically just a hack for the pre-alpha stream
//it'll need to be split off into a subclass of overmap_vehicle_component eventually to make the code generic
/obj/machinery/overmap_vehicle/longsword/machineClickOn(var/atom/A, var/params)

	. = 1

	/*
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
		*/

	//fire(A, params)

	//no sound in space... but the turret can still fire if it's in a pressurised area
	playsound(src, "sound/weapons/pulse.ogg", 100, 1)

	//target_turf = get_step(linked.loc, dir)
	next_shot_loc += 1
	if(next_shot_loc > 3)
		next_shot_loc = 0
	var/turf/start_turf
	if(next_shot_loc == 0)
		start_turf = locate(src.x + 1, src.y + 2, src.z)
	else if(next_shot_loc == 1)
		start_turf = locate(src.x + 2, src.y + 1, src.z)
	else if(next_shot_loc == 2)
		start_turf = locate(src.x + 2, src.y + 2, src.z)
	else
		start_turf = locate(src.x + 1, src.y + 1, src.z)

	if(!start_turf)
		start_turf = src.loc
	var/obj/item/projectile/autocannon50/OP = new (start_turf)
	OP.pixel_x = src.pixel_x
	OP.pixel_y = src.pixel_y
	OP.firer = src
	OP.kill_count = 100

	if(params)
		OP.set_clickpoint(params)

	//this will only choose cardinals, but it's just a sanity check so it shouldn't ever happen
	/*if(!target_atom)
		world << "firing down last calculated aim angle"
		target_atom = get_step(linked, angle2dir(fire_angle))*/

	//add a bit of inaccuracy to the shots
	var/fire_angle = vehicle_transform.heading
	fire_angle += rand(0, 4) - 2

	//when we fire, slow down pixel speed to a more overmap-friendly one
	OP.launch_heading(fire_angle, projectile_pixel_speed)
