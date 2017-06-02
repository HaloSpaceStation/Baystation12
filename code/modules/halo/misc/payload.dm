
/obj/payload
	name = "Nuclear Warhead Payload"
	desc = "The word 'UNSC' is scratched out, replaced with a spraypainted image of a skull"
	icon = 'code/modules/halo/icons/Weapon Sprites.dmi'
	icon_state = "MFDD"
	anchored = 0
	density = 1
	var/explodetype = /datum/nuclearexplosion
	var/exploding
	var/explode_at
	var/secondstoexplode = 2400
	var/disarm_at
	var/secondstodisarm = 60
	var/mob/living/u = null
	var/disarming
	var/explodedesc = "A spraypainted image of a skull adorns this slowly ticking bomb."

/obj/payload/attack_hand(var/mob/living/user)
	if(!exploding)
		if(!checkturf())
			if(!u)
				visible_message("<span class='danger'>The [src] beeps a warning:'OPTIMAL LOCATION NOT REACHED'</span>")
		else
			u = user
			u.visible_message("<span class = 'userdanger'>[user.name] primes the [src] for detonation</span>","<span class ='notice'>You prime the [src] for detonation</span>")
			explode_at = world.time + secondstoexplode
			exploding = 1
			processing_objects += src
			anchored = 1
	else
		if(!disarming)
			u = user
			u.visible_message("<span class = 'danger'>[user.name] starts disarming the [src]</span>","<span class ='notice'>You start disarming the [src]. You estimate it'll take [secondstodisarm/10] seconds</span>")
			disarm_at = world.time + secondstodisarm
			disarming = 1
		else
			user << "<span class ='notice'>Someone else is already disarming the [src]</span>"

/obj/payload/proc/checkturf()
	for(var/obj/bomblocation/b in world)
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
		desc = explodedesc + " [(explode_at - world.time)/10] seconds remain."
	if(exploding && world.time >= explode_at)
		processing_objects -= src
		new explodetype(src)
		qdel(src)
		return

/obj/payload/proc/checkdisarm()
	if(!checknextto() || !checkalive() || !disarming)
		disarming = 0
		return
	if(world.time >= disarm_at)
		u.visible_message("<span class = 'danger'>[u] disarms the [src]</span>","<span class = 'notice'>You disarm the [src]</span>")
		exploding = 0
		disarming = 0
		anchored = 0
		desc = initial(desc)
		processing_objects -= src

/obj/payload/process()
	checkexplode()
	checkdisarm()

/obj/bomblocation
	name = "Bomb Delivery Point"
	desc = "Marks the location for the delivery of a bomb."
	icon = 'icons/misc/mark.dmi'
	icon_state = "rup"
	anchored = 1
	invisibility = 101 //Don't want this to be seen at all.

/obj/payload/covenant
	name = "Antimatter Bomb"
	desc = "Menacing spikes jut out from this device's frame."
	icon = 'code/modules/halo/icons/Covenant Weapons.dmi'
	icon_state ="Antimatter"
	explodedesc = "Spikes conceal a countdown timer."
	secondstoexplode = 3000
	secondstodisarm = 600


/datum/nuclearexplosion/New(var/obj/b)
	explosion(b.loc,20,20,20,20)
	for(var/mob/living/m in world)
		m << "<span class = 'userdanger'>A shockwave slams into you! You feel yourself falling apart...</span>"
		m.gib() // Game over, all die.
	qdel(src)