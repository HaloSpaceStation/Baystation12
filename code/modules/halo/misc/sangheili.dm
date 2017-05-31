//Put other elite stuff here
/mob/living/carbon/human/covenant/sangheili/New(var/new_loc) //Species definition in code/modules/mob/living/human/species/outsider.
	..(new_loc,"Sangheili")							//Code breaks if not placed in species folder,
	name = pick("Gryra","Bavo","N'thag","Aka","Tasze","Mrapo","Ytan","Gruze","Bykan","Isan","Sero","Bota","Grevu", \
	"Xus","Graze","Khoro","Sypo","Thytan","Zato")
	name += " "
	name += pick("'Nudum","'Regram","'Kohom","'Lasam","'Mozumee","'Vulkamai","'Kosum","'Hakam","'Wavumee","'Dasumai","'Morum","'Vontakai", \
	"'Zusov","'Srangam","'Wakam","'Hantakee","'Muramai","'Haham","'Waram","'Ronam")
	real_name = name


/datum/language/sangheili
	name = "Sangheili"
	desc = "The language of the Sangheili"
	native = 1
	syllables = list("nnse","nee","kooree","keeoh","cheenoh","rehmah","nnteh","hahdeh","nnrah","kahwah","ee","hoo","roh","usoh","ahnee","ruh","eerayrah","sohruh","eesah")

/obj/effect/overlay/shields
	icon = 'code/modules/halo/icons/elitearmour.dmi'
	icon_state = "shield"

/obj/item/clothing/head/sangheili/minor
	name = "Sangheili Combat Harness Head Armour"
	desc = "Head armour, to be used with the Sangheili Combat Harness."
	icon = 'code/modules/halo/icons/elitearmour.dmi'
	icon_state = "minor_helm"
	sprite_sheets = list("Sangheili" = 'code/modules/halo/icons/elitearmour.dmi')
	item_flags = THICKMATERIAL
	armor = list(melee = 40,bullet = 20,laser = 40,energy = 5,bomb = 25,bio = 0,rad = 0) //Slightly higher bullet resist than Spartan helmets. Lower laser, energy and melee.

/obj/item/clothing/shoes/sangheili/minor
	name = "Sanghelli Combat Harness Leg Armour"
	desc = "Leg armour, to be used with the Sangheili Combat Harness."
	icon = 'code/modules/halo/icons/elitearmour.dmi'
	icon_state = "minor_legs"
	sprite_sheets = list("Sangheili" = 'code/modules/halo/icons/elitearmour.dmi')
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
	var/obj/effect/overlay/shields/s = new /obj/effect/overlay/shields
	var/datum/harnessspecials/shields/sh
	var/mob/living/m

/obj/item/clothing/suit/armor/combatharness/New()
	..()
	processing_objects += src // Needed for the shield recharge.
	if(/datum/harnessspecials/shields in specials) //Needed to set the shield capacity.
		sh = new /datum/harnessspecials/shields
		sh.totalshields = totalshields


/obj/item/clothing/suit/armor/combatharness/handle_shield(mob/user, var/damage, atom/damage_source = null, mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")
	if(/datum/harnessspecials/shields in specials)
		sh.user = user
		if(sh.checkshields(damage) == 1)
			user.overlays += s
			armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0) //This is needed because shields don't work if armour absorbs the blow instead.
			return 1
		else
			user.overlays -= s
			armor = list(melee = 95, bullet = 80, laser = 30, energy = 30, bomb = 60, bio = 25, rad = 25)
			return 0

/obj/item/clothing/suit/armor/combatharness/equipped(mob/user)
	m = user
	return

/obj/item/clothing/suit/armor/combatharness/process()
	if(/datum/harnessspecials/shields in specials)
		sh.tryrecharge(m)

/obj/item/clothing/suit/armor/combatharness/emp_act(severity)
	if(/datum/harnessspecials/shields in specials)
		switch(severity)
			if(1)
				sh.shieldstrength = sh.totalshields /4
			if(2)
				sh.shieldstrength = sh.totalshields/2

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
	if(m.vessel.get_reagent_amount("blood") < m.vessel.total_volume)
		m.vessel.add_reagent("blood",30) // 30 blood should be enough to resist a shallow cut at max damage for that type.
		return

