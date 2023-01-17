/decl/hierarchy/supply_pack/unsc_misc
	name = "UNSC Miscellaneous Equipment"
	faction_lock = "UNSC"
	containertype = /obj/structure/closet/crate/secure/weapon

/* LIGHTS */

/decl/hierarchy/supply_pack/unsc_misc/floodlight
	name = "Floodlight (1)"
	contains = list(/obj/machinery/floodlight = 1)
	cost = 100
	containertype = null

/decl/hierarchy/supply_pack/unsc_misc/flare
	name = "Flares (8)"
	contains = list(/obj/item/device/flashlight/flare = 8)
	cost = 50
	containername = "\improper Flares Crate"

/decl/hierarchy/supply_pack/unsc_misc/glowstick
	name = "Glowsticks (10)"
	contains = list(/obj/item/device/flashlight/glowstick = 10)
	cost = 50
	containername = "\improper Glowsticks Crate"

/decl/hierarchy/supply_pack/unsc_misc/nvgs
	name = "Improved Night Vision Goggles (2)"
	contains = list(/obj/item/clothing/glasses/tacgoggles = 2)
	cost = 500
	containername = "\improper NVGs Crate"

/* PINPOINTERS */

/decl/hierarchy/supply_pack/unsc_misc/bomb_pinpointer
	name = "Bomb Plant Pinpointer (1)"
	contains = list(/obj/item/weapon/pinpointer/advpinpointer/bombplantlocator = 1)
	cost = 50
	containername = "\improper Bomb Plant Pinpointer crate"

/decl/hierarchy/supply_pack/unsc_misc/scanpoint_locator
	name = "Signal Interception Device (1)"
	contains = list(/obj/item/weapon/pinpointer/scanpoint_locator/unsc = 1)
	cost = 200
	containername = "\improper Scanpoint Pinpointer crate"

/decl/hierarchy/supply_pack/unsc_misc/artifact_pinpointer
	name = "Artifact Pinpointer (1)"
	contains = list(/obj/item/weapon/pinpointer/artifact = 1)
	cost = 10000
	containername = "\improper Artifact Pinpointers crate"