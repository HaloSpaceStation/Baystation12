
//General rule for giving guns larger burst-size firemodes: triple base burst size and multiply dispersions by 1.5
//or add like .1/.2 to the disp.

/client/MouseDrag(src_object,over_object,src_location,over_location,src_control,over_control,params)
	if(mob && istype(mob,/mob/living/carbon/human))
		var/mob/living/carbon/human/h = mob
		var/obj/item/weapon/gun/g = h.get_active_hand()
		//If we have one already (and are thus firing!), change our target!
		if(istype(g))
			spawn()
				if(!g.stored_targ)
					g.Fire(over_object, mob, params, h.Adjacent(over_location), 0)
				else
					g.stored_targ = over_location
		return 1
	return ..()