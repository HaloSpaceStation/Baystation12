
/datum/antagonist/revolutionary
	id = MODE_REVOLUTIONARY
	role_type = BE_INNIE
	role_text = "Insurrectionist"
	role_text_plural = "Insurrectionists"
	bantype = "insurrectionist"
	feedback_tag = "innie_objective"
	restricted_jobs = list("ONI Agent", "AI", "Cyborg","Captain", "First Officer", "Head of Security", "Chief Tech Officer", "Research Director", "Chief Medical Officer")
	protected_jobs = list("Marine", "Marine Sergeant", "Detective")
	antag_indicator = "rev"
	welcome_text = "????????????"
	victory_text = "????????????"
	loss_text = "???????????"
	victory_feedback_tag = "win - heads killed"
	loss_feedback_tag = "loss - innies killed"
	flags = ANTAG_SUSPICIOUS | ANTAG_VOTABLE
	max_antags = 200 // No upper limit.
	max_antags_round = 200

/mob/living/carbon/human/proc/convert_to_innie(mob/M as mob in oview(src))
	set name = "Convert Bourgeoise"
	set category = "Abilities"

	if(revs.is_antagonist(M.mind))
		src << "<span class='danger'>\The [M] already serves in the insurrection!</span>"
		return
	if(!revs.can_become_antag(M.mind))
		src << "<span class='danger'>\The [M] cannot be a insurrectionist!</span>"

	if(world.time < M.mind.rev_cooldown)
		src << "<span class='danger'>You must wait five seconds between attempts.</span>"
		return

	src << "<span class='danger'>You are attempting to convert \the [M]...</span>"
	log_admin("[src]([src.ckey]) attempted to convert [M].")
	message_admins("<span class='danger'>[src]([src.ckey]) attempted to convert [M].</span>")

	var/choice = alert(M,"Asked by [src]: Do you want to join the revolution?","Join the revolution?","No!","Yes!")
	if(choice == "Yes!")
		M << "<span class='notice'>You join the insurrection.</span>"
		src << "<span class='notice'>[M] joins the insurrection!</span>"
		revs.add_antagonist(M.mind, 0, 0, 1)
	else if(choice == "No!")
		M << "<span class='danger'>You reject this traitorous cause!</span>"
		src << "<span class='danger'>\The [M] does not support the revolution!</span>"
	M.mind.rev_cooldown = world.time+50