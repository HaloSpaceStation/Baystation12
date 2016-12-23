
//MORAY SPACEMINES
//Basic explosive proximity mines
//IFF, basic tracking, chemical propellant. Primarily an anti-strike craft

/obj/structure/vehicle_component/weapon/minelayer
	name = "fighter mounted space mine launcher"
	component_name = "Moray mine launcher"
	icon_state = "minelauncher"
	hud_icon_state = "mine"
	mag_size = 1
	ammo_spare = 4
	reload_time = 4
	fire_rate = 0.2

/obj/structure/vehicle_component/weapon/minelayer/fire(var/atom/A, var/params)
	if(..())
		//first, check if the spot is free and we deploy a mine there
		var/turf/T = proj_start
		if(!istype(T, /turf/space))
			usr << "<span class='warning'>\icon[src] You can only deploy spacemines in space.</span>"
			return

		for(var/atom/movable/M in proj_start)
			if(M.density && M != owned_vehicle)
				usr << "<span class='warning'>\icon[src] The spacemine deploy chute is being blocked by \icon[A] [A] [A.type].</span>"
				return

		//update weapon stuff
		last_shot_time = world.time
		mag -= 1
		screen_mag.update_icon()

		//place and arm the mine
		var/obj/structure/spacemine/S = new(proj_start)
		S.deploy()




/obj/structure/spacemine
	name = "Moray Spacemine"
	icon = 'code/modules/overmap/overmap_vehicles/icons/weapons.dmi'
	icon_state = "moraymine"
	density = 0
	var/max_damage = 3000
	var/trigger_range = 14
	var/damage_range = 40
	var/list/trigger_turfs = list()
	var/detonating = 0

/obj/structure/spacemine/proc/deploy()
	icon_state = "moraymine_deploy"
	spawn(32)
		icon_state = "moraymine_active"
		for(var/turf/space/S in range(trigger_range, src))
			trigger_turfs.Add(S)
			S.nearby_spacemines.Add(src)

//check to see if the mines should be triggered
//see code\game\turfs\space\space.dm
/turf/space/var/list/nearby_spacemines = list()
/turf/space/proc/check_mine_trigger(var/atom/movable/A)
	if(istype(A, /obj/machinery/overmap_vehicle))
		for(var/obj/structure/spacemine/S in nearby_spacemines)
			spawn(0)
				S.try_detonate()

/obj/structure/spacemine/proc/try_detonate()
	if(detonating)
		return
	detonating = 1

	icon_state = "moraymine_warning"
	for(var/turf/space/S in trigger_turfs)
		S.nearby_spacemines.Remove(src)
	trigger_turfs = list()

	//give the offender a little time to get out of range
	sleep(24)

	//check if there's still something within trigger range... doesn't have to be the same thing
	var/detonate = 0
	for(var/obj/machinery/overmap_vehicle/V in range(trigger_range, src))
		detonate = 1
		break
	if(!detonate)
		return

	//explode!
	icon_state = "moraymine_detonate"

	sleep(8)

	//damage any turfs or objects nearby
	for(var/turf/T in range(damage_range / 2, src))
		for(var/atom/movable/M in T)
			if(M == src)
				continue
			if(!istype(M, /obj/machinery/overmap_vehicle))
				M.ex_act(2)
		T.ex_act(2)

	//damage any humans nearby
	for(var/mob/living/carbon/human/H in range(damage_range, src))
		H.ex_act(1)

	//damage any fighters or vehicles nearby
	for(var/obj/machinery/overmap_vehicle/V in range(damage_range, src))
		V.impact_occupants_major("\icon[src] <span class='danger'>You are caught in the blast wave from [src]!</span>")

		var/dist = get_dist(src, V)
		//take a little less damage if we're further away
		V.take_damage(max_damage / 2 + max_damage * dist / (damage_range * 2))

	//explosion graphic
	var/datum/effect/system/explosion/E = new/datum/effect/system/explosion()
	E.set_up(src.loc)
	E.start()

	//remove self
	qdel(src)


//this needs special handling in the code
/obj/structure/spacemine/nuclear
	name = "Shiva Nuclear Spacemine"
