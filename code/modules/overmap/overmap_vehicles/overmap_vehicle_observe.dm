
/obj/machinery/overmap_vehicle/proc/observe_space(var/mob/user)
	overmap_object.observe_space(user)

/obj/machinery/overmap_vehicle/cancel_camera(var/mob/M)
	overmap_object.my_observers.Remove(M)
	check_eye(M)
	return 1

/obj/machinery/overmap_vehicle/check_eye(var/mob/user)
	if(user && overmap_object && (user in overmap_object.my_observers))
		return overmap_object.check_eye(user)

	return -1
