
/atom
	var/datanet_tag

	//tell us when we become linked to a datanet (requires datanet_tag set above)
	proc/datanet_linked(var/datum/datanet/datanet)

	// tell us when a logic module is successfully linked
	proc/datanet_logic_linked(var/datum/datanet_logic/logic_module)

//call this in atom/New()
//see also code\modules\lighting\lighting_atom.dm (for some reason?)
/atom/New()
	. = ..()
	//see code\modules\overmap\datanet\_datanet.dm
	if(datanet_tag)
		world << "/atom/New() datanet_tag:[datanet_tag] src:[src] src.type:[src.type]"
		//world << "<b>/atom/New() datanets</b>"
		//see if there is a datanet for us to connect to
		var/datum/datanet/D = all_datanets[datanet_tag]
		if(D)
			//world << "	check1"
			D.link_atom(src)
		else
			//world << "	check2"
			//otherwise get us ready to connect to a datanet

			//first grab the list of machines for our zlevel
			var/zlevel_tag = "[src.z]"
			var/list/zlevel_datanets = uninitialised_datanets[zlevel_tag]
			if(!zlevel_datanets)
				zlevel_datanets = list()
				uninitialised_datanets[zlevel_tag] = zlevel_datanets

			var/list/datanet_machines = zlevel_datanets[datanet_tag]
			if(!datanet_machines)
				datanet_machines = list()
				zlevel_datanets[datanet_tag] = datanet_machines
			datanet_machines.Add(src)

			//the overmapobj will handle the rest of the initialisation
