
/obj/vehicle_hud/hud_waypoint/proc/update_overlay_megamap(var/screen_width = 7)
	var/turf/source_center_turf = get_waypoint_center_turf()
	screen_loc = "5:[round(672 * source_center_turf.x / 255)],5:[round(672 * source_center_turf.y / 255)]"
	//src.dir = waypoint.get_headingdir()

	//update the facing
	var/matrix/M = matrix()
	M.Turn(waypoint.get_heading())
	object_image.transform = M
	if(source_image)
		source_image.transform = M

/obj/vehicle_hud/hud_waypoint/proc/update_overlay(var/screen_width = 7)
	//world << "update_overlay([screen_width]) usr: [usr]"
	//get the tracked atom so we can access its coords
	var/turf/source_center_turf = get_waypoint_center_turf()
	if(!source_center_turf)
		testing("ERROR: /datum/hud_waypoint/proc/update_overlay() belonging to [owner] can't find source_center_turf")
	var/turf/owner_center_turf = atom_center_turf(owner)
	if(!owner_center_turf)
		testing("ERROR: /datum/hud_waypoint/proc/update_overlay() belonging to [owner] can't find owner_center_turf")
	var/atom/source_atom = waypoint.get_source()
	/*var/pixel_offset_x = 0
	var/pixel_offset_y = 0*/
	if(!source_atom)
		//dont have one, so we'll just use the turf at the static coords given
		source_atom = source_center_turf
		/*pixel_offset_x = get_center_pixel_offsetx(source_atom)
		pixel_offset_y = get_center_pixel_offsety(source_atom)*/

	var/actual_dist = get_dist(owner, source_atom)
	var/onscreen_dist = screen_width > waypoint.onscreen_dist ? screen_width : waypoint.onscreen_dist
	if(actual_dist <= onscreen_dist)

		pointer_image.alpha = 0
		object_image.alpha = 0
		//source_image.alpha = 0
		//src.invisibility = 101

		/*
		//if the tracked vehicle is onscreen, hide the arrow
		//and put the image with its sensor icon overlay directly on top of the tracked object
		//note that this won't hide the overlay'd vehicle icon because it doesn't inherit alpha from this base image
		pointer_image.alpha = 0

		//check if they're actually in view (usually should be, but not always)
		var/source_center_viewable = (source_center_turf in view(owner, screen_width))
		var/source_viewable = (source_atom in view(owner, screen_width))
		if(source_center_viewable && source_viewable)
			/*object_image.loc = source_atom
			object_image.pixel_x = pixel_offset_x
			object_image.pixel_y = pixel_offset_y*/
			object_image.alpha = 0
		else
			//if something is blocking sight, calculate the position relative to the player so its still visible
			//note: this will have the image "jittering" around a bit as the owner moves, but its better than the sensor overlay being blocked by LOS
			//i know one way to fix this but i'm going to leave it until i come up with a more processor light method

			object_image.alpha = 255
			//object_image.loc = owner
			var/relx = (source_center_turf.x - owner_center_turf.x)
			var/rely = (source_center_turf.y - owner_center_turf.y)
			//
			var/pixel_posx = round(relx * 32 + pixel_offset_x)
			var/pixel_posy = round(rely * 32 + pixel_offset_y)
			screen_loc = "CENTER:[pixel_posx],CENTER:[pixel_posy]"
			/*object_image.pixel_x = pixel_posx
			object_image.pixel_y = pixel_posy*/
			*/

	else

		//turn the image in the direction the ship is facing
		var/matrix/M = matrix()
		M.Turn(waypoint.get_heading())
		source_image.transform = M
		//source_image.alpha = 255
		object_image.transform = M

		//point the arrow towards the ship
		//pointer_image.dir = get_dir(owner_center_turf, source_center_turf)	//faster but will never return cardinals
		var/rel_angle = Get_Angle(owner_center_turf, source_center_turf)		//slower but more accurate
		//world << "	owner_center_turf:([owner_center_turf.x],[owner_center_turf.y]) source_center_turf:([source_center_turf.x],[source_center_turf.y]) rel_angle:[rel_angle]"
		//pointer_image.dir = angle2dir(rel_angle)
		M = matrix()
		M.Turn(rel_angle + 180)
		pointer_image.transform = M

		//work out relative screen location in -1 to 1, where 0 we are on top of each other and -1 or 1 we are on opposite edges of the map
		var/relx = (source_center_turf.x - owner_center_turf.x)
		var/rely = (source_center_turf.y - owner_center_turf.y)

		/*
		if(abs(relx) > abs(rely))
			relx = 1 * (relx > 0 ? 1 : -1)
			rely = 2 * (rely / source_center_turf.y) - 1
		else
			relx = 2 * (relx / source_center_turf.x) - 1
			rely = 1 * (rely > 0 ? 1 : -1)
		*/

		//these make the waypoints "float" towards center of the screen as you fly closer
		//setting either to 1 or -1 will make the icon hug that side of the screen
		//im making them hug the side of the screen for now because freeform floating seems a bit unintuitive
		if(rel_angle < 45)
			//top right corner of screen
			rely = 1
			relx = (rel_angle) / 45
		else if (rel_angle < 135)
			//right side of screen
			relx = 1
			rely = -2 * (rel_angle - 45) / 90 + 1
		else if (rel_angle < 225)
			//bottom side of screen
			rely = -1
			relx = -2 * (rel_angle - 135) / 90 + 1
		else if(rel_angle < 315)
			//left side of screen
			relx = -1
			rely = 2 * (rel_angle - 225) / 90 - 1
		else
			//top left corner of screen
			rely = 1
			relx = (rel_angle - 315) / 45 - 1

		//have the icons float towards the side of the screen where the vehicle is on
		//4 tile margin around the edges of the screen for the HUD
		var/pixel_posx = round(relx * (screen_width - 4) * 32)// + get_center_pixel_offsetx(owner))
		var/pixel_posy = round(rely * (screen_width - 4) * 32)// + get_center_pixel_offsety(owner))

		//finally update the position
		screen_loc = "CENTER+0:[pixel_posx],CENTER+0:[pixel_posy]"

		//make sure they're both visible
		pointer_image.alpha = 255
		object_image.alpha = 255
		//src.invisibility = 0

	//world << "	relx:[relx] rely:[rely]"

	/*object_image.loc = owner
	object_image.pixel_x = pixel_posx
	object_image.pixel_y = pixel_posy*/
	//
	/*pointer_image.loc = object_image.loc
	pointer_image.pixel_x = object_image.pixel_x
	pointer_image.pixel_y = object_image.pixel_y*/
