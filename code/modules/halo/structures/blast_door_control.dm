#define BLAST_CONTROL_RANGE 22

// This code allows for airlocks to be controlled externally by setting an id_tag and comm frequency (disables ID access)
//this is a near exact duplicate of airlock_control.dm 28/2/16
//todo: genericise the airlock control code to mostly remove the need for this
obj/machinery/door/blast
	var/id_tag
	var/frequency
	var/shockedby = list()
	var/datum/radio_frequency/radio_connection
	var/cur_command = null	//the command the door is currently attempting to complete

obj/machinery/door/blast/Process()
	..()
	if(arePowerSystemsOn())
		execute_current_command()

obj/machinery/door/blast/receive_signal(datum/signal/signal)
	/*var/debug = 0
	if(signal.data["tag"] != "_pump" && (id_tag == "port_pelicanhangar_inner" || id_tag == "port_pelicanhangar_outer"))
		debug = 1
		to_world("receive_signal()")
		for(var/entry in signal.data)
			to_world("signal.data\[[entry]\]: [signal.data[entry]]")*/

	if (!arePowerSystemsOn()) return //no power
	//if(debug) to_world("check1")

	if(!signal || signal.encryption) return
	//if(debug) to_world("check2")

	if(id_tag != signal.data["tag"] || !signal.data["command"]) return
	//if(debug) to_world("check3")

	cur_command = signal.data["command"]
	spawn()
		//if(debug) to_world("check4")
		execute_current_command()

obj/machinery/door/blast/proc/execute_current_command()
	if(operating)
		return //emagged or busy doing something else

	if (!cur_command)
		return
	//to_world("execute_current_command()")

	do_command(cur_command)
	if (command_completed(cur_command))
		cur_command = null

obj/machinery/door/blast/proc/do_command(var/command)
	//to_world("obj/machinery/door/blast/proc/do_command([command])")
	switch(command)
		if("open")
			open()

		if("close")
			close()

		if("unlock")
			unlock()

		if("lock")
			lock()

		if("secure_open")
			unlock()

			sleep(2)
			open()

			lock()

		if("secure_close")
			unlock()
			close()

			lock()
			sleep(2)

	send_status()

obj/machinery/door/blast/proc/command_completed(var/command)
	switch(command)
		if("open")
			return (!density)

		if("close")
			return density

		if("unlock")
			return !locked

		if("lock")
			return locked

		if("secure_open")
			return (locked && !density)

		if("secure_close")
			return (locked && density)

	return 1	//Unknown command. Just assume it's completed.

obj/machinery/door/blast/proc/send_status(var/bumped = 0)
	if(radio_connection)
		var/datum/signal/signal = new
		signal.transmission_method = 1 //radio signal
		signal.data["tag"] = id_tag
		signal.data["timestamp"] = world.time

		signal.data["door_status"] = density?("closed"):("open")
		signal.data["lock_status"] = locked?("locked"):("unlocked")

		if (bumped)
			signal.data["bumped_with_access"] = 1

		radio_connection.post_signal(src, signal, range = AIRLOCK_CONTROL_RANGE, filter = RADIO_AIRLOCK)


/*obj/machinery/door/blast/open(surpress_send)
	. = ..()
	if(!surpress_send) send_status()


obj/machinery/door/blast/close(surpress_send)
	. = ..()
	if(!surpress_send) send_status()*/


/*obj/machinery/door/blast/Bumped(atom/AM)
	..(AM)
	if(istype(AM, /obj/mecha))
		var/obj/mecha/mecha = AM
		if(density && radio_connection && mecha.occupant && (src.allowed(mecha.occupant) || src.check_access_list(mecha.operation_req_access)))
			send_status(1)
	return*/

obj/machinery/door/blast/proc/set_frequency(new_frequency)
	radio_controller.remove_object(src, frequency)
	if(new_frequency)
		frequency = new_frequency
		radio_connection = radio_controller.add_object(src, frequency, RADIO_AIRLOCK)


/*obj/machinery/door/blast/initialize()
	if(frequency)
		set_frequency(frequency)

	update_icon()*/


obj/machinery/door/blast/New()
	. = ..()

	if(radio_controller)
		set_frequency(frequency)

obj/machinery/door/blast/Destroy()
	if(frequency && radio_controller)
		radio_controller.remove_object(src,frequency)
	..()
