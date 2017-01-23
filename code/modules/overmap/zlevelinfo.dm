
//=============================================================================================
//Metaobject for storing information about this zlevel to be used by a corresponding overmapobj
//Should be placed once on every zlevel.
//=============================================================================================

/obj/effect/zlevelinfo
	name = "undefined zlevel"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	invisibility = 101

	//set this to 1 if you have are going to put all the initialisation data for the overmapobject in this zlevelinfo
	var/use_me_to_initialise = 0

	var/landing_area 	//type of area used as inbound shuttle landing, null if no shuttle landing area
	var/known = 1
	var/faction = ""
	//var/overmapobj_name = "undefined overmapobj"


/obj/effect/zlevelinfo/New()
	tag = "zlevel[z]"

//overmapobjs that are able to be moved/steered around
/obj/effect/zlevelinfo/ship

//place this onto an empty zlevel for it to be automatically added to the cache of preloaded empty zlevels at server start
//these levels are used for temporary sectors in deep space travel as well as ships, planets, stations etc that are loaded during the round
//good idea to have at least 2-3
/obj/effect/zlevelinfo/precached
