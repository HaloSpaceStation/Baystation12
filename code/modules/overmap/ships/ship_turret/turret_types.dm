
//UNSC point defence guns

/obj/machinery/overmap_turret/autocannon
	name = "Autocannon Point Defence Turret"
	desc = "An M910 autocannon for ship point defence, firing 50mm high explosive rounds out of dual magnetic linear accelerator cannons."
	icon_state = "auto_cannon"
	fire_arc_type = 3
	projectile_type = /obj/item/projectile/autocannon50
	overmap_projectile_type = /obj/item/projectile/overmap/autocannon50
	degrees_inaccurate = 15

/obj/machinery/overmap_turret_controlseat/unsc
	desc = "A control station for a UNSC shipboard turret"
	allowed_turret_types = list(/obj/machinery/overmap_turret/autocannon)
	crosshair_icon = 'unsc_turret_crosshair.dmi'



//Covenant point defence guns

/obj/machinery/overmap_turret/plasma
	name = "Heavy Plasma Turret"
	desc = "A heavy plasma turret mounted on Covenant capital ships."
	icon_state = "plasma_cannon"
	fire_arc_type = 3
	projectile_type = /obj/item/projectile/plasma_turret
	overmap_projectile_type = /obj/item/projectile/overmap/plasma_turret
	degrees_inaccurate = 5

/obj/machinery/overmap_turret_controlseat/covenant
	icon_state = "covenant_controlseat"
	desc = "A control station for a Covenant shipboard turret"
	allowed_turret_types = list(/obj/machinery/overmap_turret/plasma)
	crosshair_icon = 'covenant_turret_crosshair.dmi'
