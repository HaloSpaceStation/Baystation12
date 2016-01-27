
/obj/machinery/overmap_vehicle/proc/observe_space(var/mob/user)
	overmap_object.observe_space(user)
	user.set_machine(src)

/obj/machinery/overmap_vehicle/cancel_camera(var/mob/user)
	//if the player is inside a fighter and calls cancel_camera() verb
	//this override will prevent them from losing control of the vehicle
	return overmap_object.cancel_camera(user)

/obj/machinery/overmap_vehicle/check_eye(var/mob/user)
	//avoid resetting view to allow people looking out to space to retain control
	if(user.client && user.client.eye == overmap_object)
		return overmap_object.check_eye(user)
