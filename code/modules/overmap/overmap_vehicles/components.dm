
/*
Fuel types
0 = energy
1 = diesel
2 = plasma
3 = h-fuel
4 = dt-fuel
*/

/datum/overmap_vehicle_component
	var/rate = 0				//depends on type of component
	var/integrity = 1			//0-1
	var/fuel_type = 0			//default to use 1 fuel per sec
	var/heat = 0
	var/max_heat = 100
	var/heat_damage = 0.1		//damage per sec if overheated
	var/running_heat = 1		//heat per sec while running

	var/overclock_enabled = 1
	var/clock_multiplier = 1
	var/overclock_heat = 1		//additional heat per sec if overclocking (multiplied by clock rate)

/datum/overmap_vehicle_component/verb/enable_hover()
	set name = "Enable hover mode"
	set category = "Vehicle"
	set src = usr.loc

	if(istype(src, /obj/machinery/overmap_vehicle))
		var/obj/machinery/overmap_vehicle/O = src
		O.set_hovering(1)

/datum/overmap_vehicle_component/verb/disable_hover()
	set name = "Disable hover mode"
	set category = "Vehicle"
	set src = usr.loc

	if(istype(src, /obj/machinery/overmap_vehicle))
		var/obj/machinery/overmap_vehicle/O = src
		O.set_hovering(0)

/datum/overmap_vehicle_component/verb/extend_landing_gear()
	set name = "Extend landing gear"
	set category = "Vehicle"
	set src = usr.loc

	if(istype(src, /obj/machinery/overmap_vehicle))
		var/obj/machinery/overmap_vehicle/O = src
		O.set_landing_gear(1)

/datum/overmap_vehicle_component/verb/retract_landing_gear()
	set name = "Retract landing gear"
	set category = "Vehicle"
	set src = usr.loc

	if(istype(src, /obj/machinery/overmap_vehicle))
		var/obj/machinery/overmap_vehicle/O = src
		O.set_landing_gear(0)
