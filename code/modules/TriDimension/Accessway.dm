
//------------------------------------------------------
// Accessway: basically a hole in the ground for ladders
// but players can drop down it anytime
//------------------------------------------------------

/turf/simulated/floor/accessway
	name = "accessway"
	desc = "An access hole leading to a lower level."
	icon_state = "accessway"
	var/image/accessway_underlay
	blocks_air_downwards = 0

/*/turf/simulated/floor/accessway/levelupdate()
	if(accessway_underlay)		//sanity check
		underlays -= accessway_underlay
	else
		accessway_underlay = image(src, layer = TURF_LAYER + 0.042)
	..()
	underlays += accessway_underlay*/

/turf/simulated/floor/accessway/Enter(var/atom/movable/AM)
	return 1	//function as an ordinary floor, except mobs can drop down it if they want

/turf/simulated/floor/accessway/attackby(obj/item/W, mob/user)
	if(istype(W, /obj/item/weapon/weldingtool))
		var/obj/item/weapon/weldingtool/WT = W
		if(WT.remove_fuel(3, user))
			user << "<span class='notice'>Removing accessway...</span>"

			if(!do_after(user, 50) || !WT || !WT.isOn())
				return

			src.ReplaceWithLattice()

	else if(istype(W, /obj/item/stack/tile/floor))
		var/obj/item/stack/tile/floor/T = W
		if (T.get_amount() < 1)		//sanity check
			user << "<span class='notice'>There are not enough tiles left on that stack</span>"
			T.use(0)
			return

		T.use(1)
		playsound(src, 'sound/weapons/Genhit.ogg', 50, 1)
		ChangeTurf(/turf/simulated/floor/plating)
