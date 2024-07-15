
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
	density = 1
	opacity = 1
	alpha = 200
	pixel_x = 0
	health = 1250
	maxHealth = 1250
	closerange_freefire = 0
	bump_climb = 1
	mob_climb_time = 2 SECONDS
	explosion_damage_mult = 0.1
	loot_types = list()
	scrap_types = list()
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
			var/image/I = image(icon,icon_state=pick(valid_Istates))
			var/x_offset = rand(min_offset,max_offset)
			var/y_offset = rand(min_offset,max_offset)
			I.pixel_x = x_offset
			I.pixel_y = y_offset
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
/obj/structure/destructible/dense_obstruction/grass_and_shrub
	name = "grass and shrubbery"
	desc = "Wide patches of grass and shrubbery. Can, rarely, hinder gunfire. Easy to walk over. Can be destroyed with enough concentrated firepower."
	icon = 'code/modules/halo/flora/swamp_ausflora.dmi'
	icon_state = "busha_1"
	plane = OBJ_PLANE
	density = 0
	opacity = 0
	states_ignore = list("rock_1","rock_2","rock_3","rock_4","rock_5")
	cover_rating = 5
	max_offset = 16
	min_offset = -16
	obstruction_num = 8

/obj/structure/destructible/dense_obstruction/flora_assorted
	name = "dense flora"
	desc = "Patches of assorted flora. Can be seen through and moved over. Provides minimal protection against gunfire. Can be destroyed with enough concentrated firepower."
	icon = 'code/modules/halo/flora/ausflora.dmi'
	icon_state = "fern_1"
	plane = ABOVE_HUMAN_PLANE
	density = 0
	opacity = 0
	cover_rating = 20
	states_ignore = list() //States in the provided icon file to ignore whilst randomising tree type.
	max_offset = 12
	min_offset = -12
	obstruction_num = 6

/obj/structure/destructible/dense_obstruction/flora_jungle
	name = "dense flora"
	desc = "Hard to see through, but easy to move through. Provides minimal protection against gunfire. Can be destroyed with enough concentrated firepower."
	icon = 'code/modules/halo/flora/jungleflora.dmi'
	icon_state = "bush_1"
	density = 0
	cover_rating = 20
	states_ignore = list("busha1",) //States in the provided icon file to ignore whilst randomising tree type.
	max_offset = 10
	min_offset = -10
	obstruction_num = 6

/obj/structure/destructible/dense_obstruction/flora_jungle_large
	name = "dense flora"
	desc = "Hard to see through, and hard to move through. Provides minimal protection against gunfire. Can be destroyed with enough concentrated firepower."
	icon = 'code/modules/halo/flora/swamp_ausflora_large.dmi'
	icon_state = "bush_1"
	pixel_x = -24
	pixel_y = -12
	cover_rating = 30
	states_ignore = list("rocks_1","rocks_2","rocks_3","rocks_4") //States in the provided icon file to ignore whilst randomising tree type.
	max_offset = 10
	min_offset = -10
	obstruction_num = 3

/obj/structure/destructible/dense_obstruction/rocks
	name = "boulders"
	desc = "Hard to see through, and hard to move through. Provides significant protection against gunfire. Can be destroyed with enough concentrated firepower."
	icon = 'code/modules/halo/flora/swamp_ausflora.dmi'
	icon_state = "rock_1"
	cover_rating = 60
	states_ignore = list("busha_1","busha_2","busha_3","bushb_1","bushb_2","bushb_3","bushc_1","bushc_2","bushc_3","grassa_1","grassa_2","grassa_3","grassa_4","grassa_5","grassa_6","grassa_7","grassa_8","grassa_9","grassa_10","grassa_11")
	max_offset = 10
	min_offset = -10
	obstruction_num = 5

/obj/structure/destructible/dense_obstruction/rocks_large
	name = "boulders"
	desc = "Hard to see through, and hard to move through. Provides significant protection against gunfire. Can be destroyed with enough concentrated firepower."
	icon = 'code/modules/halo/flora/swamp_ausflora_large.dmi'
	icon_state = "rocks_1"
	pixel_x = -24
	pixel_y = -12
	cover_rating = 60
	states_ignore = list("bush_1","bush_2","bush_3")
	max_offset = 10
	min_offset = -10
	obstruction_num = 3

/obj/structure/destructible/dense_obstruction/trees
	name = "dense trees"
	desc = "Hard to see through, and hard to move through. Provides excellent protection against gunfire. Can be destroyed with enough concentrated firepower."
	icon = 'code/modules/halo/flora/jungletree.dmi'
	icon_state = "tree_1"
	alpha = 170
	cover_rating = 80
	states_ignore = list()
	pixel_x = -32
	pixel_y = -6
	max_offset = 8
	min_offset = -8
	obstruction_num = 2

/obj/structure/destructible/dense_obstruction/trees_large
	name = "dense trees"
	desc = "Hard to see through, and hard to move through. Provides excellent protection against gunfire. Can be destroyed with enough concentrated firepower."
	icon = 'code/modules/halo/flora/jungletreelarge.dmi'
	icon_state = "tree_1"
	alpha = 170
	cover_rating = 80
	states_ignore = list()
	pixel_x = -48
	pixel_y = -16
	max_offset = 8
	min_offset = -8
	obstruction_num = 2