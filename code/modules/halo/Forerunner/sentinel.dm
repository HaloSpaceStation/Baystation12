//sentinel laser beam

/obj/item/projectile/beam/sentinel
	name = "sentinel beam"
	icon_state = "beam_blue"

	damage = 30
	damage_type = BURN
	check_armour = "laser"
	armor_penetration = 10

	muzzle_type = /obj/effect/projectile/laser_blue/muzzle
	tracer_type = /obj/effect/projectile/laser_blue/tracer
	impact_type = /obj/effect/projectile/laser_blue/impact

/obj/item/weapon/gun/energy/laser/sentinel_beam
	name = "Sentinel Beam"
	self_recharge = 1
	recharge_time = 0
	fire_delay = 20

	//fire_sound = 'code/modules/halo/sounds/Spartan_Laser_Beam_Shot_Sound_Effect.ogg'
	fire_sound = 'sound/weapons/pulse3.ogg'

	projectile_type = /obj/item/projectile/beam/sentinel

/obj/item/weapon/gun/energy/laser/sentinel_beam/handle_click_empty(mob/user)
	if(user)
		to_chat(user,"<span class='info'>[src] is temporarily out of charge, please wait a moment.</span>")

/mob/living/simple_animal/hostile/sentinel
	name = "Sentinel"
	desc = "An automated defence drone made of advanced alien technology."
	faction = "Forerunner"
	icon = 'code/modules/halo/Forerunner/Sentinel.dmi'
	icon_state = "sentinel"
	icon_living = "sentinel"
	icon_dead = "sentinel_dead"
	universal_speak = 1
	universal_understand = 1
	response_harm = "batters"
	health = 200
	maxHealth = 200
	ranged = 1
	move_to_delay = 5
	resistance = 10
	speak_chance = 1
	speak = list()
	emote_see = list("extends and retracts its manipulator arms","scans its body for damage","scans the environment")
	emote_hear = list("buzzes")
	var/obj/item/weapon/gun/energy/laser/sentinel_beam/sentinel_beam

/mob/living/simple_animal/hostile/sentinel/New()
	. = ..()
	sentinel_beam = new(src)

/mob/living/simple_animal/hostile/sentinel/RangedAttack(var/atom/attacked)
	sentinel_beam.Fire(attacked, src)

/mob/living/simple_animal/hostile/sentinel/death(gibbed, deathmessage = "crashes into the ground!", show_dead_message = 1)
	new /obj/effect/gibspawner/robot(src.loc)
	. = ..(gibbed, deathmessage, show_dead_message)

//how do i shoot gun
/mob/living/simple_animal/hostile/sentinel/IsAdvancedToolUser()
	return 1

/mob/living/simple_animal/hostile/sentinel/get_equivalent_body_part(var/def_zone)
	return "chassis"
