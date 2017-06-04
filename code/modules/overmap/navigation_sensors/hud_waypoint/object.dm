
/obj/vehicle_hud/hud_waypoint
	layer = 2
	appearance_flags = RESET_TRANSFORM
	var/datum/waypoint/waypoint
	var/atom/movable/owner

	var/image/pointer_image
	var/image/object_image
	var/image/source_image
	var/image/upper_underlay
	var/image/lower_underlay
	var/image/myself_image

	var/list/all_images = list()

/obj/vehicle_hud/hud_waypoint/New(var/atom/movable/new_owner, var/image_icon, var/object_icon_state, var/datum/waypoint/source_waypoint)

	waypoint = source_waypoint
	owner = new_owner
	name = source_waypoint.get_name()

	if(!object_icon_state)
		object_icon_state = "unknown"

	//the stylised sprite representing the object on sensors
	object_image = image(image_icon, src, object_icon_state, 10.3)
	object_image.appearance_flags = RESET_TRANSFORM|RESET_ALPHA

	//animated arrows indicating the object is above or below the player in a sector
	upper_underlay = image(image_icon, src, "dirpointer_up", 10.2)
	upper_underlay.appearance_flags = RESET_TRANSFORM|RESET_ALPHA
	upper_underlay.alpha = 0
	//
	lower_underlay = image(image_icon, src, "dirpointer_down", 10.2)
	lower_underlay.appearance_flags = RESET_TRANSFORM|RESET_ALPHA
	lower_underlay.alpha = 0

	//an arrow pointing in its direction
	var/pointer_icon_state = "dirpointer"
	pointer_image = image(image_icon, src, pointer_icon_state, 10.1)
	pointer_image.appearance_flags = RESET_TRANSFORM|RESET_ALPHA
	pointer_image.alpha = 0

	//world << "\ref[waypoint.source] [waypoint.source] | \ref[src.owner] [src.owner]"
	if(waypoint.source == src.owner)
		//world << "	check1"
		myself_image = image(image_icon, src, "myself", 10.4)
		myself_image.appearance_flags = RESET_TRANSFORM|RESET_COLOR|RESET_ALPHA
		myself_image.pixel_x -= 16
		myself_image.pixel_y -= 16
		all_images += myself_image
	else
		//the sprite that will overlay directly on the source
		source_image = image(image_icon, waypoint.get_source(), object_icon_state, 10.3)

		/*var/atom/movable/M = waypoint.get_source()
		source_image = image(image_icon, M, object_icon_state, 10.3)
		if(istype(M))
			source_image.pixel_x = M.bound_width / 2
			source_image.pixel_y = M.bound_height / 2*/
		source_image.appearance_flags = RESET_TRANSFORM|RESET_ALPHA
		all_images += source_image

	//combine them for ease of transformation
	all_images += pointer_image
	all_images += object_image
	all_images += upper_underlay
	all_images += lower_underlay
	//
	//overlays += all_images

/obj/vehicle_hud/hud_waypoint/proc/set_megamap_mode(var/use_megamap = 1)
	if(use_megamap)
		//src.invisibility = 0
		pointer_image.alpha = 0
		object_image.alpha = 255
		if(myself_image)
			myself_image.alpha = 255
	else
		pointer_image.alpha = 255
		if(myself_image)
			myself_image.alpha = 0

/obj/vehicle_hud/hud_waypoint/Destroy()
	. = ..()

	for(var/item in all_images)
		qdel(item)
	all_images = list()
