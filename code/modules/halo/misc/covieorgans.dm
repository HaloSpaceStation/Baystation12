
/obj/item/organ/heart_secondary
	name = "Secondary Heart"
	parent_organ = "chest"
	icon_state = "heart-on"
	var/used = 0

/obj/item/organ/heart_secondary/process()
	var/obj/item/organ/heart = owner.internal_organs_by_name["heart"]
	if(heart && heart.health >heart.min_broken_damage && !used)
		heart.damage = 0;src.name = "Used Secondary Heart";used = 1
