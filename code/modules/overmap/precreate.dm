/obj/effect/mapinfo/precreated
	name = "precreated sector"
	sectorname = "CHANGE ME"
	obj_type = /obj/effect/map/sector


/obj/effect/mapinfo/precreated/New()
	..()
	tag = "sector[z]"

/**
/******FOR EXAMPLE USE ONLY******/
/client/proc/load_precreated_sector(var/level=input("Level to load: ") as num)
	set category = "Admin"
	set name = "Load Precreated Sector by Level"
	set desc = "Load a precreated sector by its level"

	var/obj/effect/mapinfo/precreated/data = cached_spacepre["[level]"]
	map_sectors["[level]"] = new data.obj_type(data)
	data.mapx += 5
	map_sectors["[level]a"] = new data.obj_type(data)

	for(var/obj/machinery/computer/helm/H in machines)
		H.reinit()

	return
**/