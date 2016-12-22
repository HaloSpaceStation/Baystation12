
/obj/machinery/overmap_vehicle/longsword
	name = "GA-TL1 Longsword"
	desc = "Standard UNSC multirole starfighter"
	icon = 'code/modules/overmap/overmap_vehicles/icons/longsword.dmi'
	icon_state = "longsword"
	bound_width = 128
	bound_height = 128
	yaw_speed = 10
	accel_duration = 50
	sensor_icon_state = "longsword"
	iff_faction_broadcast = "UNSC"
	//nosegun_enabled = 1

/obj/machinery/overmap_vehicle/longsword/New()
	..()
	overmap_object.icon_state = "longsword"
	pixel_transform.icon_state_thrust = "longsword_thruster"

/obj/machinery/overmap_vehicle/longsword/health_update()
	//update damage overlays
	var/dmg_percent = 1 - (hull_remaining / hull_max)
	var/new_damage_state = 0
	if(dmg_percent >= 0.7)
		new_damage_state = 4
	else if(dmg_percent >= 0.5)
		new_damage_state = 3
	else if(dmg_percent >= 0.3)
		new_damage_state = 2
	else if(dmg_percent >= 0.1)
		new_damage_state = 1

	if(new_damage_state != damage_state)
		overlays -= damage_overlay
		if(new_damage_state)
			damage_overlay = new('code/modules/overmap/overmap_vehicles/icons/longsword.dmi', "dam[damage_state]")
			overlays += damage_overlay

		damage_state = new_damage_state

	//let the parent proc handle damage processing
	..()



//INTERCEPTOR LOADOUT (default)
//2 x wing mounted rotary cannons, 1 x ventral mounted ASGM-10 missile rack, chassis mounted flare and chaff launchers, 85 bonus hull

/obj/machinery/overmap_vehicle/longsword
	external_loadout = list(\
		/datum/vehicle_mount/fourbyfour/nose = /obj/structure/vehicle_component/plating/hull/small,\
		/datum/vehicle_mount/fourbyfour/centre/ventral = /obj/structure/vehicle_component/weapon/missilerack_asgm,\
		/datum/vehicle_mount/fourbyfour/centre/dorsal = /obj/structure/vehicle_component/plating/hull,\
		/datum/vehicle_mount/fourbyfour/centre/left = /obj/structure/vehicle_component/weapon/countermeasures/flare,\
		/datum/vehicle_mount/fourbyfour/centre/right = /obj/structure/vehicle_component/weapon/countermeasures/chaff,\
		/datum/vehicle_mount/fourbyfour/left = /obj/structure/vehicle_component/weapon/rotarycannon,\
		/datum/vehicle_mount/fourbyfour/right = /obj/structure/vehicle_component/weapon/rotarycannon,\
		/datum/vehicle_mount/fourbyfour/left/small = /obj/structure/vehicle_component/plating/hull/small,\
		/datum/vehicle_mount/fourbyfour/right/small = /obj/structure/vehicle_component/plating/hull/small,\
		/datum/vehicle_mount/fourbyfour/tail = /obj/structure/vehicle_component/plating/hull,\
		)

	internal_loadout = list(\
	/*for testing only
		/obj/structure/vehicle_component/weapon/countermeasures/flare,\
		/obj/structure/vehicle_component/weapon/countermeasures/chaff,\
		/obj/structure/vehicle_component/plating/stealth,\
		*/
		null,
		null,
		null,
		)
	crew_loadout = list(\
	/*for testing only
		/obj/structure/vehicle_component/weapon/missilerack_asgm,\
		/obj/structure/vehicle_component/weapon/missilerack_asgm,\
		/obj/structure/vehicle_component/plating/stealth,\
		*/
		null,
		null,
		null,
		)



//ATTACK-BOMBER LOADOUT
//2 x wing mounted auto cannons, 1 x tail mounted Moray spacemine launcher, chassis mounted flare and chaff launchers, 85 bonus hull
/*
/obj/machinery/overmap_vehicle/longsword/attackbomber
	external_loadout = list(\
		/datum/vehicle_mount/fourbyfour/nose = /obj/structure/vehicle_component/plating/hull/small,\
		/datum/vehicle_mount/fourbyfour/centre/ventral = /obj/structure/vehicle_component/plating/hull,\
		/datum/vehicle_mount/fourbyfour/centre/dorsal = /obj/structure/vehicle_component/plating/hull,\
		/datum/vehicle_mount/fourbyfour/centre/left = /obj/structure/vehicle_component/weapon/countermeasures/flare,\
		/datum/vehicle_mount/fourbyfour/centre/right = /obj/structure/vehicle_component/weapon/countermeasures/chaff,\
		/datum/vehicle_mount/fourbyfour/left = /obj/structure/vehicle_component/weapon/autocannon,\
		/datum/vehicle_mount/fourbyfour/right = /obj/structure/vehicle_component/weapon/autocannon,\
		/datum/vehicle_mount/fourbyfour/left/small = /obj/structure/vehicle_component/plating/hull/small,\
		/datum/vehicle_mount/fourbyfour/right/small = /obj/structure/vehicle_component/plating/hull/small,\
		/datum/vehicle_mount/fourbyfour/tail = /obj/structure/vehicle_component/weapon/minelayer,\
		)

	internal_loadout = list(\
	/*for testing only
		/obj/structure/vehicle_component/weapon/countermeasures/flare,\
		/obj/structure/vehicle_component/weapon/countermeasures/chaff,\
		/obj/structure/vehicle_component/plating/stealth,\
		*/
		null,
		null,
		null,
		)
	crew_loadout = list(\
	/*for testing only
		/obj/structure/vehicle_component/plating/hull,\
		/obj/structure/vehicle_component/plating/hull,\
		/obj/structure/vehicle_component/plating/stealth,\
		*/
		null,
		null,
		null,
		)
*/