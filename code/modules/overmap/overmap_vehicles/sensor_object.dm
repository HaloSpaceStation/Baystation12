datum/sensor_object
	var/image/pointer_image
	var/image/object_image
	var/my_faction
	var/object_faction
	var/use_faction_colours = 1

datum/sensor_object/proc/create_images(var/object_icon_state = "unknown", var/pointer_icon_state = "dirpointer")
	if(!pointer_icon_state)
		pointer_icon_state = "dirpointer"

	//create the image
	pointer_image = image('code/modules/overmap/overmap_vehicles/overmap_vehicle_hud.dmi', src, "icon_state" = pointer_icon_state)
	pointer_image.appearance_flags = RESET_TRANSFORM|RESET_COLOR|RESET_ALPHA

	if(!object_icon_state)
		object_icon_state = "unknown"

	//create the image
	object_image = image('code/modules/overmap/overmap_vehicles/overmap_vehicle_hud.dmi', src, "icon_state" = object_icon_state)
	object_image.appearance_flags = RESET_TRANSFORM|RESET_COLOR|RESET_ALPHA

	//grab the faction colour
	var/image_colour
	if(use_faction_colours)
		if(object_faction && overmap_controller.faction_iff_colour[object_faction])
			image_colour= overmap_controller.faction_iff_colour[object_faction]
	else
		//grab the friend/foe colour
		image_colour = overmap_controller.get_friend_foe_colour(my_faction, object_faction)

	//apply the colour
	if(image_colour)
		pointer_image.color = image_colour
		object_image.color = image_colour


datum/sensor_object/proc/add_viewmob(var/mob/living/M)
	if(M.client)
		M.client.images |= pointer_image
		M.client.images |= object_image

datum/sensor_object/proc/remove_viewmob(var/mob/living/M)
	if(M.client)
		M.client.images -= pointer_image
		M.client.images -= object_image


datum/sensor_object/proc/clear_self()
	qdel(pointer_image)
	qdel(object_image)

	PlaceInPool(src)
