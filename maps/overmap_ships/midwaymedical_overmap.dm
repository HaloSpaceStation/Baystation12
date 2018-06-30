/obj/effect/overmap/ship/midwaymedical
	name = "Midway Medical Ship"
	desc = "A small custom designed medical ship."

/obj/effect/overmap/ship/midwaymedical/Initialize()
	. = ..()
	var/obj/m_medical
	for(var/obj/effect/overmap/ship/midwaymedical/n in world)
		m_medical = n
	if(isnull(m_medical))
		return
	forceMove(m_medical)