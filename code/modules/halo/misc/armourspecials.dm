
/datum/armourspecials
	var/mob/living/carbon/human/user

/obj/effect/overlay/shields
	icon = 'code/modules/halo/icons/elitearmour.dmi'
	icon_state = "shield"

/datum/armourspecials/shields
	var/shieldstrength
	var/totalshields
	var/nextcharge
	var/warned
	var/s = new /obj/effect/overlay/shields
	var/obj/item/clothing/suit/armor/special/connectedarmour

/datum/armourspecials/proc/tryemp(var/severity)

/datum/armourspecials/proc/tryexplosion(var/severity)

/datum/armourspecials/proc/handle_shield(mob/user, var/damage, atom/damage_source = null, mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")
	return 0

/datum/armourspecials/proc/tryshields(var/mob/living/m)

/datum/armourspecials/proc/try_item_action()

/datum/armourspecials/shields/New(var/obj/item/clothing/suit/armor/special/c) //Needed the type path for typecasting to use the totalshields var.
	connectedarmour = c
	totalshields = connectedarmour.totalshields
	shieldstrength = totalshields


/datum/armourspecials/shields/handle_shield(mob/m,damage,atom/damage_source)
	if(checkshields(damage))
		user.overlays += s
		connectedarmour.armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0) //This is needed because shields don't work if armour absorbs the blow instead.
		return 1
	else
		user.overlays -= s
		connectedarmour.armor = list(melee = 95, bullet = 80, laser = 30, energy = 30, bomb = 60, bio = 25, rad = 25)
		processing_objects += src
		return 0

/datum/armourspecials/shields/proc/checkshields(var/damage,var/damage_source)
	if(shieldstrength> 0)
		shieldstrength -= damage
		user.visible_message("<span class='warning'>[user]'s shields absorbs the force of the impact</span>","<span class = 'notice'>Your shields absorbs the force of the impact</span>")
		return 1
	if(shieldstrength<= 0)
		if(!warned) //Stops spam and constant resetting
			user.visible_message("<span class ='warning'>[usr]'s shield collapses!</span>","<span class ='userdanger'>Your shields fizzle and spark, losing their protective ability!</span>")
		warned = 1
		nextcharge = world.time + 30 // 3 seconds
		return 0

/datum/armourspecials/shields/tryshields(var/mob/living/m)
	if(shieldstrength >= totalshields)
		shieldstrength = totalshields
		processing_objects -= src
		return 0
	if(world.time > nextcharge)
		shieldstrength += 10
		if(prob(25)&& !isnull(m)) //Stops runtime when no mob to display message to.
			m.visible_message("<span class = 'notice'>A faint ping emanates from [m.name]'s armour.</span>","<span class ='notice'>Current shield level: [(shieldstrength/totalshields)*100]</span>")
		nextcharge = world.time + 20 // 2 seconds.
		warned = 0
		return 1

/datum/armourspecials/shields/tryemp(severity)
	switch(severity)
		if(1)
			shieldstrength -= totalshields /4
		if(2)
			shieldstrength -= totalshields/2

/datum/armourspecials/shields/proc/process()
	tryshields(user)
	return

/datum/armourspecials/dispensemeds
	var/stored_meds[0]

/datum/armourspecials/dispensemeds/try_item_action()
	if(stored_meds.len <= 0)
		return user << "<span class = 'notice'>Emergency medical supplies exhausted.</span>"
	if(user.put_in_active_hand(stored_meds[stored_meds.len]))
		stored_meds.Cut(stored_meds.len)
		return user << "<span class ='notice'>[stored_meds.len] </span>"
	else if(user.put_in_inactive_hand(stored_meds[stored_meds.len]))
		stored_meds.Cut(stored_meds.len)
		return user << "<span class ='notice'>[stored_meds.len] </span>"
	else
		return user << "<span class ='notice'>No space in user's hands availiable for medical support.</span>"

/datum/armourspecials/dispensemeds/spartan
	stored_meds = list(/obj/item/weapon/reagent_containers/syringe/ld50_syringe/spartan,
	/obj/item/weapon/reagent_containers/syringe/ld50_syringe/spartan,
	/obj/item/weapon/reagent_containers/syringe/ld50_syringe/spartan,
	/obj/item/weapon/reagent_containers/syringe/ld50_syringe/spartan,
	/obj/item/weapon/reagent_containers/syringe/ld50_syringe/spartan,
	/obj/item/weapon/reagent_containers/syringe/ld50_syringe/spartan)

/datum/armourspecials/cloaking // Placeholders for later stuff.

/datum/armourspecials/thrusters
