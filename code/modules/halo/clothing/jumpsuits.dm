/obj/item/clothing/under/unsc
	icon = 'icons/mob/uniform.dmi'
	icon_state = "base_s"
	item_state = "base_s"
	worn_state = "unscgrey"

/obj/item/clothing/under/unsc/highcom //this is intended for admin usage only!
	desc = "an ornate uniform, composed of carbon nanofiber, bearing the rank insignia of Fleet Admiral"
	name = "high command uniform"
	icon_state = "centcom_s"
	item_state = "centcom_s"
	worn_state = "centcom"
	armor = list(melee = 99, bullet = 90, laser = 50,energy = 50, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/under/unsc/highcom/officer
	desc = "an ornate uniform bearing the rank insignia of an admiral, looks to be very thick"
	name = "admiral's uniform"
	icon_state = "officer_s"
	item_state = "officer_s"
	worn_state = "officer"
	armor = list(melee = 95, bullet = 50, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/under/unsc/captain
	desc = "a simple, but somewhat thick uniform"
	name = "captain's uniform"
	icon_state = "lasky_s"
	item_state = "lasky_s"
	worn_state = "lasky"
	armor = list(melee = 90, bullet = 25, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/under/unsc/command
	desc = "standard issue command crew uniform"
	name = "command officer uniform"
	icon_state = "unscgrey_s"
	item_state = "unscgrey_s"
	worn_state = "unscgrey"

/obj/item/clothing/under/unsc/cmo
	desc = "standard issue command uniform, medical variant"
	name = "CMO's uniform"
	icon_state = "cmo_unsc_s"
	item_state = "cmo_unsc_s"
	worn_state = "cmo_unsc"

/obj/item/clothing/under/unsc/engineering
	desc = "standard issue engineering uniform"
	name = "engineer's uniform"
	icon_state = "unscorange_s"
	item_state = "unscorange_s"
	worn_state = "unscorange"

/obj/item/clothing/under/unsc/operations
	desc = "standard issue operations officer uniform"
	name = "operations officer's uniform"
	icon_state = "unscyellow_s"
	item_state = "unscyellow_s"
	worn_state = "unscyellow"

/obj/item/clothing/under/unsc/operations/technician
	desc = "standard issue operations technician uniform"
	name = "operations technician's uniform"
	icon_state = "unsclightbrown_s"
	item_state = "unsclightbrown_s"
	worn_state = "unsclightbrown"

/obj/item/clothing/under/unsc/security
	desc = "standard issue military police uniform, lightly armored"
	name = "security uniform"
	icon_state = "unscred_s"
	item_state = "unscred_s"
	worn_state = "unscred"
	armor = list(melee = 5, bullet = 5, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/under/unsc/science
	desc = "standard issue scientist uniform, minor protection from low-level biohazards"
	name = "scientist's uniform"
	icon_state = "unsclightblue_s"
	item_state = "unsclightblue_s"
	worn_state = "unsclightblue"
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 10, rad = 0)

/obj/item/clothing/under/unsc/science/biologist
	desc = "biology uniform, slightly more protective than standard science uniforms"
	name = "biologist's uniform"
	icon_state = "unscblue_s"
	item_state = "unscblue_s"
	worn_state = "unscblue"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 15, rad = 0) //biologist gets some melee protection for more agressive specimens.

/obj/item/clothing/under/unsc/standard
	desc = "standard UNSC undersuit, extremely flexible"
	name = "UNSC undersuit"
	icon_state = "marine_under_s"
	item_state = "marine_under_s"
	worn_state = "marine_under"

/obj/item/clothing/under/unsc/odst
	desc = "UNSC ODST undergarment"
	name = "ODST undersuit"
	icon_state = "odst_s"
	item_state = "odst_s"
	worn_state = "odst"

//Marine Gear\\

/obj/item/clothing/under/unsc/marine_fatigues
	desc = "standard issue for UNSC marines"
	name = "UNSC Marine fatigues"
	icon = 'code/modules/halo/icons/item_marine.dmi'
	icon_state = "uniform"
	item_state = "uniform"
	worn_state = "jumpsuit_marine"
