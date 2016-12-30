
/client/proc/savezlevel()
	set category = "Server"
	set name = "Save zlevel to mapfile"
	if(!check_rights(R_SERVER))	return

	var/filename = input("Enter map name", "Save zlevel to mapfile", "mymap[world.timeofday]")
	if(!filename)
		filename = "mymap[world.timeofday]"

	var/targetz = input("Enter zlevel (use default value for current zlevel)", "Save zlevel to mapfile", usr.z) as num
	if(targetz < 1 || targetz > world.maxz)
		usr << "<span class='warning'>Invalid zlevel</span>"
		return

	log_admin("[key_name(src)] saved zlevel [targetz] to mapfile \'[filename].dmm\'")
	message_admins("[key_name(src)] started saving zlevel [targetz] to mapfile \'[filename].dmm\'", 1)

	var/turf/t1 = locate(1, 1, targetz)
	var/turf/t2 = locate(world.maxx, world.maxy, targetz)
	maploader.save_map(t1, t2, filename)
	message_admins("	Finished saving \'[filename].dmm\'", 1)
