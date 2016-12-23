
/obj/item/projectile/autocannon120
	name = "autocannon round"
	icon_state = "gauss"
	damage = 500
	damage_type = BRUTE
	check_armour = "bomb"

/obj/item/projectile/rotary110
	name = "rotary cannon round"
	icon_state = "gauss"
	damage = 250
	damage_type = BRUTE
	check_armour = "bomb"

/obj/item/projectile/missile
	name = "missile"
	icon_state = "missile"
	icon = 'code/modules/overmap/overmap_vehicles/icons/weapons.dmi'
	var/sensors_thermal = 0
	var/sensors_mass = 0
	var/expl_range = 4				//if this is <1 then only apply impact damage
	var/expl_dmg = 6
	var/impact_damage = 1000		//damage applied to vehicles on impact
	var/impact_damage_mod = 500		//random extra damage

/obj/item/projectile/missile/launch_heading()
	icon_state = "missile_thrust"
	..()

/obj/item/projectile/missile/Bump(atom/A as mob|obj|turf|area, forced=0)

	if(!A)
		//qdel(src)
		return 0

	if(A == src)
		return 0 //no

	if(A == firer)
		if(istype(A, /atom/movable) && A:bound_width == 32 && A:bound_height == 32)
			loc = A.loc
		return 0 //cannot shoot yourself

	if((bumped && !forced) || (A in permutated))
		return 0

	//not all missiles explode
	if(expl_range > 1)
		//proc/explosion(turf/epicenter, devastation_range, heavy_impact_range, light_impact_range, flash_range, adminlog = 1)
		explosion(src.loc, expl_range-4, expl_range-2, expl_range, expl_range, 0)
	else if(istype(A, /obj/machinery/overmap_vehicle))
		var/obj/machinery/overmap_vehicle/V = A
		V.impact_occupants_major("\icon[src] <span class='danger'>You are hit by [src]!</span>")
		V.take_damage(impact_damage + rand(0, impact_damage_mod))
	else
		A.ex_act(2)

	//explosion graphic
	var/datum/effect/system/explosion/E = new/datum/effect/system/explosion()
	E.set_up(src.loc)
	E.start()

	//todo: sound
	//i'd expect most of the time the missile would fire and impact in space (meaning no sound)
	//there's always those unexpected use cases (fly fighter into hangar, unload etc)

/obj/item/projectile/missile/asgm10
	name = "ASGM-10 Missile"
	desc = "Latest generation Air-Space-Ground Missile for multirole usage."
	impact_damage = 2000
	impact_damage_mod = 1000
	sensors_thermal = 1
	sensors_mass = 1
