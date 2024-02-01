/obj/structure/table/bench
	name = "bench frame"
	icon = 'code/modules/halo/structures/bench.dmi'
	icon_state = "frame"
	desc = "It's a bench, for putting things on. Or standing on, if you really want to."
	can_reinforce = 0
	flipped = -1
	density = 0

/obj/structure/table/bench/update_desc()
	if(material)
		name = "[material.display_name] bench"
	else
		name = "bench frame"

/obj/structure/table/bench/CanPass(atom/movable/mover)
	return 1

//PRESETS

/obj/structure/table/bench/standard
	icon_state = "plain_preview"
	color = "#EEEEEE"

/obj/structure/table/bench/standard/New()
	material = get_material_by_name(DEFAULT_TABLE_MATERIAL)
	..()

/obj/structure/table/bench/steel
	icon_state = "plain_preview"
	color = "#666666"

/obj/structure/table/bench/steel/New()
	material = get_material_by_name(DEFAULT_WALL_MATERIAL)
	..()

/obj/structure/table/bench/marble
	icon_state = "stone_preview"
	color = "#CCCCCC"

/obj/structure/table/bench/marble/New()
	material = get_material_by_name("marble")
	..()

/obj/structure/table/bench/wooden
	icon_state = "plain_preview"
	color = "#824B28"

/obj/structure/table/bench/wooden/New()
	material = get_material_by_name("wood")
	..()

/obj/structure/table/bench/padded
	icon_state = "padded_preview"

/obj/structure/table/bench/padded/New()
	material = get_material_by_name(DEFAULT_WALL_MATERIAL)
	carpeted = 1
	..()

/obj/structure/table/bench/glass
	icon_state = "plain_preview"
	color = COLOR_DEEP_SKY_BLUE
	alpha = 77 // 0.3 * 255
	material = "glass"

/*
/obj/structure/table/bench/reinforced
	icon_state = "reinf_preview"
	color = "#EEEEEE"

/obj/structure/table/bench/reinforced/New()
	material = get_material_by_name(DEFAULT_TABLE_MATERIAL)
	reinforced = get_material_by_name(DEFAULT_WALL_MATERIAL)
	..()

/obj/structure/table/bench/steel_reinforced
	icon_state = "reinf_preview"
	color = "#666666"

/obj/structure/table/bench/steel_reinforced/New()
	material = get_material_by_name(DEFAULT_WALL_MATERIAL)
	reinforced = get_material_by_name(DEFAULT_WALL_MATERIAL)
	..()

/obj/structure/table/bench/wooden_reinforced
	icon_state = "reinf_preview"
	color = "#824B28"

/obj/structure/table/bench/wooden_reinforced/New()
	material = get_material_by_name("wood")
	reinforced = get_material_by_name(DEFAULT_WALL_MATERIAL)
	..()
*/
