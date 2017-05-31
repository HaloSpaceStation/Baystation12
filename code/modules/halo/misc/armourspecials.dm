
/datum/harnessspecials/shields
	var/shieldstrength
	var/totalshields
	var/nextcharge
	var/mob/living/user
	var/warned

/datum/harnessspecials/shields/New()
	shieldstrength = totalshields

/datum/harnessspecials/shields/proc/checkshields(var/damage,var/damage_source)
	if(shieldstrength> 0)
		shieldstrength -= damage
		user.visible_message("<span class='warning'>[user]'s shields absorbs the force of the impact</span>","<span class = 'notice'>Your shields absorbs the force of the impact</span>")
		return 1
	if(shieldstrength<= 0)
		if(!warned) //Stops spam and constant resetting
			user.visible_message("<span class ='warning'>[usr]'s shield collapses!</span>","<span class ='userdanger'>Your shields fizzle and spark, losing their protective ability!</span>")
		warned = 1
		nextcharge = world.time + 30 // 3 seconds
		return 0

/datum/harnessspecials/shields/proc/tryrecharge(var/mob/living/m)
	if(shieldstrength >= totalshields)
		shieldstrength = totalshields
		return
	if(world.time > nextcharge)
		shieldstrength += 10
		if(prob(25)&& !isnull(m)) //Stops runtime when no mob to display message to.
			m.visible_message("<span class = 'notice'>A faint ping emanates from [m.name]'s armour.</span>","<span class ='notice'>Current shield level: [(shieldstrength/totalshields)*100]</span>")
		nextcharge = world.time + 20 // 2 seconds.
		warned = 0
		return

/datum/harnessspecials/cloaking

/datum/harnessspecials/thrusters