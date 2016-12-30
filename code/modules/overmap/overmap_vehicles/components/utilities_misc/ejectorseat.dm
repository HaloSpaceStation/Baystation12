
/obj/structure/vehicle_component/ejector
	name = "ejector seat module"
	icon_state = "ejector"
	mount_type = MOUNT_CREW
	mount_size = MOUNT_MEDIUM
	install_requires = INSTALL_SCREWED|INSTALL_CABLED//INSTALL_WELDED|INSTALL_CABLED|INSTALL_BOLTED|INSTALL_SCREWED|INSTALL_PIPED

/obj/structure/vehicle_component/plating/hull/upon_install(var/obj/machinery/overmap_vehicle/new_vehicle)
	..()
	owned_vehicle.pilot_ejector_module = src

/obj/structure/vehicle_component/plating/hull/upon_uninstall()
	owned_vehicle.pilot_ejector_module = null
	..()
