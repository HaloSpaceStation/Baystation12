
//this should only be called for sector waypoints
/datum/hud_waypoint_controller/proc/enter_new_zlevel(var/obj/effect/zlevelinfo/nextz)

	for(var/datum/waypoint/waypoint in all_hud_waypoints)
		if(istype(waypoint, /datum/waypoint/sector))
			continue

		var/datum/hud_waypoint/hud_waypoint = all_hud_waypoints[waypoint]
		var/waypoint_z = waypoint.get_zlevel()

		if(waypoint_z > owner.z)
			hud_waypoint.set_height_underlay(DOWN)
		else if(waypoint_z < owner.z)
			hud_waypoint.set_height_underlay(UP)
		else
			hud_waypoint.set_height_underlay(0)