/*
obj/machinery/airlock_sensor
	icon = 'icons/obj/airlock_machines.dmi'
	icon_state = "airlock_sensor_off"
	name = "airlock sensor"

	anchored = 1
	power_channel = ENVIRON

	var/id_tag
	var/master_tag
	var/frequency = 1379
	var/command = "cycle"

	var/datum/radio_frequency/radio_connection

	var/on = 1
	var/alert = 0
	var/previousPressure

obj/machinery/airlock_sensor/update_icon()
	if(on)
		if(alert)
			icon_state = "airlock_sensor_alert"
		else
			icon_state = "airlock_sensor_standby"
	else
		icon_state = "airlock_sensor_off"

obj/machinery/airlock_sensor/attack_hand(mob/user)
	var/datum/signal/signal = new
	signal.transmission_method = 1 //radio signal
	signal.data["tag"] = master_tag
	signal.data["command"] = command

	radio_connection.post_signal(src, signal, range = AIRLOCK_CONTROL_RANGE, filter = RADIO_AIRLOCK)
	flick("airlock_sensor_cycle", src)

obj/machinery/airlock_sensor/Process()
	if(on)
		var/datum/gas_mixture/air_sample = return_air()
		var/pressure = round(air_sample.return_pressure(),0.1)

		if(abs(pressure - previousPressure) > 0.001 || previousPressure == null)
			var/datum/signal/signal = new
			signal.transmission_method = 1 //radio signal
			signal.data["tag"] = id_tag
			signal.data["timestamp"] = world.time
			signal.data["pressure"] = num2text(pressure)

			radio_connection.post_signal(src, signal, range = AIRLOCK_CONTROL_RANGE, filter = RADIO_AIRLOCK)

			previousPressure = pressure

			alert = (pressure < ONE_ATMOSPHERE*0.8)

			update_icon()

obj/machinery/airlock_sensor/proc/set_frequency(new_frequency)
	radio_controller.remove_object(src, frequency)
	frequency = new_frequency
	radio_connection = radio_controller.add_object(src, frequency, RADIO_AIRLOCK)

obj/machinery/airlock_sensor/initialize()
	set_frequency(frequency)

obj/machinery/airlock_sensor/New()
	..()
	if(radio_controller)
		set_frequency(frequency)

obj/machinery/airlock_sensor/Destroy()
	if(radio_controller)
		radio_controller.remove_object(src,frequency)
	..()

obj/machinery/airlock_sensor/airlock_interior
	command = "cycle_interior"

obj/machinery/airlock_sensor/airlock_exterior
	command = "cycle_exterior"

obj/machinery/access_button
	icon = 'icons/obj/airlock_machines.dmi'
	icon_state = "access_button_standby"
	name = "access button"

	anchored = 1
	power_channel = ENVIRON

	var/master_tag
	var/frequency = 1449
	var/command = "cycle"

	var/datum/radio_frequency/radio_connection

	var/on = 1


obj/machinery/access_button/update_icon()
	if(on)
		icon_state = "access_button_standby"
	else
		icon_state = "access_button_off"

obj/machinery/access_button/attackby(obj/item/I as obj, mob/user as mob)
	//Swiping ID on the access button
	if (istype(I, /obj/item/weapon/card/id) || istype(I, /obj/item/device/pda))
		attack_hand(user)
		return
	..()

obj/machinery/access_button/attack_hand(mob/user)
	add_fingerprint(usr)
	if(!allowed(user))
		to_chat(user,"<span class='warning'>Access Denied</span>")

	else if(radio_connection)
		var/datum/signal/signal = new
		signal.transmission_method = 1 //radio signal
		signal.data["tag"] = master_tag
		signal.data["command"] = command

		radio_connection.post_signal(src, signal, range = AIRLOCK_CONTROL_RANGE, filter = RADIO_AIRLOCK)
	flick("access_button_cycle", src)


obj/machinery/access_button/proc/set_frequency(new_frequency)
	radio_controller.remove_object(src, frequency)
	frequency = new_frequency
	radio_connection = radio_controller.add_object(src, frequency, RADIO_AIRLOCK)


obj/machinery/access_button/initialize()
	set_frequency(frequency)


obj/machinery/access_button/New()
	..()

	if(radio_controller)
		set_frequency(frequency)

obj/machinery/access_button/Destroy()
	if(radio_controller)
		radio_controller.remove_object(src, frequency)
	..()

obj/machinery/access_button/airlock_interior
	frequency = 1379
	command = "cycle_interior"

obj/machinery/access_button/airlock_exterior
	frequency = 1379
	command = "cycle_exterior"
*/



//some airlock stuff which i've copy pasted
//todo: move this all up to /door so it isnt duplicated
obj/machinery/door/blast/proc/arePowerSystemsOn()
	if (stat & (NOPOWER|BROKEN))
		//to_world("arePowerSystemsOn() returned 0")
		return 0

	return 1
