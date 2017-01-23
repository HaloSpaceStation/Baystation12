/obj/effect/zlevelinfo/precreated/meteors
	name = "Meteor Shower"
	//obj_type = /obj/effect/overmapobj/sector/meteor
	desc = "A belt of giant meteors, don't stay here"
	known = 0

/obj/effect/overmapobj/sector/meteor
	always_known = 0
	icon = 'icons/invisible_tile.dmi'
	icon_state = "invis"

/obj/effect/overmapobj/sector/meteor/Crossed(atom/movable/A)
	..()
	if (istype(A,/obj/effect/overmapobj/ship))
		command_announcement.Announce("Meteors have been detected on collision course with the ship.", "Meteor Alert", new_sound = 'sound/AI/meteors.ogg')
		if(prob(95))
			spawn_meteors(5, meteors_normal)
		else
			if(prob(1))
				spawn_meteors(5, meteors_catastrophic)
			else
				spawn_meteors(5, meteors_threatening)

/obj/effect/overmapobj/sector/meteor/Uncrossed(atom/movable/A)
	..()
	if(istype(A,/obj/effect/overmapobj/ship))
		command_announcement.Announce("The ship will clear the meteor belt shortly.", "Meteor Alert")

/obj/effect/zlevelinfo/precreated/meteors/New()
	..()