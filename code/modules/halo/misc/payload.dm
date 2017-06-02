
/obj/payload
	name = "Nuclear Warhead Payload"
	desc = "The word 'UNSC' is scratched out, replaced with a spraypainted image of a skull"
	icon = 'code/modules/halo/icons/Weapon Sprites.dmi'
	icon_state = "MFDD"
	anchored = 0
	density = 1
	var/handlename = "handles" //Different bombs, eg. Covie antimatter bombs. "Spikes"
	var/explodetype = /datum/nuclearexplosion
	var/exploding
	var/explode_at
	var/secondsdisarm = 60
	var/mob/living/carbon/u = null
	var/disarming

/obj/payload/attack_hand(var/mob/living/user)
	if(!exploding)
		if(!checkturf())
			if(!u)
				visible_message("<span class='danger'>[user.name] grasps the [handlename] of the [src]</span>","<span class ='notice'>You grab the [handlename] of the [src]</span>")
				processing_objects += src
				u = user
				pulledby = u
		else
			visible_message("<span class = 'userdanger'>[user.name] primes the [src] for detonation</span>","<span class ='notice'>You prime the [src] for detonation</span>")
			explode_at = world.time + 2400 // 4 minutes
			exploding = 1
			processing_objects += src
			anchored = 1
	else
		if(!disarming)
			visible_message("<span class = 'danger'>[user.name] starts disarming the [src]</span>","<span class ='notice'>You start disarming the [src]. You estimate it'll take [secondsdisarm] seconds</span>")
			secondsdisarm += world.time
			u = user
			disarming = 1
		else
			user << "<span class ='notice'>Someone else is already disarming the [src]</span>"

/obj/payload/proc/checkturf()
	for(var/obj/effect/bomblocation/b in world)
		if(b.loc == src.loc)
			return 1
		else
			return 0

/obj/payload/proc/checknextto()
	if(u)
		if(u in range(1,src.loc))
			return 1
		else
			u = null
			return 0

/obj/payload/proc/checkalive()
	if(u.health > -u.maxHealth)
		return 1
	else
		return 0

/obj/payload/proc/checkexplode()
	if(exploding)
		desc = "A spraypainted image of a skull adorns this slowly ticking bomb. [explode_at - world.time] seconds remain."
	if(exploding && world.time >= explode_at)
		processing_objects -= src
		new explodetype(src)
		qdel(src)
		return

/obj/payload/proc/checkdisarm()
	if(!checknextto() || !checkalive() || !disarming)
		disarming = 0
		return
	if(world.time >= secondsdisarm)
		visible_message("<span class = 'danger'>[usr] disarms the [src]</span>","<span class = 'notice'>You disarm the [src]</span>")
		exploding = 0
		disarming = 0
		processing_objects -= src

/obj/payload/process()
	if(u)
		pulledby = u
	else
		pulledby = null
	checkexplode()
	checkdisarm()

/obj/effect/bomblocation
	name = "Bomb Delivery Point"
	desc = "Marks the location for the delivery of a bomb."
	icon = 'icons/misc/mark.dmi'
	icon_state = "rup"
	anchored = 1
	//invisibility = 100 //Don't want this to be seen at all.

/datum/nuclearexplosion/New(var/obj/b)
	explosion(b.loc,25,30,20,100)
	for(var/mob/living/m in world)
		m << "<span class = 'userdanger'>A shockwave slams into you! You feel yourself falling apart...</span>"
		m.health = m.maxHealth * -2 // OVERKILL
	qdel(src)