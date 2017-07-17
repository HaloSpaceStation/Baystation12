
/mob/living/carbon/human/spartan/New(var/new_loc)
	..(new_loc,"Spartan")
	if(gender == "male")
		name = pick(first_names_male)
	else
		name = pick(first_names_female)
	name += " "
	name += pick(last_names)
	real_name = name
