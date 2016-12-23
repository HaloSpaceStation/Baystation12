


//RADIO - allows radio communication throughout this and adjacent sectors... may reach further with some interference

/obj/structure/vehicle_component/radio
	name = "vehicle radio antenna"
	icon_state = "radio"
	mount_type = MOUNT_EXT
	mount_size = MOUNT_LARGE
	install_requires = INSTALL_BOLTED|INSTALL_CABLED//INSTALL_WELDED|INSTALL_CABLED|INSTALL_BOLTED|INSTALL_SCREWED|INSTALL_PIPED

/obj/structure/vehicle_component/radio/upon_install(var/obj/machinery/overmap_vehicle/new_vehicle)
	..()
	owned_vehicle.vehicle_radio = src

/obj/structure/vehicle_component/radio/upon_uninstall()
	owned_vehicle.vehicle_radio = null
	..()



//ANTENNA - allows radio communication over the whole system (requires radio to work)

/obj/structure/vehicle_component/radio_antenna
	name = "vehicle radio"
	icon_state = "antenna"
	mount_type = MOUNT_CREW
	mount_size = MOUNT_MEDIUM

/obj/structure/vehicle_component/radio_antenna/upon_install(var/obj/machinery/overmap_vehicle/new_vehicle)
	..()
	owned_vehicle.vehicle_antenna = src

/obj/structure/vehicle_component/radio_antenna/upon_uninstall()
	owned_vehicle.vehicle_antenna = null
	..()
