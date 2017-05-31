 // make unweildy to use for marines.
 //Ideas: Half damage, make two handed.
/obj/item/weapon/melee/energysword
	name = "Energy Sword"
	desc = "Type 1 Energy Weapon"
	icon = 'code/modules/halo/icons/Covenant Weapons.dmi'
	icon_state = "T1EW Handle"
	var/deployed = 0
	force = 1
	throwforce = 1
	w_class = 1



/obj/item/weapon/melee/energysword/attack_self(var/mob/living/user)
	if(!deployed)
		playsound(src.loc,'code/modules/halo/sounds/Energysworddeploy.ogg',75)
		icon_state = "T1EW-deployed"
		force = 25
		throwforce = 12
		w_class = 4
		deployed = 1
		edge = 1
		hitsound = 'code/modules/halo/sounds/Energyswordhit.ogg'
		item_icons = list(slot_l_hand_str ='code/modules/halo/icons/Energy Sword_inhand Human.dmi')
		item_state_slots = list(
		slot_l_hand_str = "Energy sword_inhand Human l",
		slot_r_hand_str = "Energy sword_inhand Human r" )
		hitsound = 'code/modules/halo/sounds/Energyswordhit.ogg'
		visible_message("<span class='notice'>[usr] activates the [src]</span>")
		return
	else
		icon_state = "T1EW Handle"
		force = 1
		throwforce = 1
		w_class = 1
		deployed = 0
		edge = 0
		hitsound = initial(hitsound)
		item_icons = list(slot_l_hand_str = null)
		item_state_slots = list(
		slot_l_hand_str = null,
		slot_r_hand_str - null)
		clean_blood()
		hitsound = "swing_hit"
		visible_message("<span class='notice'>[src] deactivates [src]</span>")
		return
