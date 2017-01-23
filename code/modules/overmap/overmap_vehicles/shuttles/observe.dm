
/obj/machinery/overmap_vehicle/shuttle/cancel_camera(var/mob/user)
	//this is a little intricate

	//first, if we are observing our overmap vehicle then the observer wants to go back to the shuttle interior
	if(!user.machine || user.machine == src)
		my_observers.Remove(user)
		pilots.Remove(user)
		user.unset_machine()
		user.reset_view(null)
		if(user.client)
			user.client.view = 7
	else
		//otherwise, reset the view to just observing the overmap vehicle
		//this way, the first call to cancel_camera_view while on the overmap will send them back to viewing out the shuttle in sector view
		//the second will then send them back to the shuttle interior
		overmap_object.my_observers.Remove(user)
		if(!(user in my_observers))
			my_observers.Add(user)
		user.set_machine(src)
		user.reset_view(src, 0)
		if(user.client)
			user.client.view = 14

	return 1

/obj/machinery/overmap_vehicle/shuttle/check_eye(var/mob/user)
	//first, we can't look outside if we're maglocked
	if(src.loc != interior.loc)
		//only let them look outside if their body is still on the shuttle
		if(get_area(user) == shuttle_area && !user.stat && user.machine)
			if(!(user in my_observers))
				my_observers.Add(user)
				//my_observers[user] = user.loc

			if(user in overmap_object.my_observers)
				overmap_object.my_observers.Remove(user)

			if(user.client && user.client.eye != src)
				user.reset_view(src, 0)
				user.client.view = 14

			//todo: what effects should break them out of the observation mode?
			return 0

			//don't let them move from that spot
			/*if(user.loc == my_observers[user])
				return 0*/

	cancel_camera(user)
	return -1
