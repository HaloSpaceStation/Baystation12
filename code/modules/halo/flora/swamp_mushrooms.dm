
#define SWAMP_SHROOM_ICON_STATES list("01","02","03","04")

/obj/structure/flora/swamp_mushroom
	name = "mushroom"
	desc = "MUSHROOM!"
	icon = 'code/modules/halo/icons/flora/swamp_mushroom.dmi'
	icon_state = "01"
	anchored = 1
	density = 0

/obj/structure/flora/swamp_mushroom/Initialize()
	. = ..()
	icon_state = pick(SWAMP_SHROOM_ICON_STATES)
	set_light(1,1,"#BDFF7B")

#undef SWAMP_SHROOM_ICON_STATES
