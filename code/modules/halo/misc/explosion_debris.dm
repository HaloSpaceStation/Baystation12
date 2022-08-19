#define EXPLOSION_DEBRIS_CHANCE 30
//Projectiles below will be ignored when checking if we should block them.//
#define PROJECTILES_DEBRIS_IGNORE list(/obj/item/projectile/bullet/scorp_cannon,/obj/item/projectile/bullet/cobra_cannon,/obj/item/projectile/bullet/cobra_sniper)

/obj/structure/destructible/explosion_debris
	name = "explosion debris"
	desc = "Cover created by an explosion. Doesn't block your movement much, but can be useful."
	flags = ON_BORDER
	maxHealth = 300 //This might seem a bit high but remember that the cover will be taking damage anyway from the explosion.
	health = 300
	cover_rating = 45
	explosion_damage_mult = 3
	deconstruct_tools = list()
	loot_types = list()
	scrap_types = list()
	bump_climb = 1
	mob_climb_time = 0.7 SECONDS

/obj/structure/destructible/Cross(var/obj/vehicles/crosser)
	. = ..()
	if(!.)
		if(istype(crosser) && !crosser.can_overrun_cover)//Cover-overruners need to collide.
			return 1

/obj/structure/destructible/explosion_debris/CanPass(var/obj/vehicles/vpass)
	if(istype(vpass) && !vpass.can_overrun_cover) //Cover-overrunners need to collide.
		return 1
	for(var/type in PROJECTILES_DEBRIS_IGNORE)
		if(istype(vpass,type))
			return 1
	. = ..()

/obj/structure/destructible/explosion_debris/CheckExit(var/obj/vehicles/vpass, turf/target as turf)
	if(istype(vpass) && !vpass.can_overrun_cover) //Cover-overrunners need to collide.
		return 1
	. = ..()

//Debris Creation Code//
/turf/simulated/floor
	var/explosion_debris_file = null
	var/explosion_debris_state = "generic"

/turf/simulated/floor/proc/create_cover(var/dir_create)
	if(!explosion_debris_file)
		return
	if(!(dir_create in GLOB.cardinal))
		//If we're on a diagonal, pick one
		dir_create = pick(list(turn(dir_create,-45),turn(dir_create,45)))
	var/obj/new_cover = new /obj/structure/destructible/explosion_debris (src)
	new_cover.icon = explosion_debris_file
	new_cover.icon_state = explosion_debris_state
	new_cover.dir = dir_create

/turf/simulated/floor/proc/create_cover_precheck(var/severity,var/turf/epi)
	if(epi != src)
		var/mult = 4 - severity
		if(!prob(EXPLOSION_DEBRIS_CHANCE * mult))
			return
		create_cover(get_dir(epi,src))

/turf/simulated/floor/ex_act(var/severity,var/turf/epi)
	create_cover_precheck(severity,epi)
	. = ..()

//Relevant turf overrides//
/turf/simulated/floor/asteroid
	explosion_debris_file = 'code/modules/halo/icons/explosion_debris.dmi'

/turf/simulated/floor/exoplanet
	explosion_debris_file = 'code/modules/halo/icons/explosion_debris.dmi'

/turf/simulated/floor/pavement
	explosion_debris_file = 'code/modules/halo/icons/explosion_debris.dmi'

/turf/simulated/floor/road
	explosion_debris_file = 'code/modules/halo/icons/explosion_debris.dmi'

#undef PROJECTILES_DEBRIS_IGNORE
#undef EXPLOSION_DEBRIS_CHANCE