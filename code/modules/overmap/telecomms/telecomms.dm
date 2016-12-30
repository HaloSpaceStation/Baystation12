
/obj/machinery/telecomms/receiver/systemwide
	name = "Systemwide Subspace Receiver"
	desc = "This machine has a dish-like shape and green lights. It is designed to detect and process subspace radio activity from distances across an entire star system."

//accept any signal strong enough to reach us
/obj/machinery/telecomms/receiver/receiver/systemwide/check_in_range(datum/signal/signal)
	return 1

/proc/get_sector_tcomms(var/atom/A)
	var/obj/effect/overmapobj/overmapobj = map_sectors["[A.z]"]
	return telecomms_list

/obj/effect/overmapobj/proc/get_tcomms_in_range(var/max_range)
	for(var/obj/effect/overmapobj/overmapobj in range(src, max_range))
	var/obj/effect/overmapobj/overmapobj = map_sectors["[A.z]"]
	return telecomms_list
