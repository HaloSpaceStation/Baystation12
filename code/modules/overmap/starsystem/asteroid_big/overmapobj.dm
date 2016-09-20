
/obj/effect/overmapobj/bigasteroid
	name = "large asteroid"
	icon = 'icons/obj/meteor.dmi'
	icon_state = "large"
	opacity = 1
	var/datum/asteroidfield/owner
	var/obj/effect/zlevelinfo/bigasteroid/myzlevel
	sensor_icon_state = "asteroids_mine"

/obj/effect/overmapobj/bigasteroid/New()
	if(prob(50))
		icon_state = "small"
	desc = pick("It must be almost a kilometre across!",\
	"This asteroid is huge, dwarfing the others around it.",\
	"It's an enormous asteroid, easily the same size as a warship.")

	overmap_init()

/obj/effect/overmapobj/bigasteroid/proc/get_zlevel()
	//see if our zlevel has finished generating
	if(myzlevel && myzlevel.gen_stage == BIGASTEROID_CAVES_FINISH)
		//bigasteroid.myzlevel = null
		linked_zlevelinfos.Add(myzlevel)
		testing("	Space travel destination is newly finished asteroid")
		return linked_zlevelinfos[1]

	else
		//see if we can get one that's finished loading and assign it
		var/obj/effect/zlevelinfo/bigasteroid/newzlevel = overmap_controller.get_finished_asteroid_zlevel()
		if(newzlevel)
			//replace the old one with this newer finished one
			if(myzlevel)
				overmap_controller.asteroid_zlevels_loading_unassigned.Add(myzlevel)
			myzlevel = newzlevel
			linked_zlevelinfos.Add(newzlevel)
			testing("	Space travel destination is new pregen asteroid")
			return myzlevel
		else
			//see if this asteroid has even been assigned a zlevel first
			if(!myzlevel)
				//ok lets take whatever zlevel is available... might be a finished one, might be one still generating, might be a new blank zlevel
				myzlevel = overmap_controller.get_or_create_asteroid_zlevel()

				//warning, nothing setup yet to handle in case a new ordinary temp zlevel got assigned
				//

			//prioritise this one for loading
			overmap_controller.asteroid_zlevel_loading = myzlevel

			testing("	Asteroid ([src.x],[src.y]) still loading, prioritising...")

			//todo: at some point block the player from space travelling here or force them into a temp sector
			//doing this means that players are able to actually space travel to an asteroid while it is still generating and see it in progress
			//this is obviously breaking the 4th wall... commenting this line out should handily disable it
			return myzlevel
