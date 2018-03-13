/mob/living/silicon/robot/drone/eggbot
	name = "egg-bot"
	real_name = "egg-bot"
	icon_state = "eggbot"
	desc = "It's an egg with legs!"
	laws = /datum/ai_laws/egg
	module_type = /obj/item/weapon/robot_module/egg

/datum/ai_laws/egg
	name = "E.G.G"
	law_header = "\red Primary Mission Error"

/datum/ai_laws/egg/New()
	add_inherent_law("egg.")

/obj/item/weapon/robot_module/egg
	name = "construction drone module"
	hide_on_manifest = 1
	channels = list("Engineering" = 1)
	languages = list()

/obj/item/weapon/robot_module/egg/New()
	src.modules += new /obj/item/weapon/rsf/egg(src)
	..()

/obj/item/weapon/rsf/egg
	name = "\improper Rapid-Egg-Fabricator"
	desc = "A device used to rapidly deploy eggs."

/obj/item/weapon/rsf/egg/attack_self(mob/user as mob)
	playsound(src.loc, 'sound/effects/pop.ogg', 50, 0)
	to_chat(user, "Changed dispensing mode to 'Egg'")

/obj/item/weapon/rsf/egg/afterattack(atom/A, mob/user as mob, proximity)

	if(!proximity) return

	if(istype(user,/mob/living/silicon/robot))
		var/mob/living/silicon/robot/R = user
		if(R.stat || !R.cell || R.cell.charge <= 0)
			return
	else
		if(stored_matter <= 0)
			return

	if(!istype(A, /obj/structure/table) && !istype(A, /turf/simulated/floor))
		return

	playsound(src.loc, 'sound/machines/click.ogg', 10, 1)
	var/used_energy = 0
	var/obj/product = new /obj/item/weapon/reagent_containers/food/snacks/egg()

	to_chat(user, "Dispensing egg...")
	product.loc = get_turf(A)

	if(isrobot(user))
		var/mob/living/silicon/robot/R = user
		if(R.cell)
			R.cell.use(used_energy)
	else
		stored_matter--
		to_chat(user, "The REF now holds [stored_matter]/30 fabrication-units.")
