/*
//DATANETS//
This system is intended to replace standard SS13 signalling with a more simplified process light implementation that integrates nicely with overmap.

It is also intended to be the basis for an actual networking system for communication between networked objects without a single master controller (aka peer to peer)

Visualise each datanet as the smallest possible group of things needing a specific overarching logic, with the logic independant of both any physical objects and the network itself

/datum/datanet_logic represents the actual logic modules. Modules represent the actual logic components which do stuff independantly of anything actually placed in the game.

To have an ingame controller (ie a "server" or "master console" or "root admin account" or w/e) you can just fake that via the logic module

Each datanet can only have 1 of each module type, so if you need to link multiple module types simply link them via a custom datanet (TBD)

See code\game\machinery\machinery.dm for first stage initialisation
See code\modules\overmap\controller\initiailise_overmapobj.dm for final stage initialisation
Note that some debugging stuff is present in the overmap controller, and as long as it exists the initialisation cant be fully cleaned up
*/

//list indexes are the datanet tags
var/list/all_datanets = list()

//multid list [zlevel_tag][datanet_tag] = list(machines)
var/list/uninitialised_datanets = list()

/datum/datanet
	var/list/linked_atoms = list()
	var/processing = 0
	var/datanet_tag

	//a logic module represents a specialised controller for some or all of the linked datums
	//machines cannot be linked to multiple logic modules of the same type
	var/list/all_modules = list()
	var/list/modules_by_type = list()

/datum/datanet/New(var/list/starting_atoms, var/my_tag)
	datanet_tag = my_tag
	link_atoms(starting_atoms)

/datum/datanet/proc/link_atoms(var/list/new_atoms)
	for(var/atom/A in new_atoms)
		link_atom(A)

/datum/datanet/proc/link_atom(var/atom/A)
	linked_atoms.Add(A)

	//loop over all modules and tell them about this datum
	//if the module doesnt care about this datum it will ignore it
	for(var/datum/datanet_logic/datanet_logic in all_modules)
		datanet_logic.link_atom(A)

	//once we have finished all other processing, tell the whatever-it-was
	A.datanet_linked(src)

/datum/datanet/proc/require_logic_module(var/module_type)
	//world << "/datum/datanet/proc/require_logic_module([module_type]) [datanet_tag]"
	//a recently linked atom requires a specific logic set so lets make sure its enabled
	var/datum/datanet_logic/datanet_logic = modules_by_type[module_type]
	if(!datanet_logic)
		//world << "	check1"
		datanet_logic = new module_type(linked_atoms, tag)
		modules_by_type[module_type] = datanet_logic
		all_modules.Add(datanet_logic)
	else
		//world << "	check2"

/datum/datanet/proc/merge_logic_module(var/datum/datanet_logic/new_logic)
	var/datum/datanet_logic/old_logic = modules_by_type[new_logic.type]
	if(old_logic)
		all_modules -= old_logic
		new_logic.link_atoms(linked_atoms)
	modules_by_type[new_logic.type] = new_logic
	qdel(old_logic)

/*
/datum/datanet/proc/process()
	//override in children

/datum/datanet/proc/process_start()
	if(!processing)
		processing = 1
		processing_objects.Add(src)

/datum/datanet/proc/process_stop()
	if(processing)
		processing = 0
		processing_objects.Remove(src)
*/
/*
/datum/datanet/proc/dummy_receive_signal(datum/signal/signal, receive_method, receive_param)

/datum/datanet/proc/dummy_post_signal(datum/signal/signal, var/list/recipients)
	for(var/obj/O in recipients)
		O.receive_signal(signal)
*/

/*
/datum/datanet/proc/add_obj(var/atom/obj/O)
	if(istype(O, /obj/machinery/computer))
		linked_computers.Add(O)
		. = 1

	else if(istype(O, /obj/machinery/overmap_vehicle))
		linked_vehicles.Add(O)
		. = 1

	else if(istype(O, /obj/machinery/door/blast))
		linked_blastdoors.Add(O)
		. = 1

	else if(istype(O, /obj/machinery))
		linked_machines.Add(O)
		. = 1

	if(.)
		all_linked_objs.Add(O)

/datum/datanet/proc/remove_obj(var/atom/obj/O)
	if(linked_computers.Remove(O))
		. = 1

	else if(linked_vehicles.Remove(O))
		. = 1

	else if(linked_blastdoors.Remove(O))
		. = 1

	else if(linked_machines.Remove(O))
		. = 1

	if(.)
		all_linked_objs.Remove(O)
*/
