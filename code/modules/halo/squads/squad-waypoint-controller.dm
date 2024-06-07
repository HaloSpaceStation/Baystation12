
#define WAYPOINT_DEFAULT_NAME_LIST list("Alpha","Bravo","Charlie","Delta","Echo","Foxtrot","Golf","Hotel","Indigo")
#define WAYPOINT_DEFAULT_ICON_LIST list("waypoint","waypointred","waypointgreen","waypointorange","waypointyellow","waypointpink")

/datum/waypoint_controller

	var/squad_name = "squad1"
	var/controller_manager_device
	var/list/linked_devices = list()
	var/list/active_waypoints = list()
	var/list/waypoint_name_defaults = WAYPOINT_DEFAULT_NAME_LIST

/datum/waypoint_controller/New(var/creator)
	. = ..()
	controller_manager_device = creator

/datum/waypoint_controller/proc/create_waypoint(var/atom/waypoint_turf,var/mob/user)
	var/obj/effect/waypoint_holder/created_waypoint = new
	created_waypoint.waypoint_icon = pick(WAYPOINT_DEFAULT_ICON_LIST)
	created_waypoint.loc = waypoint_turf
	waypoint_turf.contents += created_waypoint
	active_waypoints += created_waypoint
	created_waypoint.waypoint_name = "[waypoint_name_defaults[active_waypoints.len]]"
	inform_waypoint_modification(created_waypoint)
	update_linked_waypoint_locations()
	START_PROCESSING(SSobj, src)
	return created_waypoint

/datum/waypoint_controller/proc/cole_protocol() //This wipes the controller, removing all waypoints and linked devices before deleting itself.
	for(var/obj/item/clothing/glasses/hud/tactical/device in linked_devices)
		device.update_known_waypoints(list())
		var/mob/m = device.loc
		if(istype(m))
			to_chat(m,"<span class = 'warning'>[squad_name] Alert: Squad Management device reset. Manual re-link required.</span>")
	linked_devices.Cut()
	for(var/obj/wp in active_waypoints)
		qdel(wp)
	active_waypoints.Cut()
	controller_manager_device = null
	qdel(src)

/datum/waypoint_controller/proc/inform_waypoint_modification(var/obj/effect/waypoint_holder/waypoint,var/delete = 0,var/name_change = null)
	for(var/obj/device in linked_devices)
		if(ismob(device.loc))
			if(name_change)
				to_chat(device.loc,"<span class = 'warning'>[squad_name] Alert: Waypoint name modified, [waypoint.waypoint_name] -> [name_change]</span>")
			else
				to_chat(device.loc,"<span class = 'warning'>[squad_name] Alert: Waypoint [delete ? "deleted" : "added"], [waypoint.waypoint_name].</span>")

/datum/waypoint_controller/proc/inform_squad_death(var/mob/living/now_dead)
	var/message = "<span class = 'warning'>Squad Overwatch Alert: [now_dead.name], [now_dead.job] has died.</span>"
	for(var/obj/device in linked_devices)
		if(istype(device.loc,/mob/living))
			to_chat(device.loc,message)

/datum/waypoint_controller/proc/delete_waypoint(var/obj/effect/waypoint_holder/waypoint)
	active_waypoints -= waypoint
	inform_waypoint_modification(waypoint,1)
	update_linked_waypoint_locations()
	qdel(waypoint)
	if(active_waypoints.len == 0)
		STOP_PROCESSING(SSobj, src)

/datum/waypoint_controller/proc/get_waypoints()
	var/list/waypoints_by_name = list()
	for(var/obj/effect/waypoint_holder/waypoint in active_waypoints)
		waypoints_by_name += waypoint.waypoint_name
	return waypoints_by_name

/datum/waypoint_controller/proc/get_waypoint_from_name(var/wanted_name)
	for(var/obj/effect/waypoint_holder/waypoint in active_waypoints)
		if(waypoint.waypoint_name == wanted_name)
			return waypoint

/datum/waypoint_controller/proc/update_linked_waypoint_locations() //This proc updates the locations of waypoints for all linked devices.
	for(var/obj/item/clothing/glasses/hud/tactical/device in linked_devices)
		device.update_known_waypoints(active_waypoints)
		device.process_hud()

/datum/waypoint_controller/Process()
	update_linked_waypoint_locations()

#undef WAYPOINT_DEFAULT_NAME_LIST
#undef WAYPOINT_DEFAULT_ICON_LIST
