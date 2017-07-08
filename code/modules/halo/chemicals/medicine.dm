
/datum/reagent/triadrenaline
	name = "Tri-Adrenaline"
	id = "triadrenaline"
	description = "An extremely powerful synthetic stimulant. Capable of restarting the hearts of the dead."
	reagent_state = LIQUID
	color = "#00BFFF" //Same as inaprovaline because why not!
	metabolism = 0.2
	overdose = REAGENTS_OVERDOSE
	scannable = 1
	affects_dead = 1

/datum/reagent/triadrenaline/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	M.adjustOxyLoss(-300 * removed)
	if(istype(M,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		var/Ghost = 0
		if (M.stat == DEAD)
			M.visible_message("[H] begins to violently twitch", "You feel your muscles suddenly become tense")
			//These few bits are a shameless rip from the defib code
			for(var/mob/dead/observer/G in world)
				if(G.mind == M.mind)
					G << "Return to your body to be revived!"
					sleep(100)
					if(G.mind == M)
						H.visible_message("[H] falls limp", "Your muscles relax")
						Ghost = 1
					break
			if(!Ghost)
				H.visible_message("[H] suddenly gasps for air", "You suddenly feel air enter your lungs")
				H.tod = null
				H.timeofdeath = 0
				H.stat = CONSCIOUS
				H.regenerate_icons()
				H.failed_last_breath = 0 //So mobs that died of oxyloss don't revive and have perpetual out of breath.
			//End shameless rip
			holder.remove_reagent("triadrenaline", dose/2)
		if(dose > overdose) //TODO: MOVE TO OVERDOSE PROC.
			var/obj/item/organ/heart/O = H.internal_organs_by_name["heart"]
			if(O && prob(15))
				O.damage += 300 //Your heart exploded poor you
				holder.remove_reagent("triadrenaline", dose)
				H << "You feel a sudden stabbing pain in your chest"
			else
				if(prob(25))
					H << "You feel your heart thundering in your chest"
				H.pulse = PULSE_2FAST

/datum/reagent/biofoam
	name = "Bio-Foam"
	id = "biofoam"
	description = "A regenerative foaming agent which is capable of fixing bones and stopping bleeding"
	reagent_state = LIQUID
	color = "#edd9c0"
	metabolism = 1 //Biofoam is used very quickly
	overdose = 10 //Very careful with biofoam, don't want expansion into your lungs, do we now?
	scannable = 1
	affects_dead = 1

/datum/reagent/biofoam/proc/check_and_stop_bleeding(var/obj/item/organ/o)
	if(o.status & ORGAN_BLEEDING)
		o.status &= ~ORGAN_BLEEDING
		o.owner << "<span class = 'notice'>You feel the biofoam stop the bleeding in your [o.name]</span>"

/datum/reagent/biofoam/proc/mend_external(var/mob/living/carbon/human/H)
	for(var/obj/item/organ/external/o in H.organs)
		if(o.brute_dam + o.burn_dam >= o.min_bruised_damage)
			o.brute_dam -= o.min_bruised_damage
			o.burn_dam -= o.min_bruised_damage
			if(prob(20))
				H <<"<span class = 'notice'>You feel your [o.name] knitting itself back together</span>"
		if(o.status & ORGAN_BROKEN)
			o.status &= ~ORGAN_BROKEN
			H.next_pain_time = world.time //Overrides the next pain timer
			H.custom_pain("<span class = 'userdanger'>You feel the bones in your [o.name] being pushed into place.</span>")
			check_and_stop_bleeding(o)

/datum/reagent/biofoam/proc/mend_internal(var/mob/living/carbon/human/H)
	for(var/obj/item/organ/I in H.internal_organs)
		check_and_stop_bleeding(I)
		if(I.damage >= I.min_bruised_damage)
			I.damage -= I.min_bruised_damage

/datum/reagent/biofoam/proc/fix_wounds(var/mob/living/carbon/human/H)
	for(var/obj/item/organ/external/o in H.organs)
		for(var/wounds in o.wounds)
			var/datum/wound/W = wounds
			if(W.bleed_timer > 0)
				o.owner << "<span class = 'notice'>You feel the bleeding in your [o.name] slow.</span>"
				W.bandaged = 1
				W.salved = 1
				o.update_damages()

/datum/reagent/biofoam/affect_blood(var/mob/living/carbon/M,var/alien,var/removed) //Biofoam stops internal and external bleeding, heals organs and fixes bones.
	if(istype(M,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		var/obj/p = pick(H.organs)
		H.pain(p.name,2,1,1)
		fix_wounds(H)
		mend_external(H)
		mend_internal(H)
