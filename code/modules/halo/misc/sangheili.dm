//Put other elite stuff here
/mob/living/carbon/human/covenant/sangheili/New(var/new_loc) //Species definition in code/modules/mob/living/human/species/outsider.
	..(new_loc,"Sangheili")							//Code breaks if not placed in species folder,
	name = pick(first_names_sangheili)
	name += " "
	name += pick(last_names_sangheili)
	real_name = name


/datum/language/sangheili
	name = "Sangheili"
	desc = "The language of the Sangheili"
	native = 1
	syllables = list("wort","nnse","nee","kooree","keeoh","cheenoh","rehmah","nnteh","hahdeh","nnrah","kahwah","ee","hoo","roh","usoh","ahnee","ruh","eerayrah","sohruh","eesah")

/obj/item/clothing/head/sangheili/minor
	name = "Sangheili Combat Harness Head Armour"
	desc = "Head armour, to be used with the Sangheili Combat Harness."
	icon = 'code/modules/halo/icons/elitearmour.dmi'
	icon_state = "minor_helm"
	sprite_sheets = list("Sangheili" = 'code/modules/halo/icons/elitearmour.dmi')
	species_restricted = list("Sangheili")
	item_flags = THICKMATERIAL
	armor = list(melee = 40,bullet = 20,laser = 40,energy = 5,bomb = 25,bio = 0,rad = 0) //Slightly higher bullet resist than Spartan helmets. Lower laser, energy and melee.

/obj/item/clothing/shoes/sangheili/minor
	name = "Sanghelli Combat Harness Leg Armour"
	desc = "Leg armour, to be used with the Sangheili Combat Harness."
	icon = 'code/modules/halo/icons/elitearmour.dmi'
	icon_state = "minor_legs"
	sprite_sheets = list("Sangheili" = 'code/modules/halo/icons/elitearmour.dmi')
	species_restricted = list("Sangheili")
	item_flags = NOSLIP // Because marines get it.
	armor = list(melee = 40, bullet = 60, laser = 5, energy = 4, bomb = 40, bio = 0, rad = 0)

/obj/item/clothing/suit/armor/combatharness
	name = "Sangheili Combat Harness"
	desc = "A Sangheili Combat Harness."
	species_restricted = list("Sangheili")
	icon = 'code/modules/halo/icons/elitearmour.dmi'
	icon_state = null
	sprite_sheets = list("Sangheili" = 'code/modules/halo/icons/elitearmour.dmi')
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
//	armor = list(melee = 95, bullet = 80, laser = 30, energy = 30, bomb = 60, bio = 25, rad = 25) //Close to spartan armour. Lower bullet,higher melee. Lower energy.
	var/specials = list()
	var/totalshields
	var/datum/harnessspecials/shields/sh
	var/mob/living/m

/obj/item/clothing/suit/armor/combatharness/New()
	..()
	for(var/i in specials)
		specials -= i
		if(i == /datum/harnessspecials/shields) //Needed to set the shield capacity. I've tried using something other than the type path, sheild
			sh = new i(totalshields,src)
		else
			specials += new i


/obj/item/clothing/suit/armor/combatharness/handle_shield(mob/user, var/damage, atom/damage_source = null, mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")
	if(sh)
		return sh.handle_shield(m,damage,damage_source)


/obj/item/clothing/suit/armor/combatharness/equipped(mob/user)
	m = user
	return

/obj/item/clothing/suit/armor/combatharness/process()
	if(sh)
		sh.tryrecharge(m)

/obj/item/clothing/suit/armor/combatharness/emp_act(severity)
	if(sh)
		sh.tryemp(severity)


/obj/item/clothing/suit/armor/combatharness/Destroy()
	..()
	processing_objects -= src
	qdel(sh)

/obj/item/clothing/suit/armor/combatharness/minor
	icon_state = "minor"
	totalshields = 100
	specials = list(/datum/harnessspecials/shields)

/obj/item/organ/heart_secondary
	name = "Secondary Heart"
	parent_organ = "chest"
	icon_state = "heart-on"
	var/used = 0

/obj/item/organ/heart_secondary/process()
	if(used)
		return
	var/obj/item/organ/heart = owner.internal_organs_by_name["heart"]
	var/mob/living/carbon/human/m = owner
	if(heart && heart.damage >=heart.min_broken_damage)
		heart.damage = 0;src.name = "Used Secondary Heart";used = 1
		return
	m.vessel.add_reagent("blood",30) // 30 blood should be enough to resist a shallow cut at max damage for that type.


