
var/list/z_transit_enabled = list()

//Place one of these on each zlevel to enable ztransit on that level
//Note: transit can only occur between adjacent zlevels with transit enabled
//Types of ztransit include atmos flow and mobs or objs travelling through open space or up/down ladders
/obj/effect/z_transit_enable
	name = "zlevel transit info metaobject"
	icon = 'icons/mob/screen1.dmi'
	icon_state = "x2"
	//invisibility = 101
	var/list/z_transit_enabled_ref

/obj/effect/z_transit_enable/New()
	while(z_transit_enabled.len < src.z)
		z_transit_enabled.Add(0)
	z_transit_enabled[src.z] = 1

	z_transit_enabled_ref = z_transit_enabled

//notes: the previous implementation used '11' as down and '12' as up
//remember this in case its important later (byond defines up as 16 and down as 32, i've switched 11 and 12 over to 16 and 32 in most cases)
//disposal pipes state value remains as 11 and 12 because they're not strictly referring to z direction, just 2 unique pipe states which happen to be up and down
