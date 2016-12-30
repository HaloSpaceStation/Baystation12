
//a logic controller interface for use in datanets
//override for specific implementations

/datum/datanet_logic
	var/processing = 0
	var/datanet_tag

//override in children if needed, but remember to call the parent proc via ..()
/datum/datanet_logic/New(var/list/starting_atoms, var/my_tag)
	datanet_tag = my_tag
	link_atoms(starting_atoms)

/datum/datanet_logic/proc/link_atom(var/atom/A)
	//override in children

/datum/datanet_logic/proc/process()
	//override in children




//do not override these in children

/datum/datanet_logic/proc/link_atoms(var/list/new_atoms)
	for(var/atom/A in new_atoms)
		link_atom(A)

/datum/datanet_logic/proc/process_start()
	if(!processing)
		processing = 1
		processing_objects.Add(src)
//
/datum/datanet_logic/proc/process_stop()
	if(processing)
		processing = 0
		processing_objects.Remove(src)
