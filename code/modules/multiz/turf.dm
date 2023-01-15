/turf/proc/UpdateMobSector(var/mob/living/l)
	if(istype(l))
		l.update_occupied_sector(z)

/turf/proc/CanZPass(atom/A, direction)
	if(z == A.z) //moving FROM this turf
		. = direction == UP //can't go below
	else
		if(direction == UP) //on a turf below, trying to enter
			. = 0
		else if(direction == DOWN) //on a turf above, trying to enter
			. = !density

	if(.)
		UpdateMobSector(A)

/obj/effect/z_vis
	anchored = 1
	density = 0
	mouse_opacity = 0
	icon = 'icons/turf/space.dmi'
	icon_state = "empty"
	plane = ABOVE_PLATING_PLANE
	layer = ABOVE_WIRE_LAYER

/turf/simulated/open/CanZPass(atom, direction)
	UpdateMobSector(atom)
	return 1

/turf/space/CanZPass(atom, direction)
	UpdateMobSector(atom)
	return 1

/turf/simulated/open
	name = "open space"
	icon = 'icons/turf/space.dmi'
	icon_state = "empty"
	plane = OBSCURITY_PLANE
	density = 0
	pathweight = 100000 //Seriously, don't try and path over this one numbnuts
	var/obj/effect/vis_image

	var/turf/below

/turf/simulated/open/post_change()
	..()
	update()

/turf/simulated/open/Initialize()
	. = ..()
	update()

/turf/simulated/open/proc/update()
	below = GetBelow(src)
	GLOB.turf_changed_event.register(below, src, /turf/simulated/open/update_icon)
	var/turf/simulated/T = get_step(src,NORTH)
	if(T)
		GLOB.turf_changed_event.register(T, src, /turf/simulated/open/update_icon)
	levelupdate()
	for(var/atom/movable/A in src)
		A.fall()
	update_icon()

/turf/simulated/open/update_dirt()
	return 0

/turf/simulated/open/Entered(var/atom/movable/mover)
	..()
	mover.fall()

// Called when thrown object lands on this turf.
/turf/simulated/open/hitby(var/atom/movable/AM, var/speed)
	. = ..()
	AM.fall()

// override to make sure nothing is hidden
/turf/simulated/open/levelupdate()
	for(var/obj/O in src)
		O.hide(0)

/turf/simulated/open/update_icon()
	if(!vis_image)
		vis_image = new /obj/effect/z_vis (src)
	if(below && vis_image)
		vis_image.vis_contents += below

/turf/simulated/open/attackby(obj/item/C as obj, mob/user as mob)
	if (istype(C, /obj/item/stack/rods))
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(L)
			return

		//don't build over stairs
		var/turf/T = GetBelow(src)
		var/obj/structure/stairs/S = locate() in T.contents
		if(istype(S))
			to_chat(user,"\icon[S] <span class='warning'>You cannot build a lattice over [S]!</span>")
			return

		var/obj/item/stack/rods/R = C
		if (R.use(1))
			to_chat(user, "<span class='notice'>You lay down the support lattice.</span>")
			playsound(src, 'sound/weapons/Genhit.ogg', 50, 1)
			new /obj/structure/lattice(locate(src.x, src.y, src.z))
		return

	if (istype(C, /obj/item/stack/tile))
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(L)
			var/obj/item/stack/tile/floor/S = C
			if (S.get_amount() < 1)
				return
			qdel(L)
			playsound(src, 'sound/weapons/Genhit.ogg', 50, 1)
			S.use(1)
			ChangeTurf(/turf/simulated/floor/airless)
			return
		else
			to_chat(user, "<span class='warning'>The plating is going to need some support.</span>")

	//To lay cable.
	if(istype(C, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/coil = C
		coil.turf_place(src, user)
		return
	return

/turf/simulated/open/Destroy()
	. = ..()
	qdel(vis_image)

//Most things use is_plating to test if there is a cover tile on top (like regular floors)
/turf/simulated/open/is_plating()
	return 1
