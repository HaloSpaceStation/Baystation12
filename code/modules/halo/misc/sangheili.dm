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
	syllables = list("ree","wortwortwort","wort","nnse","nee","kooree","keeoh","cheenoh","rehmah","nnteh","hahdeh","nnrah","kahwah","ee","hoo","roh","usoh","ahnee","ruh","eerayrah","sohruh","eesah")

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

/obj/item/clothing/suit/armor/combatharness/New()
	..()
	for(var/i in specials)
		specials -= i
		specials += new i (src)


/obj/item/clothing/suit/armor/combatharness/handle_shield(mob/user, var/damage, atom/damage_source = null, mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")
	for(var/datum/harnessspecials/i in specials)
		return i.handle_shield(user,damage,damage_source)


/obj/item/clothing/suit/armor/combatharness/equipped(mob/user)
	for(var/datum/harnessspecials/i in specials)
		i.user = user
		return

/obj/item/clothing/suit/armor/combatharness/emp_act(severity)
	for(var/datum/harnessspecials/i in specials)
		i.tryemp(severity)

/obj/item/clothing/suit/armor/combatharness/dropped()
	for(var/datum/harnessspecials/i in specials)
		i.user = null
		return

/obj/item/clothing/suit/armor/combatharness/Destroy()
	processing_objects -= src
	for(var/item in specials)
		qdel(item)
	..()

/obj/item/clothing/suit/armor/combatharness/minor
	icon_state = "minor"
	totalshields = 100
	specials = list(/datum/harnessspecials/shields)

/obj/item/organ/heart_secondary
	name = "Secondary Heart"
	parent_organ = "chest"
	icon_state = "heart-on"
	min_broken_damage = 30

/obj/item/organ/heart_secondary/process()
	var/obj/item/organ/heart = owner.internal_organs_by_name["heart"]
	var/mob/living/carbon/human/m = owner
	if(heart && heart.is_broken())
		var/useheart = world.time + 50
		if(world.time >= useheart) //They still feel the effect.
			damage = heart.damage;heart.damage = 0
		return
	if(heart.is_broken())
		return
	m.vessel.add_reagent("blood",30) // 30 blood should be enough to resist a shallow cut at max damage for that type.

/obj/effect/SangheiliMinorSet/New()
	new /obj/item/clothing/suit/armor/combatharness/minor (src.loc)
	new /obj/item/clothing/shoes/sangheili/minor (src.loc)
	new /obj/item/clothing/head/sangheili/minor (src.loc)

