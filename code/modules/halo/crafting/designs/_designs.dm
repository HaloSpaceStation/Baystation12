/*
#define IMPRINTER	0x1	//For circuits. Uses glass/chemicals.
#define PROTOLATHE	0x2	//New stuff. Uses glass/metal/chemicals
#define MECHFAB		0x4	//Mechfab
#define CHASSIS		0x8	//For protolathe, but differently

//hs13 research:
imprinter: uses chemicals and materials
protolathe: uses materials and components (objects)
*/

/datum/research_design
	var/name
	var/product_type
	var/required_reagents = list()
	var/required_materials = list()
	var/required_objs = list()
	var/build_type = 0
	var/complexity = 0
	var/consumables_string

/datum/research_design/proc/GetConsumablesString()
	if(!consumables_string)
		UpdateConsumablesString()
	return consumables_string

/datum/research_design/proc/UpdateConsumablesString()
	var/list/consumables = list()
	consumables_string = "NA"

	consumables += format_materials_list(required_materials)
	consumables += format_reagents_list(required_reagents)

	//we just put in a custom obj name here so its east
	for(var/entry in required_objs)
		consumables += required_objs[entry]

	consumables_string = english_list(consumables, nothing_text = "None")
