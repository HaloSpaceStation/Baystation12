/obj/item/weapon/gun/energy/plasmarifle
	name = "Plasma Rifle"
	desc = "Type=25 Directed Energy Rifle"
	icon = 'code/modules/halo/icons/Covenant Weapons.dmi'
	icon_state = "Plasma Rifle"
	slot_flags = SLOT_BACK
	//fire_sound = null // need fire sound
	charge_meter = 0
	self_recharge = 1
	max_shots = 20
	recharge_time = 10
	projectile_type = /obj/item/projectile/covenant/plasmarifle

/obj/item/weapon/gun/energy/plasmarifle/Fire()
	..()
	if(!istype(usr,/mob/living/carbon/covenant)&&prob(1)&&power_supply.charge>=charge_cost)
		var/mob/living/user = usr
		user.apply_effect(10,IRRADIATE)
		visible_message("<span class ='danger'>The [src] glows green, radioactive haze escaping from it's frame</span>")