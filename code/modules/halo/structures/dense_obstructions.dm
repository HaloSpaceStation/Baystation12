
#define DENSE_OBSTRUCTION_PATH_ITER_CAP 25

//Used for fields of obstructing trees, boulders, flora, etc. Takes a while to pass over them, and blocks view, but can be destroyed with enough firepower.
//You could also just use this for normal clusters of icons by removing the density, I suppose.

/obj/structure/destructible/dense_obstruction
	name = "dense obstruction"
	desc = "A dense obstruction."
	icon = 'code/modules/halo/flora/jungleflora.dmi'
	icon_state = "bush_1"
	climb_desc = "manouver past"
	plane = ABOVE_HUMAN_PLANE
	opacity = 1
	alpha = 150
	pixel_x = 0
	health = 2000
	maxHealth = 2000
	closerange_freefire = 0
	bump_climb = 1
	mob_climb_time = 4 SECONDS
	explosion_damage_mult = 0.1
	var/list/states_ignore = list("rocks_1","rocks_2","rocks_3","rocks_4") //States in the provided icon file to ignore whilst randomising tree type.
	var/max_offset = 12
	var/min_offset = -12
	var/obstruction_num = 5 //How many obstacles make up our density?

	var/obst_num_hp_cache = 0//Internal use only.
	var/next_icon_loss_threshold = 0

/obj/structure/destructible/dense_obstruction/update_icon()
	if(obst_num_hp_cache == 0)
		obst_num_hp_cache = maxHealth / obstruction_num //Our HP interval to lose an icon.
		next_icon_loss_threshold = maxHealth - obst_num_hp_cache
	if(overlays.len == 0) //Only on first init.
		icon_state = "blank" //The baseline icon shouldn't be visible.
		var/icon/icon_obj = new(icon)
		var/list/valid_Istates = icon_obj.IconStates() - states_ignore
		qdel(icon_obj)
		for(var/iter = 0 to obstruction_num)
			var/image/I = image(icon,pick(valid_Istates))
			var/x_offset = rand(min_offset,max_offset)
			var/y_offset = rand(min_offset,max_offset)
			I.pixel_x = src.pixel_x + x_offset
			I.pixel_y = src.pixel_y + y_offset
			I.alpha = alpha
			overlays += I
	else
		if(health < next_icon_loss_threshold)
			next_icon_loss_threshold -= obst_num_hp_cache
			var/image/img = overlays[overlays.len]
			overlays -= img


/obj/structure/destructible/dense_obstruction/Initialize()
	. = ..()
	update_icon()


//Variants//
/obj/structure/destructible/dense_obstruction/flora_assorted
	name = "dense flora"
	desc = "Hard to see through, and hard to move through. Can be destroyed with enough concentrated firepower."
	icon = 'code/modules/halo/flora/ausflora.dmi'
	icon_state = "fern_1"
	states_ignore = list() //States in the provided icon file to ignore whilst randomising tree type.
	max_offset = 7
	min_offset = -7
	obstruction_num = 4

/obj/structure/destructible/dense_obstruction/flora_jungle
	name = "dense flora"
	desc = "Hard to see through, and hard to move through. Can be destroyed with enough concentrated firepower."
	icon = 'code/modules/halo/flora/jungleflora.dmi'
	icon_state = "bush_1"
	states_ignore = list("rocks_1","rocks_2","rocks_3","rocks_4") //States in the provided icon file to ignore whilst randomising tree type.
	max_offset = 10
	min_offset = -10
	obstruction_num = 6

/obj/structure/destructible/dense_obstruction/flora_jungle_large
	name = "dense flora"
	desc = "Hard to see through, and hard to move through. Can be destroyed with enough concentrated firepower."
	icon = 'code/modules/halo/flora/swamp_ausflora_large.dmi'
	icon_state = "bush_1"
	pixel_x = -16
	states_ignore = list("rocks_1","rocks_2","rocks_3","rocks_4") //States in the provided icon file to ignore whilst randomising tree type.
	max_offset = 10
	min_offset = -10
	obstruction_num = 3

/obj/structure/destructible/dense_obstruction/rocks
	name = "boulders"
	desc = "Hard to see through, and hard to move through. Can be destroyed with enough concentrated firepower."
	icon = 'code/modules/halo/flora/jungleflora.dmi'
	icon_state = "rocks_1"
	states_ignore = list("bush_1","bush_2","bush_3") //States in the provided icon file to ignore whilst randomising tree type.
	max_offset = 10
	min_offset = -10
	obstruction_num = 5

/obj/structure/destructible/dense_obstruction/rocks_large
	name = "boulders"
	desc = "Hard to see through, and hard to move through. Can be destroyed with enough concentrated firepower."
	icon = 'code/modules/halo/flora/swamp_ausflora_large.dmi'
	icon_state = "rocks_1"
	pixel_x = -16
	states_ignore = list("bush_1","bush_2","bush_3") //States in the provided icon file to ignore whilst randomising tree type.
	max_offset = 10
	min_offset = -10
	obstruction_num = 3

/obj/structure/destructible/dense_obstruction/trees
	name = "dense trees"
	desc = "Hard to see through, and hard to move through. Can be destroyed with enough concentrated firepower."
	icon = 'code/modules/halo/flora/jungletree.dmi'
	icon_state = "tree_1"
	states_ignore = list() //States in the provided icon file to ignore whilst randomising tree type.
	pixel_x = -32
	pixel_y = -6
	max_offset = 7
	min_offset = -7
	obstruction_num = 2

/obj/structure/destructible/dense_obstruction/trees_large
	name = "dense trees"
	desc = "Hard to see through, and hard to move through. Can be destroyed with enough concentrated firepower."
	icon = 'code/modules/halo/flora/jungletreelarge.dmi'
	icon_state = "tree_1"
	states_ignore = list() //States in the provided icon file to ignore whilst randomising tree type.
	pixel_x = -64
	pixel_y = -16
	max_offset = 7
	min_offset = -7
	obstruction_num = 2