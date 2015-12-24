
/obj/machinery/overmap_vehicle/proc/enter_deepspace(var/obj/effect/zlevelinfo/transit_z)
	if(!transit_z)
		testing("Error: [src] attempting to enter transit without a transit zlevel from [x],[y],[z]")
		return

	testing("[src] is entering deepspace")
	z = transit_z.z
	cruising = 1

/obj/machinery/overmap_vehicle/proc/exit_deepspace(var/obj/effect/overmapobj/overmapobj)
	/*
	if(overmapobj)
		//come in on the top zlevel
	else
		//create a new temporary sector
		*/

	testing("[src] has exited deepspace at [overmapobj]")
