//Police Deparment Lift

/obj/turbolift_map_holder/cargolift/PD
	dir = NORTH
	depth = 2
	lift_size_x = 3
	lift_size_y = 2
	floor_type = /turf/simulated/floor/tech/ridged
	wall_type = /turf/simulated/floor/tech/ridged

	areas_to_use = list(/area/turbolift/PD/lifts/ground_level,/area/turbolift/PD/lifts/sub_level)

/area/turbolift/PD/lifts/ground_level
	name = "Ground-Level"
	requires_power= 0
	has_gravity = 1

/area/turbolift/PD/lifts/sub_level
	name = "Sub-Level"
	requires_power= 0
	has_gravity = 1