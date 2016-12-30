


//the base type

/obj/structure/vehicle_component/plating
	var/base_name
	var/base_icon_state
	var/large_effect_mod = 0
	var/small_effect_mod = 0
	install_requires = INSTALL_WELDED//INSTALL_WELDED|INSTALL_CABLED|INSTALL_BOLTED|INSTALL_SCREWED|INSTALL_PIPED
	hud_icon_state = "hullplates"
	mount_type = MOUNT_EXT
	mount_size = MOUNT_LARGE

/obj/structure/vehicle_component/plating/MouseDrop_T(atom/dropping, mob/user)
	. = 0
	if(istype(dropping, /obj/structure/vehicle_component/plating) && get_dist(src, dropping) <= 1)
		if(mount_size == 0)
			. = 1
			var/obj/structure/vehicle_component/plating/P = dropping
			P.loc = src.loc
			user << "\icon[src] <span class='info'>You combine the [src] into a version for a large equipment slot.</span>"
			name = "[base_name] (large)"
			icon_state = "[base_icon_state]"
			mount_size = MOUNT_LARGE

			user.visible_message("\icon[src] <span class='info'>[user] combines [dropping] into [src]</span>")
			qdel(dropping)
		else
			user << "<span class='warning'>That plating kit is already at maximum module size.</span>"

/obj/structure/vehicle_component/plating/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/weldingtool))
		if(!mount_size)
			user << "<span class='warning'>[src] is already at minimum module size.</span>"
		var/obj/item/weapon/weldingtool/WT = W
		if (WT.remove_fuel(1,user))
			playsound(src.loc, 'sound/items/Welder2.ogg', 50, 1)
			user.visible_message("[user.name] starts to dismantle [src].", \
				"You start to dismantle [src] to fit a smaller slot.", \
				"You hear welding")
			if (do_after(user,20))
				if(!src || !WT.isOn()) return
				user << "You dismantle [src]."

				name = "[base_name] (small)"
				icon_state = "[base_icon_state]_small"
				mount_size = MOUNT_SMALL

				var/obj/structure/vehicle_component/plating/P = new src.type(src.loc)
				P.name = src.name
				P.icon_state = src.icon_state
				P.mount_size = src.mount_size

				. = P
		else
			user << "<span class='warning'>You need more welding fuel to complete this task.</span>"

/obj/structure/vehicle_component/plating/proc/get_effect_mod()
	if(mount_size)
		return large_effect_mod
	return small_effect_mod



//HULL (bonus fighter hp)

/obj/structure/vehicle_component/plating/hull
	name = "hull plating kit (large)"
	base_name = "hull plating kit"
	icon_state = "hullplates"
	base_icon_state = "hullplates"
	component_name = "hull plating"
	small_effect_mod = 15
	large_effect_mod = 20

/obj/structure/vehicle_component/plating/hull/small
	name = "hull plating kit (small)"
	icon_state = "hullplates_small"
	mount_size = MOUNT_SMALL

/obj/structure/vehicle_component/plating/hull/upon_install(var/obj/machinery/overmap_vehicle/new_vehicle)
	..()

	//add some bonus hull points
	var/mod = get_effect_mod()
	owned_vehicle.hull_max += mod
	owned_vehicle.hull_remaining += mod

/obj/structure/vehicle_component/plating/hull/upon_uninstall()

	//remove the bonus hull points
	var/mod = get_effect_mod()
	owned_vehicle.hull_max -= mod
	owned_vehicle.hull_remaining -= mod

	//cant go below 1 hull
	if(owned_vehicle.hull_remaining <= 0)
		owned_vehicle.hull_remaining = 1

	..()



//STEALTH (hide from sensors and missile tracking)

/obj/structure/vehicle_component/plating/stealth
	name = "stealth baffle kit (large)"
	base_name = "hull plating kit"
	icon_state = "stealthplates"
	base_icon_state = "stealthplates"
	hud_icon_state = "stealthplates"
	component_name = "stealth plating"
	small_effect_mod = 1
	large_effect_mod = 2

/obj/structure/vehicle_component/plating/stealth/small
	name = "stealth baffle kit (small)"
	icon_state = "stealthplates_small"
	mount_size = MOUNT_SMALL

/obj/structure/vehicle_component/plating/stealth/upon_install(var/obj/machinery/overmap_vehicle/new_vehicle)
	..()

	//add some bonus stealth points
	owned_vehicle.stealth_baffling += get_effect_mod()

/obj/structure/vehicle_component/plating/hull/upon_uninstall()

	//remove bonus stealth points
	owned_vehicle.stealth_baffling -= get_effect_mod()

	..()
