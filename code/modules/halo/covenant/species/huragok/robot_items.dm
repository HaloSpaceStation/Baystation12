
/obj/item/stack/material/cyborg/nanolaminate
	icon = 'code/modules/halo/covenant/materials.dmi'
	icon_state = "nanolaminate"
	default_type = "nanolaminate"
	charge_costs = list(0.1)

/obj/item/weapon/reagent_containers/borghypo/huragok
	name = "lifeworker hypoinjector"
	icon = 'code/modules/halo/covenant/species/huragok/items.dmi'
	icon_state = "huragok_injector"

	amount_per_transfer_from_this = 5
	volume = 30000
	possible_transfer_amounts = null

	charge_cost = 0.1
	charge_tick = 0
	recharge_time = 10 //Time it takes for shots to recharge (in seconds)

	reagent_ids = list(/datum/reagent/biofoam, /datum/reagent/triadrenaline, /datum/reagent/tricordrazine,/datum/reagent/oxycodone, /datum/reagent/inaprovaline,/datum/reagent/iron/huragok, /datum/reagent/spaceacillin, /datum/reagent/bicaridine, /datum/reagent/dermaline, /datum/reagent/dylovene, /datum/reagent/dexalinp, /datum/reagent/alkysine, /datum/reagent/peridaxon, /datum/reagent/imidazoline, /datum/reagent/otomax)
	reagent_volumes = list()
	reagent_names = list()

/obj/item/weapon/gripper/cilia
	name = "cilias"
	desc = "Multiple cilias that are part of a tentacle."
	icon = 'code/modules/halo/covenant/species/huragok/items.dmi'
	icon_state = "cilia"

	flags = NOBLUDGEON

	//Has a list of items that it can hold.
	can_hold = list(
		/obj/item
		)

/obj/item/weapon/armor_patch/huragok
	name = "Huragok Repair Supplies"
	desc = "A set of infinite use materials and tools that will replenish armour plating. May need multiple appllcations."
	icon_state = "armor_patch_cov"
	repair_supplies = 15 //This is just setting the per click max repair amount. Lower than normal because they have infinite supplies.

/obj/item/weapon/armor_patch/huragok/reduce_supplies(var/amt)
	return