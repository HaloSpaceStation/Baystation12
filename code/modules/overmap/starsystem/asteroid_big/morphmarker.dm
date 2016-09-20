
//some map helper stuff to speed up generation

/obj/effect/morphmarker
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	var/indexnum = 0
	var/obj/effect/zlevelinfo/bigasteroid/asteroid_zlevel
	invisibility = 101		//until i figure out a way to easily clear them afterwards

/obj/effect/morphmarker/initialize()
	..()
	//indexnum = text2num(src.name)
	//name = "morphmarker"
	//tag = "[z]_[name]"
	asteroid_zlevel = locate("zlevel[z]")
	if(asteroid_zlevel && istype(asteroid_zlevel))
		asteroid_zlevel.morphmarkers.Add(src)
		//world << "indexnum:[indexnum]"
		//insert at the correct location
		var/success = 0
		if(asteroid_zlevel.morphturfs.len)
			//only do first 15 for testing
			/*if(asteroid_zlevel.morphmarkers.len >= 15)
				return*/

			for(var/curindex = 1, curindex <= asteroid_zlevel.morphturfs.len, curindex++)
				var/turf/unsimulated/mask/curmask = asteroid_zlevel.morphturfs[curindex]
				//world << "	curindex:[curindex]: curmask:[curmask] [curmask.type]"
				if(curmask && istype(curmask))
					var/obj/effect/morphmarker/marker = asteroid_zlevel.morphturfs[curmask]
					//world << "		marker:[marker] [marker.type]"
					if(marker && marker.indexnum > src.indexnum)
						asteroid_zlevel.morphturfs.Insert(curindex, src.loc)
						asteroid_zlevel.morphturfs[src.loc] = src
						success = 1
						//world << "			success"
						break

		if(!success)
			asteroid_zlevel.morphturfs[src.loc] = src

	//qdel(src)
