
/datum/hud_waypoint
	var/image/pointer_image
	var/image/object_image
	var/image/upper_underlay
	var/image/lower_underlay

	var/datum/waypoint/waypoint

/datum/hud_waypoint/New(var/datum/waypoint/new_waypoint, var/owner_faction)
	waypoint = new_waypoint

	var/image_icon = waypoint.get_icon()

	var/object_icon_state = waypoint.get_icon_state()
	if(!object_icon_state)
		object_icon_state = "unknown"

	//the stylised sprite representing the object on sensors
	object_image = image(image_icon, src, object_icon_state, 10.3)
	object_image.appearance_flags = RESET_TRANSFORM|RESET_COLOR|RESET_ALPHA
	object_image.loc = new_waypoint.get_spawn_loc()

	//animated arrows indicating the object is above or below the player in a sector
	upper_underlay = image(image_icon, src, "dirpointer_up", 10.2)
	upper_underlay.appearance_flags = RESET_TRANSFORM|RESET_COLOR|RESET_ALPHA
	//
	lower_underlay = image(image_icon, src, "dirpointer_down", 10.2)
	lower_underlay.appearance_flags = RESET_TRANSFORM|RESET_COLOR|RESET_ALPHA

	//an arrow pointing in its direction
	var/pointer_icon_state = "dirpointer"
	pointer_image = image(image_icon, src, pointer_icon_state, 10.1)
	pointer_image.appearance_flags = RESET_TRANSFORM|RESET_COLOR|RESET_ALPHA

	var/image_colour = get_colour(owner_faction, 1)
	set_colour(image_colour)

//override in children
/datum/hud_waypoint/proc/get_waypoint_center_turf()
	return waypoint.get_center_turf()

//override in children
/datum/hud_waypoint/proc/get_waypoint_atom()
	return waypoint.overmapobj

/datum/hud_waypoint/var/override_dist = 0

/datum/hud_waypoint/proc/update_overlay(var/atom/movable/owner, var/screen_width = 7)
	//get the tracked atom so we can access its coords
	var/turf/source_center_turf = get_waypoint_center_turf()
	if(!source_center_turf)
		testing("ERROR: /datum/hud_waypoint/proc/update_overlay() belonging to [owner] can't find source_center_turf")
	var/turf/owner_center_turf = atom_center_turf(owner)
	if(!owner_center_turf)
		testing("ERROR: /datum/hud_waypoint/proc/update_overlay() belonging to [owner] can't find owner_center_turf")
	var/atom/source_atom = get_waypoint_atom()
	var/pixel_offset_x = 0
	var/pixel_offset_y = 0
	if(source_atom)
		pixel_offset_x = get_center_pixel_offsetx(source_atom)
		pixel_offset_y = get_center_pixel_offsety(source_atom)
	else
		//dont have one, so we'll just use the turf at the static coords given
		source_atom = source_center_turf

	var/actual_dist = get_dist(owner, source_atom)
	var/onscreen_dist = screen_width > waypoint.onscreen_dist ? screen_width : waypoint.onscreen_dist
	if(actual_dist <= onscreen_dist)
		//if the tracked vehicle is onscreen, hide the arrow
		//and put the image with its sensor icon overlay directly on top of the tracked object
		//note that this won't hide the overlay'd vehicle icon because it doesn't inherit alpha from this base image
		pointer_image.alpha = 0

		//check if they're actually in view (usually should be, but not always)
		var/source_center_viewable = (source_center_turf in view(owner, screen_width))
		var/source_viewable = (source_atom in view(owner, screen_width))
		if(source_center_viewable && source_viewable)
			object_image.loc = source_atom
			object_image.pixel_x = pixel_offset_x
			object_image.pixel_y = pixel_offset_y
		else
			//if something is blocking sight, calculate the position relative to the player so its still visible
			//note: this will have the image "jittering" around a bit as the owner moves, but its better than the sensor overlay being blocked by LOS
			//i know one way to fix this but i'm going to leave it until i come up with a more processor light method

			object_image.loc = owner
			var/relx = (source_center_turf.x - owner_center_turf.x)
			var/rely = (source_center_turf.y - owner_center_turf.y)
			//
			object_image.pixel_x = relx * 32 + pixel_offset_x
			object_image.pixel_y = rely * 32 + pixel_offset_y

	else
		//display the arrow and update it's direction
		pointer_image.alpha = 255
		pointer_image.dir = get_dir(owner_center_turf, source_center_turf)

		//work out relative screen location in -1 to 1, where 0 we are on top of each other and -1 or 1 we are on opposite edges of the map
		var/relx = (source_center_turf.x - owner_center_turf.x) / 255
		var/rely = (source_center_turf.y - owner_center_turf.y) / 255

		//have the icons float towards the side of the screen where the vehicle is on
		object_image.loc = owner
		object_image.pixel_x = relx * screen_width * 32 + get_center_pixel_offsetx(owner)
		object_image.pixel_y = rely * screen_width * 32 + get_center_pixel_offsety(owner)
		//
		pointer_image.loc = object_image.loc
		pointer_image.pixel_x = object_image.pixel_x
		pointer_image.pixel_y = object_image.pixel_y

/datum/hud_waypoint/proc/get_colour(var/tracking_faction, var/use_faction_colours)
	if(waypoint.colour_override)
		return waypoint.colour_override

	var/image_colour
	var/object_faction = waypoint.get_faction()
	if(use_faction_colours)
		if(object_faction && overmap_controller.faction_iff_colour[object_faction])
			image_colour = overmap_controller.faction_iff_colour[object_faction]
	else
		//grab the friend/foe colour
		image_colour = overmap_controller.get_friend_foe_colour(tracking_faction, object_faction)

	return image_colour

/datum/hud_waypoint/proc/set_colour(var/image_colour)
	//apply the colour
	if(image_colour)
		pointer_image.color = image_colour
		object_image.color = image_colour
		upper_underlay.color = image_colour
		lower_underlay.color = image_colour

/datum/hud_waypoint/proc/set_height_underlay(var/height_dir = 0)
	if(height_dir & UP)
		object_image.underlays += upper_underlay
		object_image.underlays -= lower_underlay
	else if(height_dir & DOWN)
		object_image.underlays -= upper_underlay
		object_image.underlays += lower_underlay
	else
		object_image.underlays -= upper_underlay
		object_image.underlays -= lower_underlay

/datum/hud_waypoint/proc/add_viewmobs(var/list/mobs)
	for(var/mob/M in mobs)
		add_viewmob(M)

/datum/hud_waypoint/proc/add_viewmob(var/mob/living/M)
	if(M.client)
		M.client.images |= pointer_image
		M.client.images |= object_image
		M.client.images |= upper_underlay
		M.client.images |= lower_underlay

/datum/hud_waypoint/proc/remove_viewmobs(var/list/mobs)
	for(var/mob/M in mobs)
		remove_viewmob(M)

/datum/hud_waypoint/proc/remove_viewmob(var/mob/living/M)
	if(M.client)
		M.client.images -= pointer_image
		M.client.images -= object_image
		M.client.images -= upper_underlay
		M.client.images -= lower_underlay

/datum/hud_waypoint/Destroy()
	. = ..()
	qdel(pointer_image)
	qdel(object_image)
