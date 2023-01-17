/decl/hierarchy/supply_pack/covenant_equipment
	name = "Covenant Miscellaneous Equipment"
	faction_lock = "Covenant"
	containertype = /obj/structure/closet/crate/covenant

/* COVVIE DEPLOYABLES */

/decl/hierarchy/supply_pack/covenant_equipment/weapon_rack
	name = "Weapon Charging Rack (1)"
	contains = list(/obj/structure/weapon_rack = 1)
	cost = 1000
	containertype = null

/decl/hierarchy/supply_pack/covenant_equipment/barricades_energy
	name = "Energy Barricades (5)"
	contains = list(/obj/item/energybarricade = 5)
	cost = 500
	containername = "\improper Energy Barricades crate"

/decl/hierarchy/supply_pack/covenant_equipment/barricades_vacuum
	name = "Vacuum Shields (5)"
	contains = list(/obj/item/energybarricade/vacuum_shield = 5)
	cost = 500
	containername = "\improper Vacuum Shields crate"

/* LIGHTS */

/decl/hierarchy/supply_pack/covenant_equipment/floodlight
	name = "Area Illuminator (1)"
	contains = list(/obj/machinery/floodlight/covenant = 1)
	cost = 100
	containertype = null

/decl/hierarchy/supply_pack/covenant_equipment/flare
	name = "Luminators (8)"
	contains = list(/obj/item/device/flashlight/covenant = 8)
	cost = 50
	containername = "\improper Luminator crate"

/decl/hierarchy/supply_pack/covenant_equipment/glowsticks
	name = "Glowsticks (10)"
	contains = list(/obj/item/device/flashlight/glowstick/purple = 10)
	cost = 50
	containername = "\improper Glowsticks crate"

/decl/hierarchy/supply_pack/covenant_equipment/nvgs
	name = "Improved Night Vision Goggles (2)"
	contains = list(/obj/item/clothing/glasses/tacgoggles = 2)
	cost = 500
	containername = "\improper NVGs Crate"

/* PINPOINTERS */

/decl/hierarchy/supply_pack/covenant_equipment/artifact_pinpointer
	name = "Artifact Pinpointer (1)"
	contains = list(/obj/item/weapon/pinpointer/artifact = 1)
	cost = 200
	containername = "\improper Artifact Pinpointers crate"

/decl/hierarchy/supply_pack/covenant_equipment/scanpoint_locator
	name = "Scanpoint locator (1)"
	contains = list(/obj/item/weapon/pinpointer/scanpoint_locator = 1)
	cost = 200
	containername = "\improper Scanpoint Locator crate"

/decl/hierarchy/supply_pack/covenant_equipment/bomb_pinpointer
	name = "Bomb Plant Pinpointer (1)"
	contains = list(/obj/item/weapon/pinpointer/advpinpointer/bombplantlocator = 1)
	cost = 50
	containername = "\improper Bomb Plant Pinpointer crate"