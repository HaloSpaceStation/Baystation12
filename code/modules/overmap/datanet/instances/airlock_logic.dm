
/obj/machinery/door/var/datanet_door_dir = 0	//1 = inner, -1 = outer

/datum/datanet_logic/airlock
	//var/tag_airpump
	//var/tag_chamber_sensor

	var/list/linked_outer_doors = list()
	var/list/linked_inner_doors = list()
	var/list/linked_pumps = list()
	var/obj/machinery/airlock_sensor/chamber_sensor
	var/obj/machinery/autopilot_beacon/airlock/external_beacon
	var/obj/machinery/autopilot_beacon/berth/internal_beacon

	var/state = STATE_IDLE
	var/exterior_closed = 1
	var/interior_closed = 1
	var/pressure_fuzz_factor = 0.05

/*
/datum/datanet_logic/airlock/proc/check_init()
	//check whether we are linked with the minimum machinery to be considered a working "airlock"
	. = 0
	if(chamber_sensor && linked_pumps.len > 0 && linked_outer_doors.len > 0 && linked_inner_doors.len > 0)
		return 1
		*/

/datum/datanet_logic/airlock/proc/get_chamber_pressure()
	. = -1
	if(chamber_sensor)
		return chamber_sensor.previousPressure

/datum/datanet_logic/airlock/link_atom(var/atom/A)
	..()

	var/success = 0

	//doors
	if(istype(A, /obj/machinery/door))
		var/obj/machinery/door/door = A
		if(door.datanet_door_dir > 0)
			linked_inner_doors.Add(door)
			spawn(0)
				door.open(1)
				door.lock()
		else if(door.datanet_door_dir < 0)
			linked_outer_doors.Add(door)
			door.lock()
		success = 1

	//pumps
	else if(istype(A, /obj/machinery/atmospherics/unary/vent_pump))
		linked_pumps.Add(A)
		success = 1

	//airlock sensors
	else if(istype(A, /obj/machinery/airlock_sensor))
		//only ever need 1 of these
		chamber_sensor = A
		success = 1

	//these still need to be told when they're linked
	else if(istype(A, /obj/machinery/datanet_airlock_console) || istype(A, /obj/machinery/datanet_berth_console))
		success = 1

	//autopilot beacons
	else if(istype(A, /obj/machinery/autopilot_beacon/airlock))
		//only need 1 of these
		external_beacon = A
		success = 1

	//autopilot beacons
	else if(istype(A, /obj/machinery/autopilot_beacon/berth))
		//only need 1 of these
		internal_beacon = A
		success = 1

	if(success)
		A.datanet_logic_linked(src)

/datum/datanet_logic/airlock/process()
	var/chamb_pressure = get_chamber_pressure()
	switch(state)
		if(STATE_PURGE)
			if(chamb_pressure <= pressure_fuzz_factor * ONE_ATMOSPHERE)
				state = STATE_IDLE
				set_pumping(0)
				process_stop()

		if(STATE_CYCLEOUT)
			if(chamb_pressure <= pressure_fuzz_factor * ONE_ATMOSPHERE)
				state = STATE_IDLE
				set_pumping(0)
				process_stop()
				cycleDoors(linked_outer_doors, DOOR_OPEN)
				exterior_closed = 0

				//tell our outside beacon
				spawn(10)
					if(external_beacon)
						external_beacon.airlock_cycled_ext()

		if(STATE_CYCLEIN)
			if(chamb_pressure >= (1 - pressure_fuzz_factor) * ONE_ATMOSPHERE)
				state = STATE_IDLE
				set_pumping(0)
				process_stop()
				cycleDoors(linked_inner_doors, DOOR_OPEN)
				interior_closed = 0

				//tell our inside beacon
				spawn(10)
					if(internal_beacon)
						internal_beacon.airlock_cycled_int()

/datum/datanet_logic/airlock/proc/enact_command(var/command)

	switch(command)
		if("cycle_ext")
			//only respond to these commands if the airlock isn't already doing something
			//prevents the controller from getting confused and doing strange things
			state = STATE_CYCLEOUT
			cycleDoors(linked_inner_doors, DOOR_CLOSED)
			cycleDoors(linked_outer_doors, DOOR_CLOSED)
			exterior_closed = 1
			interior_closed = 1
			process_start()
			spawn(10)
				set_pumping(-1)

		if("cycle_int")
			state = STATE_CYCLEIN
			cycleDoors(linked_inner_doors, DOOR_CLOSED)
			cycleDoors(linked_outer_doors, DOOR_CLOSED)
			exterior_closed = 1
			interior_closed = 1
			process_start()
			spawn(10)
				set_pumping(1)

		if("force_ext")
			if(exterior_closed)
				exterior_closed = 0
				cycleDoors(linked_outer_doors, DOOR_OPEN)
			else
				exterior_closed = 1
				cycleDoors(linked_outer_doors, DOOR_CLOSED)

		if("force_int")
			if(interior_closed)
				interior_closed = 0
				cycleDoors(linked_inner_doors, DOOR_OPEN)
			else
				interior_closed = 1
				cycleDoors(linked_inner_doors, DOOR_CLOSED)

		if("abort")
			state = STATE_IDLE
			set_pumping(0)
			process_stop()

		if("purge")
			state = STATE_PURGE
			cycleDoors(linked_inner_doors, DOOR_CLOSED)
			cycleDoors(linked_outer_doors, DOOR_CLOSED)
			exterior_closed = 1
			interior_closed = 1
			process_start()
			spawn(10)
				set_pumping(-1)

		if("secure")
			cycleDoors(linked_inner_doors, DOOR_CLOSED)
			cycleDoors(linked_outer_doors, DOOR_CLOSED)
			exterior_closed = 1
			interior_closed = 1

/datum/datanet_logic/airlock/proc/cycleDoors(var/list/doorList, var/door_status)
	for(var/obj/machinery/door/D in doorList)
		if(D.density != door_status)
			spawn(0)
				D.unlock()
				if(door_status == DOOR_OPEN)
					D.open(1)
				else
					D.close(1)
				sleep(10)
				D.lock()

/datum/datanet_logic/airlock/proc/set_pumping(var/direction = 0)
	//1 = pressurising
	//-1 = depressuring
	//0 = shut down
	for(var/obj/machinery/atmospherics/unary/vent_pump/pump in linked_pumps)
		if(direction > 0)
			pump.use_power = 1
			pump.pump_direction = 1
			pump.external_pressure_bound = ONE_ATMOSPHERE
		else if(direction < 0)
			pump.use_power = 1
			pump.pump_direction = 0
			pump.external_pressure_bound = 0
		else
			pump.use_power = 0
		pump.update_icon()
