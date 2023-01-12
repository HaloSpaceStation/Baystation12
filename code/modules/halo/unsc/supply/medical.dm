/decl/hierarchy/supply_pack/unsc_medical
	name = "UNSC Medical Supplies"
	faction_lock = "UNSC"
	containertype = /obj/structure/closet/crate/secure/weapon

/* SANITIZATION */

/decl/hierarchy/supply_pack/unsc_medical/cleaning_supplies
	name = "Cleaning Supplies"
	contains = list(
	/obj/item/weapon/reagent_containers/spray/cleaner = 1,
	/obj/item/weapon/soap = 2,
	/obj/item/weapon/storage/bag/trash = 1,
	)
	cost = 20
	containername = "\improper Cleaning Supplies Crate"

/* MEDICAL KITS */

/decl/hierarchy/supply_pack/unsc_medical/firstaid
	name = "First Aid Packs (4 packs)"
	contains = list(/obj/item/weapon/storage/firstaid/unsc = 4)
	cost = 200
	containername = "\improper First Aid Crate"

/decl/hierarchy/supply_pack/unsc_medical/biofoam
	name = "Biofoam Crate (10 syringes)"
	contains = list(/obj/item/weapon/reagent_containers/syringe/biofoam = 10)
	cost = 250
	containername = "\improper Biofoam Crate"

/decl/hierarchy/supply_pack/unsc_medical/traumakits
	name = "Field Trauma Kits (3 packs)"
	contains = list(/obj/item/weapon/storage/firstaid/combat/unsc = 3)
	cost = 200
	containername = "\improper Field Trauma Crate"

/decl/hierarchy/supply_pack/unsc_medical/pillkit
	name = "Medical Pill Kit (2 Bicardine, Dermaline, Hyronalin Bottles)"
	contains = list(
	/obj/item/weapon/storage/pill_bottle/bicaridine = 2,
	/obj/item/weapon/storage/pill_bottle/dermaline = 2,
	/obj/item/weapon/storage/pill_bottle/hyronalin = 2,
	)
	cost = 150
	containername = "\improper Pill Kit Crate"

/decl/hierarchy/supply_pack/unsc_medical/psychostimulantpack
	name = "Psychostimulants (5 Syringes)"
	contains = list(/obj/item/weapon/reagent_containers/syringe/psychostimulant = 5)
	cost = 200
	containername = "\improper Psychostimulant Crate"

/* MISC EQUIPMENT */

/decl/hierarchy/supply_pack/unsc_medical/stasisbags
	name = "Stasis Bags (3 Bags)"
	contains = list(/obj/item/bodybag/cryobag = 3)
	cost = 250
	containername = "\improper Stasis Bag Crate"

/decl/hierarchy/supply_pack/unsc_medical/autopsykit
	name = "Autopsy Kit"
	contains = list(
	/obj/item/weapon/storage/firstaid/surgery = 1,
	/obj/item/weapon/autopsy_scanner = 1,
	/obj/item/weapon/storage/fancy/vials = 1,
	/obj/item/device/healthanalyzer = 1,
	/obj/item/device/camera = 1,
	/obj/item/weapon/storage/briefcase/crimekit = 1,
	/obj/item/device/reagent_scanner/adv = 1,
	)
	cost = 150
	containername = "\improper Autopsy Kit"

/decl/hierarchy/supply_pack/unsc_medical/medfob
	name = "Medical FOB Kit"
	containertype = /obj/structure/largecrate //Requires a larger crate to fit
	contains = list(
	/obj/machinery/iv_drip = 1,
	/obj/structure/bed/roller = 1,
	/obj/item/weapon/tank/anesthetic = 2,
	/obj/item/clothing/mask/breath/anesthetic = 2,
	/obj/item/weapon/defibrillator/loaded = 1,
	/obj/item/weapon/reagent_containers/blood/OMinus = 4,
	/obj/item/weapon/reagent_containers/spray/cleaner = 1,
	/obj/item/weapon/storage/firstaid/surgery = 1,
	/obj/item/weapon/storage/box/gloves = 1,
	/obj/item/weapon/storage/box/masks = 1,
	/obj/item/weapon/storage/box/bodybags = 1,
	)
	cost = 800
	containername = "\improper Medical FOB Kit (DO NOT OPEN UNTIL IN POSITION)"