
/obj/effect/overmap/sector/taurus
	name = "Taurus Colony"
	icon = 'taurus_sector_icon.dmi'
	icon_state = "jungle"

	faction = "Human Civilian"
	base = 1
	block_slipspace = 1

	map_bounds = list(2,159,179,2) //Format: (TOP_LEFT_X,TOP_LEFT_Y,BOTTOM_RIGHT_X,BOTTOM_RIGHT_Y)

	overmap_spawn_near_me = list()
	overmap_spawn_in_me = list()
	parent_area_type = /area/planets/taurus

/obj/effect/overmap/sector/taurus/CanUntargetedBombard(var/obj/console_from)
	console_from.visible_message("<span class = 'notice'>Post firing scan reveals shot telemetry was scrambled by hostile devices. Direct laser designation will be required.</span>")
	return 0

/obj/effect/overmap/sector/taurus/New()
	loot_distributor.loot_list["taurusCapPoints"] = list(/obj/machinery/computer/capture_node,/obj/machinery/computer/capture_node,/obj/machinery/computer/capture_node,/obj/machinery/computer/capture_node)
	. = ..()

/obj/effect/loot_marker/taurus_capture_points
	loot_type = "taurusCapPoints"