
/obj/machinery/overmap_vehicle/proc/is_cruising()
	if(transit_area && src.z == transit_area.z)
		return 1
	return 0

/obj/machinery/overmap_vehicle/verb/start_cruise()
	set category = "Vehicle"
	set src = usr.loc

	if(enable_cruise(usr))
		src.verbs -= /obj/machinery/overmap_vehicle/verb/start_cruise
		src.verbs += /obj/machinery/overmap_vehicle/proc/stop_cruise

/obj/machinery/overmap_vehicle/proc/stop_cruise()
	set category = "Vehicle"
	set src = usr.loc

	if(disable_cruise())
		src.verbs += /obj/machinery/overmap_vehicle/verb/start_cruise
		src.verbs -= /obj/machinery/overmap_vehicle/proc/stop_cruise

/obj/machinery/overmap_vehicle/proc/enable_cruise(var/mob/user)
	. = 0
	if(!is_cruising())
		//world << "enable_cruise([user])"
		//only go to cruise once we've "cleared" major objects like capships and stations
		//typecasting like this is technically risky, but within this context it should be safe
		var/obj/effect/overmapobj/temporary_sector/cur_sector = map_sectors["[src.z]"]
		//var/obj/effect/overmapobj/temporary_sector/cur_sector = overmap_controller.get_destination_sector(overmap_object.loc)		//see code\modules\overmap\controller\spacetravel.dm

		if(cur_sector)
			if(istype(cur_sector))
				//halt the vehicle
				pixel_transform.brake(pixel_transform.max_pixel_speed + 1)

				//put this in a separate proc so that it can be overriden in the children (ie shuttles) for custom behaviour
				//occupants_handle_cruise()

				//see if we can recycle the existing zlevel
				overmap_controller.attempt_recycle_temp_sector(cur_sector, src)

				//get the secret area where we will hide the fighter
				if(!transit_area)
					transit_area = overmap_controller.get_virtual_area()
					transit_area.overmap_eject_object = src.overmap_object

				//make it go fast
				//world << "starting cruise with heading [pixel_transform.heading]"
				var/transit_dir = "ns"
				var/snapped_dir = angle2dir(pixel_transform.heading)
				switch(snapped_dir)
					if(SOUTH)
						transit_dir = "sn"
					if(EAST)
						transit_dir = "ew"
					if(WEST)
						transit_dir = "we"
				transit_area.sprite_area_transit(transit_dir)

				//get the center coords
				var/locx = transit_area.x + overmap_controller.virtual_area_dims / 2
				var/locy = transit_area.y + overmap_controller.virtual_area_dims / 2
				//world << "	calculated center coords [locx],[locy]"

				//adjust for the ship dimensions
				locx -= (bound_width / 64)
				locy -= (bound_height / 64)
				//world << "	center coords adjusted for ship dims ([bound_width],[bound_height]) to [locx],[locy]"

				//move to the new position in the "secret" area so that it's hidden
				src.loc = locate(locx, locy, transit_area.z)
				user << "\icon[src] <span class='info'>You enable cruise mode.</span>"

				//kick in the nos!
				overmap_object.pixel_transform.max_pixel_speed = cruise_speed
				overmap_object.pixel_transform.heading = src.pixel_transform.heading
				overmap_object.pixel_transform.accelerate_forward(cruise_speed)

				return 1

			else
				//to avoid collisions and going through walls etc
				user << "\icon[src] <span class='info'>You are too close to [cur_sector] to enable cruise mode.</span>"

		else
			//this shouldn't happen, but it will occur on eg overmap disabled zlevels
			user << "\icon[src] <span class='info'>You are unable to enable cruise mode.</span>"

/obj/machinery/overmap_vehicle/proc/occupants_handle_cruise()
	//force all occupants to observe the overmap
	for(var/mob/M in src)
		observe_space(M)

/obj/machinery/overmap_vehicle/proc/disable_cruise()
	. = 0
	if(is_cruising())
		/*else if(istype(cur_sector, /obj/effect/overmapobj/temporary_sector))
			var/obj/effect/overmapobj/temporary_sector/deep_space = cur_sector
			spawnz = deep_space.map_z*/

		overmap_controller.spawn_to_sector(overmap_object.loc, src, overmap_object, skip_recycle = 1)

		//update the orientation
		cruise_exit_orientation()

		//reset speeds and kick it to max (normal) speed
		overmap_object.pixel_transform.brake(overmap_object.pixel_transform.max_pixel_speed + 1)
		overmap_object.pixel_transform.max_pixel_speed = pixel_transform.max_pixel_speed
		src.pixel_transform.add_pixel_speed_angle(src.pixel_transform.max_pixel_speed, src.pixel_transform.heading)

		return 1

/obj/machinery/overmap_vehicle/proc/cruise_exit_orientation()
	src.pixel_transform.heading = overmap_object.pixel_transform.heading
	src.transform = overmap_object.transform

