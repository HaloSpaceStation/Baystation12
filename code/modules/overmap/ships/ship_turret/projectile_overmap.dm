
//special projectile type specifically for overmaps
//we could use ordinary projectiles, but this lets us do some extra neat stuff

/obj/item/projectile/overmap
	icon = 'overmap_turrets.dmi'
	var/susceptible_to_counterfire = 0
	animate_movement = 0

/obj/item/projectile/overmap/bullet_act(var/obj/item/projectile/P, def_zone)
	. = PROJECTILE_CONTINUE
	if(susceptible_to_counterfire)
		. = 0