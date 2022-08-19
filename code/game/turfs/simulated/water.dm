
#define DEEP_WATER_SINK_DELAY 2 SECONDS

/turf/simulated/floor/water
	name = "deep water"
	desc = "Crossing this is possible, but ill-advised."
	icon = 'icons/misc/beach.dmi'
	icon_state = "seadeep"
	var/deepwater = 1
	movement_delay = 15

/turf/simulated/floor/water/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/reagent_containers))
		src.visible_message("<span class='info'>[user] begins filling [W] with water.</span>")
		if(do_after(user, 30))
			//var/obj/item/weapon/reagent_containers/container = W
			W.reagents.add_reagent(/datum/reagent/water, 1000)

/turf/simulated/floor/water/CanPass(atom/movable/mover, turf/target, height=1.5, air_group = 0)
	if(deepwater && istype(mover,/obj/vehicles) && mover.elevation == elevation)
		return 0
	. = ..()

/turf/simulated/floor/water/Enter(atom/movable/O, atom/oldloc)
	if(deepwater && isliving(O))
		var/message = "You flounder inside [src]!"
		if(deepwater > 1)
			message = "You feel [src]'s current pulling you under!"
		to_chat(O, "<span class='warning'>[message]</span>")

	. = ..()

	if(deepwater && ((istype(O, /obj/effect) || istype(O,/obj/item) || istype(O,/obj/structure) || istype(O,/obj/vehicles)) && O.elevation == elevation))
		spawn(DEEP_WATER_SINK_DELAY)
			if(O.loc == src)
				src.visible_message("<span class='notice'>[O] sinks beneath the surface of [src].</span>")
				qdel(O)

/turf/simulated/floor/water/shallow
	name = "shallow water"
	desc = "Looks shallow enough to cross"
	icon_state = "seashallow"
	deepwater = 0
	movement_delay = 5

/turf/simulated/floor/water/superdeep
	name = "watery depths"
	desc = "Attempting to cross this is folly. If only you had some sort of air transportation..."
	icon_state = "seaverydeep"
	deepwater = 2
	movement_delay = 30

#undef DEEP_WATER_SINK_DELAY