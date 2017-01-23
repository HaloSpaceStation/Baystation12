
/datum/waypoint/overmapobj_vehicle
	dont_update = 1

/datum/waypoint/overmapobj_vehicle/get_icon_state()
	return "fighter"

/datum/waypoint/overmapobj_vehicle/get_faction()
	var/obj/effect/overmapobj/vehicle/overmap_vehicle_obj = overmapobj
	return overmap_vehicle_obj.overmap_vehicle.iff_faction_broadcast

/datum/waypoint/overmapobj_vehicle/get_spawn_loc()
	return overmapobj
