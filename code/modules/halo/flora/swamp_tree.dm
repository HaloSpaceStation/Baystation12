
#define SWAMP_TREE_ICON_STATES list("01","02","03","04")

/obj/structure/flora/tree/swamp_tree
	name = "glowing tree"
	desc = "A large, sturdy, glowing tree."
	anchored = 1
	density = 1

/obj/structure/flora/tree/swamp_tree/Initialize()
	. = ..()
	icon_state = pick(SWAMP_TREE_ICON_STATES)
	set_light(4,1,"#BDFF7B")

#undef SWAMP_TREE_ICON_STATES
