
/datum/hud_waypoint
	var/datum/waypoint/waypoint
	var/obj/vehicle_hud/hud_waypoint/hud_object
	//var/override_dist = 0

/datum/hud_waypoint/New(var/atom/movable/new_owner, var/datum/waypoint/new_waypoint, var/owner_faction)
	waypoint = new_waypoint

	var/image_icon = waypoint.get_icon()
	var/object_icon_state = waypoint.get_icon_state()
	hud_object = new(new_owner, image_icon, object_icon_state, waypoint)

	update_colour(owner_faction, 1)

/datum/hud_waypoint/proc/update_overlay(var/screen_width = 7)
	hud_object.update_overlay(screen_width)

/datum/hud_waypoint/proc/update_overlay_megamap(var/screen_width = 7)
	hud_object.update_overlay_megamap(screen_width)

/datum/hud_waypoint/proc/update_colour(var/my_faction, use_faction_colours)
	hud_object.set_colour(get_colour(my_faction, use_faction_colours))

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

/datum/hud_waypoint/proc/add_viewmobs(var/list/mobs)
	for(var/mob/M in mobs)
		add_viewmob(M)

/datum/hud_waypoint/proc/add_viewmob(var/mob/living/M)
	if(M.client)
		M.client.screen |= hud_object
		M.client.images |= hud_object.all_images
		/*M.client.images |= hud_object.pointer_image
		M.client.images |= hud_object.object_image
		M.client.images |= hud_object.source_image
		M.client.images |= hud_object.upper_underlay
		M.client.images |= hud_object.lower_underlay*/
	else
		world << "WARNING: /datum/hud_waypoint/proc/add_viewmob([M] [M.type]) passed mob has no client"

/datum/hud_waypoint/proc/remove_viewmobs(var/list/mobs)
	for(var/mob/M in mobs)
		remove_viewmob(M)

/datum/hud_waypoint/proc/remove_viewmob(var/mob/living/M)
	if(M.client)
		M.client.screen -= hud_object
		M.client.images -= hud_object.all_images
		/*M.client.images -= hud_object.pointer_image
		M.client.images -= hud_object.object_image
		M.client.images -= hud_object.source_image
		M.client.images -= hud_object.upper_underlay
		M.client.images -= hud_object.lower_underlay*/

/datum/hud_waypoint/Destroy()
	. = ..()
	qdel(hud_object)
