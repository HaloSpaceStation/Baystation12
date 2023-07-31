/area/turbolift/KS7535/lifts/lift_1_ground
	name = "Sublevel 1"
	requires_power= 0
	has_gravity = 1


/area/turbolift/KS7535/lifts/lift_1_second
	name = "Ground Level"
	requires_power= 0
	has_gravity = 1


/obj/turbolift_map_holder/cargolift/KS7535/front
	dir = SOUTH
	depth = 2
	lift_size_x = 4
	lift_size_y = 3

	areas_to_use = list(/area/turbolift/KS7535/lifts/lift_1_ground,/area/turbolift/KS7535/lifts/lift_1_second)

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