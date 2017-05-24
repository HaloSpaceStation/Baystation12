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
		playsound(src.loc,'code/modules/halo/sounds/Energysworddeploy.ogg')
		icon_state = "T1EW-deployed"
		force = 50
		throwforce = 25
		w_class = 4
		deployed = 1
		visible_message("<span class='notice'>[usr] activates the [src]</span>")
		return
	else
		icon_state = "T1EW Handle"
		force = 1
		throwforce = 1
		w_class = 1
		deployed = 0
		visible_message("<span class='notice'>[src] deactivates [src]</span>")
		return