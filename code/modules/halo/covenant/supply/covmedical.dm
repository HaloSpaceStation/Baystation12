/decl/hierarchy/supply_pack/covmedical
	name = "Covenant Medical Supplies"
	faction_lock = "Covenant"
	containertype = /obj/structure/closet/crate/covenant

/* SANITIZATION */

/decl/hierarchy/supply_pack/covmedical/cleaning_supplies
	name = "Cleaning Supplies"
	contains = list(
	/obj/item/weapon/reagent_containers/spray/cleaner = 1,
	/obj/item/weapon/soap = 2,
	/obj/item/weapon/storage/bag/trash = 1,
	)
	cost = 20
	containername = "\improper Cleaning Supplies Crate"

/* MEDICAL KITS */

/decl/hierarchy/supply_pack/covmedical/firstaid
	name = "First Aid Packs (4 packs)"
	contains = list(/obj/item/weapon/storage/firstaid/unsc/cov = 4)
	cost = 200
	containername = "\improper First Aid Crate"

/decl/hierarchy/supply_pack/covmedical/biofoam
	name = "Biofoam Crate (10 syringes)"
	contains = list(/obj/item/weapon/reagent_containers/syringe/biofoam = 10)
	cost = 250
	containername = "\improper Biofoam Crate"

/decl/hierarchy/supply_pack/covmedical/traumakits
	name = "Field Trauma Kits (3 packs)"
	contains = list(/obj/item/weapon/storage/firstaid/combat/unsc/cov = 3)
	cost = 200
	containername = "\improper Field Trauma Crate"

/decl/hierarchy/supply_pack/covmedical/pillkit
	name = "Medical Pill Kit (2 Bicardine, Dermaline, Hyronalin Bottles)"
	contains = list(
	/obj/item/weapon/storage/pill_bottle/covenant/bicaridine = 2,
	/obj/item/weapon/storage/pill_bottle/covenant/dermaline = 2,
	/obj/item/weapon/storage/pill_bottle/covenant/hyronalin = 2,
	)
	cost = 150
	containername = "\improper Pill Kit Crate"

/decl/hierarchy/supply_pack/covmedical/psychostimulantpack
	name = "Psychostimulants (5 Syringes)"
	contains = list(/obj/item/weapon/reagent_containers/syringe/psychostimulant = 5)
	cost = 200
	containername = "\improper Psychostimulant Crate"

/* MISC EQUIPMENT */

/decl/hierarchy/supply_pack/covmedical/stasisbags
	name = "Stasis Bags (3 Bags)"
	contains = list(/obj/item/bodybag/cryobag/covenant = 3)
	cost = 250
	containername = "\improper Stasis Bag Crate"

/decl/hierarchy/supply_pack/covmedical/medfob
	name = "Medical FOB Kit"
	containertype = /obj/structure/largecrate //Requires a larger crate to fit
	contains = list(
	/obj/machinery/iv_drip/covenant = 1,
	/obj/structure/bed/roller/covenant = 1,
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