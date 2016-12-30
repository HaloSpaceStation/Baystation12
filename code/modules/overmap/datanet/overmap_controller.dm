
/datum/controller/process/overmap/proc/setup_datanets()

	//world << "/datum/controller/process/overmap/proc/setup_datanets()"

	//first loop over all the zlevels and only grab the ones we are interested in
	var/list/processed = list()
	for(var/zlevel_tag in uninitialised_datanets)
		//world << "	zlevel_tag:[zlevel_tag]"

		//get the relevant map sector
		var/obj/effect/overmapobj/overmapobj = map_sectors[zlevel_tag]

		if(overmapobj)
			//world << "	found sector..."

			//it is, so lets loop over all the datanets and set them up
			var/list/datanet_tags = uninitialised_datanets[zlevel_tag]
			//world << "	datanet_tags.len:[datanet_tags.len]"
			for(var/datanet_tag in datanet_tags)
				//world << "		datanet_tag:[datanet_tag]"
				var/list/datanet_machines = datanet_tags[datanet_tag]
				//world << "		datanet_machines.len:[datanet_machines.len]"
				var/datum/datanet/D = new(datanet_machines, datanet_tag)
				overmapobj.my_datanets.Add(D)
				overmapobj.datanets_by_tag[datanet_tag] = D
				all_datanets.Add(D)

				//clean up
				//datanet_machines = list()

			//clean up
			//datanet_tags = list()
			//processed += zlevel_tag

		else
			//world << "	sector not found!"

	uninitialised_datanets -= processed
