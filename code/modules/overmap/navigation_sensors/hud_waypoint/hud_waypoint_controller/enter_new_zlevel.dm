
//this should only be called for sector waypoints
/datum/hud_waypoint_controller/proc/enter_new_zlevel(var/obj/effect/zlevelinfo/nextz)
	//world << "/datum/hud_waypoint_controller/proc/enter_new_zlevel([nextz])"

	//world << "	all_hud_waypoints.len:[all_hud_waypoints.len]"
	for(var/datum/waypoint/waypoint in all_hud_waypoints)
		//world << "		[waypoint], [waypoint.type]"

		//only do vehicles - the waypoint for the actual sector itself should be a whole thing
		if(istype(waypoint, /datum/waypoint/sector/vehicle))
			var/datum/hud_waypoint/hud_waypoint = all_hud_waypoints[waypoint]
			var/obj/vehicle_hud/hud_waypoint/hud_object = hud_waypoint.hud_object
			//world << "			[hud_waypoint], [hud_waypoint.type]"
			var/waypoint_z = waypoint.get_zlevel()

			if(waypoint_z > owner.z)
				hud_object.set_height_underlay(DOWN)
			else if(waypoint_z < owner.z)
				hud_object.set_height_underlay(UP)
			else
				hud_object.set_height_underlay(0)
