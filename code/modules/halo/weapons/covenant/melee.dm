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
	embed = 0



/obj/item/weapon/melee/energysword/attack_self(var/mob/living/user)
	if(!deployed)
		playsound(src.loc,'code/modules/halo/sounds/Energysworddeploy.ogg',75)
		icon_state = "T1EW-deployed"
		force = 50
		throwforce = 25
		w_class = 4
		deployed = 1
		sharp = 1
		edge = 1
		hitsound = 'code/modules/halo/sounds/Energyswordhit.ogg'
		visible_message("<span class='notice'>[usr] activates the [src]</span>")
		clean_blood()
		return
	else
		icon_state = "T1EW Handle"
		force = 1
		throwforce = 1
		w_class = 1
		deployed = 0
		sharp = 0
		edge = 0
		hitsound = initial(hitsound)
		visible_message("<span class='notice'>[src] deactivates [src]</span>")
		clean_blood()
		return