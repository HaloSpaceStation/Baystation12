
#define SYRINGE_DRAW 0
#define SYRINGE_INJECT 1
#define SYRINGE_BROKEN 2

/obj/item/weapon/reagent_containers/syringe/ld50_syringe/spartan
	name = "Field Medical Syringe"
	desc = "A potent cocktail of chemicals which allows for increased survivability in the field. Contains biofoam, Tricordrazine and Polypseudomorphine. Biofoam component will not function unless 15 seconds has passed between injections."
	amount_per_transfer_from_this = 15
	volume = 15
	time = 30

	New()
		..() //There was Tri-Adrenaline here. It led to lots of scorespam.
		reagents.add_reagent(/datum/reagent/biofoam,5)
		reagents.add_reagent(/datum/reagent/tricordrazine,5)
		reagents.add_reagent(/datum/reagent/polypseudomorphine,5)
		mode = SYRINGE_INJECT
		update_icon()

/obj/item/weapon/reagent_containers/syringe/ld50_syringe/triadrenaline
	name = "Tri-Adrenaline Syringe"
	desc = "A spring-loaded syringe of tri-adrenaline. Used for resuscitation"
	amount_per_transfer_from_this = 15
	volume = 15
	visible_name = "a giant syringe"
	time = 30

	New()
		..()
		reagents.add_reagent(/datum/reagent/triadrenaline, 10)
		reagents.add_reagent(/datum/reagent/polypseudomorphine, 5)
		mode = SYRINGE_INJECT
		update_icon()

/obj/item/weapon/reagent_containers/syringe/psychostimulant
	name = "Psychostimulant Syringe"
	desc = "A dangerous syringe full of a potent brain-mending concoction used to treat traumatic brain injuries. Side effects include loss of consciousness; contains biofoam."
	amount_per_transfer_from_this = 15
	volume = 15
	time = 30

	New()
		..()
		reagents.add_reagent(/datum/reagent/alkysine, 3)
		reagents.add_reagent(/datum/reagent/inaprovaline, 7)
		reagents.add_reagent(/datum/reagent/biofoam, 5)
		mode = SYRINGE_INJECT
		update_icon()

//Iron pills + bottle define//
/obj/item/weapon/reagent_containers/pill/iron
	name = "Iron pill (20u)"
	desc = "Used to increase the speed of blood replenishment."
	icon_state = "pill18"
	New()
		..()
		reagents.add_reagent(/datum/reagent/iron, 20)

/obj/item/weapon/storage/pill_bottle/iron
	name = "bottle of Iron pills"
	desc = "Contains pills used to assist in blood replenishment."

	startswith = list(/obj/item/weapon/reagent_containers/pill/iron = 7)

/obj/item/weapon/reagent_containers/pill/hyronalin
	name = "Hyronalin pill (10u)"
	desc = "Used to remove radiation poisoning."
	icon_state = "pill17"
	New()
		..()
		reagents.add_reagent(/datum/reagent/hyronalin, 10)

/obj/item/weapon/storage/pill_bottle/hyronalin
	name = "bottle of Hyronalin pills"
	desc = "Contains pills used to assist in radiation damage."

	startswith = list(/obj/item/weapon/reagent_containers/pill/hyronalin = 7)

/obj/item/weapon/reagent_containers/pill/polypseudomorphine
	name = "Polypseudomorphine pill (10u)"
	desc = "Used to kill pain and in higher doses, sedate people. Do not exceed 10u unless attempting sedation."
	icon_state = "pill17"
	New()
		..()
		reagents.add_reagent(/datum/reagent/polypseudomorphine, 10)

/obj/item/weapon/storage/pill_bottle/polypseudomorphine
	name = "bottle of polypseudomorphine pills"
	desc = "Contains pills used to kill pain and in higher doses, sedate people. Do not exceed 10u."

	startswith = list(/obj/item/weapon/reagent_containers/pill/polypseudomorphine = 7)

// NEW BIOFOAM CANISTERS //

/obj/item/weapon/reagent_containers/syringe/biofoam
	name = "\improper Biofoam Canister"
	desc = "A military-grade olive drab canister filled with biofoam, used to rapidly fix internal and external injuries. Do not inject a second dose until fifteen seconds have passed, as interference from the remnants of previous injections may lead to a lethal overdose."
	icon = 'code/modules/halo/medicine/biofoam.dmi'
	icon_state = "unsc_10"
	amount_per_transfer_from_this = 10

	New()
		..()
		reagents.add_reagent(/datum/reagent/biofoam, 10)
		mode = SYRINGE_INJECT
		update_icon()

	update_icon()
		overlays.Cut()

		if(mode == SYRINGE_BROKEN)
			icon_state = "unsc_broken"
			return

		var/rounded_vol = round(reagents.total_volume, round(reagents.maximum_volume / 3))
		if(ismob(loc))
			var/injoverlay
			switch(mode)
				if (SYRINGE_DRAW)
					injoverlay = "draw"
				if (SYRINGE_INJECT)
					injoverlay = "inject"
			overlays += injoverlay
		icon_state = "unsc_[rounded_vol]"
		item_state = "unsc_[rounded_vol]"

		if(reagents.total_volume)
			filling = image('icons/obj/reagentfillings.dmi', src, "biofoam10")

			filling.icon_state = "biofoam[rounded_vol]"

			filling.color = reagents.get_color()
			overlays += filling

/obj/item/weapon/reagent_containers/syringe/biofoam/urf
	name = "\improper Biofoam Canister"
	desc = "A civilian-grade canister filled with biofoam, used to rapidly fix internal and external injuries. Do not inject a second dose until fifteen seconds have passed, as interference from the remnants of previous injections may lead to a lethal overdose."
	icon_state = "urf_10"

	update_icon()
		overlays.Cut()

		if(mode == SYRINGE_BROKEN)
			icon_state = "urf_broken"
			return

		var/rounded_vol = round(reagents.total_volume, round(reagents.maximum_volume / 3))
		if(ismob(loc))
			var/injoverlay
			switch(mode)
				if (SYRINGE_DRAW)
					injoverlay = "draw"
				if (SYRINGE_INJECT)
					injoverlay = "inject"
			overlays += injoverlay
		icon_state = "urf_[rounded_vol]"
		item_state = "urf_[rounded_vol]"

/obj/item/weapon/reagent_containers/syringe/biofoam/cov
	name = "\improper Covenant Biofoam Canister"
	desc = "An advanced injection device filled with biofoam, used to rapidly fix internal and external injuries. Do not inject a second dose until fifteen seconds have passed, as interference from the remnants of previous injections may lead to a lethal overdose."
	icon_state = "cov_10"

	update_icon()
		overlays.Cut()

		if(mode == SYRINGE_BROKEN)
			icon_state = "cov_broken"
			return

		var/rounded_vol = round(reagents.total_volume, round(reagents.maximum_volume / 3))
		if(ismob(loc))
			var/injoverlay
			switch(mode)
				if (SYRINGE_DRAW)
					injoverlay = "draw"
				if (SYRINGE_INJECT)
					injoverlay = "inject"
			overlays += injoverlay
		icon_state = "cov_[rounded_vol]"
		item_state = "cov_[rounded_vol]"

#undef SYRINGE_DRAW
#undef SYRINGE_INJECT
#undef SYRINGE_BROKEN
