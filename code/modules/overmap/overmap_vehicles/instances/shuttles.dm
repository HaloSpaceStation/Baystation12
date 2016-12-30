
//skt13 (default shuttle):
//when facing EAST|WEST, the transform offsets the sprite by 3 turfs X and 3 turfs Y


/obj/machinery/overmap_vehicle/shuttle/cargo_darter
	name = "D82-EST Darter"
	icon = 'code/modules/overmap/overmap_vehicles/shuttles/unsc_cargo_shuttle.dmi'
	desc = "A logistical support dropship for delivering supplies such as rations and munitions between UNSC facilities and warships."
	//
	maglock_strength = 6
	bound_width = 192
	bound_height = 384
	layout_file = 'maps/ships/shuttle_unsccargo1.dmm'
	layout_x = 6
	layout_y = 12

//when facing EAST|WEST, the transform offsets the sprite by 0.5 turfs X and 0.5 turfs Y
/obj/machinery/overmap_vehicle/shuttle/med1
	name = "Medstar 2200 Shuttlecraft"
	icon = 'code/modules/overmap/overmap_vehicles/shuttles/unsc_med_01.dmi'
	desc = "For insystem transport of patients in critical condition. Also functions as a clinic in emergencies"
	//
	maglock_strength = 8
	bound_width = 448
	bound_height = 480
	layout_file = 'maps/ships/unsc_med_01.dmm'
	layout_x = 14
	layout_y = 15

//when facing EAST|WEST, the transform offsets the sprite by 3 turfs X and 3 turfs Y
/obj/machinery/overmap_vehicle/shuttle/per1
	name = "Duotronic D4 Shuttlecraft"
	icon = 'code/modules/overmap/overmap_vehicles/shuttles/unsc_per_01.dmi'
	desc = "Unarmed civilian shuttle built for economy insystem transport."
	//
	maglock_strength = 11
	bound_width = 192
	bound_height = 384
	layout_file = 'maps/ships/unsc_per_01.dmm'
	layout_x = 6
	layout_y = 12

//when facing EAST|WEST, the transform offsets the sprite by 3 turfs X and 3 turfs Y
/obj/machinery/overmap_vehicle/shuttle/per2
	name = "AZ-A Dynamics Shuttlecraft DAZ12"
	icon = 'code/modules/overmap/overmap_vehicles/shuttles/unsc_per_02.dmi'
	desc = "Unarmed civilian shuttle built for capacity insystem transport."
	//
	maglock_strength = 10
	bound_width = 288
	bound_height = 480
	layout_file = 'maps/ships/unsc_per_02.dmm'
	layout_x = 9
	layout_y = 15

//when facing EAST|WEST, the transform offsets the sprite by 0.5 turfs X and 0.5 turfs Y
/obj/machinery/overmap_vehicle/shuttle/sal1
	name = "NMN-SAR/salvage shuttle"
	icon = 'code/modules/overmap/overmap_vehicles/shuttles/unsc_sal_01.dmi'
	desc = "NeuMetroNomics multipurpose search/rescue, salvage and vacuum repair shuttle."
	//
	maglock_strength = 8
	bound_width = 448
	bound_height = 480
	layout_file = 'maps/ships/unsc_sal_01.dmm'
	layout_x = 14
	layout_y = 15

//when facing EAST|WEST, the transform offsets the sprite by 0.5 turfs X and 0.5 turfs Y
/obj/machinery/overmap_vehicle/shuttle/sec1
	name = "SKT-24 Shuttlecraft"
	icon = 'code/modules/overmap/overmap_vehicles/shuttles/unsc_sec_01.dmi'
	desc = "Colonial security insystem personnel transport and prisoner transfer."
	//
	maglock_strength = 6
	bound_width = 416
	bound_height = 448
	layout_file = 'maps/ships/unsc_sec_01.dmm'
	layout_x = 13
	layout_y = 14


//an early test map which is a copy of the SS13 nuke shuttle
//i'm not happy with how big it is so i'm not planning to use it but keep it for reference instead
/obj/machinery/overmap_vehicle/shuttle/innie
	name = "Combat Shuttle"
	icon = 'code/modules/overmap/overmap_vehicles/shuttles/innie_combat_shuttle.dmi'
	//
	maglock_strength = 10
	bound_width = 544
	bound_height = 864
	layout_file = 'maps/ships/shuttle_inniecombat1.dmm'
	layout_x = 17
	layout_y = 27

	//iff_faction_broadcast = "Insurrection"
	armour = 100
	hull_default = 400
