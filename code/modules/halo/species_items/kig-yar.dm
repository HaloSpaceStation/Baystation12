
/mob/living/carbon/human/covenant/kigyar/New(var/new_loc) //Species definition in code/modules/mob/living/human/species/outsider.
	..(new_loc,"Kig-Yar")							//Code breaks if not placed in species folder,
	name = pick(first_names_kig_yar)
	real_name = name
	faction = "Covenant"

/obj/item/clothing/under/covenant/kigyar
	name = "Kig-Yar Body-Suit"
	desc = "A Kig-Yar body suit. Meant to be worn underneath a combat harness"
	icon = 'code/modules/halo/icons/species/jackalclothing.dmi'
	icon_state = "jackal_bodysuit_s"
	worn_state = "jackal_bodysuit"
	sprite_sheets = list("Kig-Yar" = 'code/modules/halo/icons/species/jackalclothing.dmi')
	species_restricted = list("Kig-Yar")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS

/obj/item/clothing/under/covenant/kigyar/armless
	icon_state = "jackal_bodysuit_armless_s"
	worn_state = "jackal_bodysuit_armless"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS

/obj/item/clothing/suit/armor/covenant/kigyar
	name = "Kig-Yar Combat Harness"
	desc = "A protective harness for use during combat."
	icon = 'code/modules/halo/icons/species/jackalclothing.dmi'
	icon_state = "scout"
	item_state = "scout"
	sprite_sheets = list("Kig-Yar" = 'code/modules/halo/icons/species/jackalclothing.dmi')
	species_restricted = list("Kig-Yar")
	armor = list(melee = 75, bullet = 65, laser = 20, energy = 20, bomb = 40, bio = 25, rad = 20)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS
