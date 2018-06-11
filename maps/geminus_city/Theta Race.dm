
//Should Create new race called Theta Subject
/mob/living/carbon/human/theta/New(var/new_loc)
	..(new_loc,"Theta")
	if(gender == "male")
		name = pick(GLOB.first_names_theta)
	else
		name = pick(GLOB.first_names_theta)
	name += " "
	name += pick(GLOB.last_names_theta)
	real_name = name

/obj/item/organ/internal/heart/spartan/theta
	name = "Augmented Heart"
	desc = "This augmented heart has been inlaced with nanites which allow it to incur substanstially more damage then a normal heart can."

/obj/item/organ/internal/liver/spartan/theta
	//Equivalent to Spartan Liver
	name = "Augmented liver"
	desc = "This augmented liver is enhanced with nanites which allow the implantee to ingest double the normal amount of toxins any other human can, as well as toughen it's outer layers significantly."

/obj/item/organ/internal/eyes/occipital_reversal/theta
	name = "Augmented Eyeballs"
	desc = "These Augmented eyeballs are enhanced with nanites which automatically provide in built flash protection, as well as toughen the organ a significant amount."
	max_damage = 60

/obj/item/organ/internal/lungs/theta
	name = "Augmented Lungs"
	desc = "These augmented lungs have been enhanced with nanites which allow for tougher membranes as well as the implantee needing half of a normal person's air pressure to survive."
	min_breath_pressure = 8
	max_damage = 90
	min_bruised_damage = 35
	min_broken_damage = 60