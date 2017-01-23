/obj/effect/zlevelinfo/precreated/radiate
	name = "Radiation Storm"
	//obj_type = /obj/effect/overmapobj/sector/radiate
	desc = "Field of lethal radiation"
	known = 0

/obj/effect/overmapobj/sector/radiate
	always_known = 0
	icon = 'icons/invisible_tile.dmi'
	icon_state = "invis"

/obj/effect/overmapobj/sector/radiate/Crossed(atom/movable/a)
	..()
	command_announcement.Announce("High levels of high-energy radiation detected near the ship. Please evacuate into one of the shielded maintenance tunnels.", "Radiation Alert", new_sound = 'sound/AI/radiation.ogg')
	spawn(2)
	make_maint_all_access()
	for(var/x in 1 to 30)
		for(var/mob/living/carbon/C in config.station_levels)
			var/area/A = get_area(C)
			if(A.flags & !RAD_SHIELDED)
				C.apply_effect(rand(15,35),IRRADIATE,0)

/obj/effect/overmapobj/sector/radiate/Uncrossed(atom/movable/a)
	..()
	command_announcement.Announce("The ship is now clearing the radiation storm.", "Radiation Alert Canceled")
	revoke_maint_all_access()

/*/hook/customOvermap/proc/radStorms()
	for(var/x in 1 to 3)
		load_prepared_sector("Radiation Storm", "RadiationStorm[x]")
	return 1*/
