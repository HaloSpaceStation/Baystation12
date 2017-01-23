
/obj/effect/map/vehicle
	name = "generic fighter"
	desc = "Space faring fighter."
	icon = 'code/modules/overmap/ships/ships.dmi'
	icon_state = "longsword"

	var/obj/effect/map/current_sector

	var/obj/effect/overlay/crosshairs_overlay

	var/datum/vehicle_transform/vehicle_transform
