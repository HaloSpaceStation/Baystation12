
obj/machinery/overmap_vehicle/proc/enter_new_zlevel(var/obj/effect/zlevelinfo/curz)
	//update hud tracking elements
	//var/obj/effect/zlevelinfo/curz = locate("zlevel[A.z]")

	//clear out old tracked objects
	//todo: is this the wrong way to do this?
	for(var/obj/machinery/overmap_vehicle/V in tracked_vehicles)
		V.stop_tracking_vehicle(src)
		stop_tracking_vehicle(V)

	//the new zlevelinfo is already tracking all relevant vehicles for us so we'll just use it
	if(curz)
		for(var/obj/machinery/overmap_vehicle/V in curz.objects_preventing_recycle)
			if(V == src)
				continue
			V.start_tracking_vehicle(src)
			start_tracking_vehicle(V)

obj/machinery/overmap_vehicle/proc/start_tracking_vehicle(var/obj/machinery/overmap_vehicle/V)

	var/datum/sensor_object/S = PoolOrNew(/datum/sensor_object)
	S.my_faction = iff_faction_broadcast
	S.object_faction = V.iff_faction_broadcast
	S.use_faction_colours = iff_faction_colours
	S.create_images(object_icon_state = V.sensor_icon_state)

	//make sure all observing mobs have the image
	for(var/mob/M in mobs_tracking)
		S.add_viewmob(M)

	all_sensor_objects.Add(S)
	tracked_vehicles[V] = S

obj/machinery/overmap_vehicle/proc/stop_tracking_vehicle(var/obj/machinery/overmap_vehicle/V)
	var/datum/sensor_object/S = tracked_vehicles[V]
	for(var/mob/M in mobs_tracking)
		S.remove_viewmob(M)

	tracked_vehicles[V] = null
	tracked_vehicles -= V
	all_sensor_objects -= S

	S.clear_self()

obj/machinery/overmap_vehicle/proc/update_tracking_overlays(var/iteration = 0)
	set background = 1

	//loop over all the tracked vehicles and update their sensor tracking icon
	//todo: how to handle null indices in case a trackedd vehicle got destroyed without telling us
	var/list/checked_sensor_objects = list()
	var/list/checked_vehicles = list()
	for(var/obj/machinery/overmap_vehicle/V in tracked_vehicles)
		//stop tracking if vehicles somehow got into a different sector without telling us
		if(V.z != src.z)
			stop_tracking_vehicle(V)
			continue

		//grab the sensor object datum
		var/datum/sensor_object/S = tracked_vehicles[V]

		var/actual_dist = get_dist(src, V)
		if(actual_dist < 15)
			//if the tracked vehicle is onscreen, hide the arrow
			//note that this won't hide the overlay'd vehicle icon because it doesn't inherit alpha from this base image
			S.pointer_image.alpha = 0

			//put the image with its vehicle sprite overlay directly on top of the tracked vehicle
			S.object_image.loc = V
			S.object_image.pixel_x = 32
			S.object_image.pixel_y = 32

		else
			//display the arrow and update it's direction
			S.pointer_image.alpha = 255
			S.pointer_image.dir = get_dir(src, V)

			//work out relative screen location in -1 to 1, where 0 we are on top of each other and -1 or 1 we are on opposite edges of the map
			var/relx = (V.x - src.x) / 255
			var/rely = (V.y - src.y) / 255

			//have the icons float towards the side of the screen where the vehicle is on
			S.object_image.loc = src
			S.object_image.pixel_x = 32 + relx * 14 * 32
			S.object_image.pixel_y = 32 + rely * 14 * 32
			//
			S.pointer_image.loc = src
			S.pointer_image.pixel_x = 32 + relx * 14 * 32
			S.pointer_image.pixel_y = 32 + rely * 14 * 32

		checked_sensor_objects += S
		all_sensor_objects -= S
		checked_vehicles[V] = S

	//any leftover sensor objects here have somehow been destroyed without telling us, so just get rid of them
	for(var/datum/sensor_object/S in all_sensor_objects)
		for(var/mob/M in mobs_tracking)
			S.remove_viewmob(M)
			S.clear_self()

	//reset our lists so old images dont clog up our hud
	all_sensor_objects = checked_sensor_objects
	tracked_vehicles = checked_vehicles

//update these 2 as well
obj/machinery/overmap_vehicle/proc/add_tracking_overlays(var/mob/M)
	mobs_tracking |= M
	for(var/obj/machinery/overmap_vehicle/V in tracked_vehicles)
		var/datum/sensor_object/S = tracked_vehicles[V]
		S.add_viewmob(M)

obj/machinery/overmap_vehicle/proc/clear_tracking_overlays(var/mob/M)
	mobs_tracking -= M
	for(var/obj/machinery/overmap_vehicle/V in tracked_vehicles)
		var/datum/sensor_object/S = tracked_vehicles[V]
		S.remove_viewmob(M)
