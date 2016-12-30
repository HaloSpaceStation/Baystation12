
//SENSOR - allows tracking of other strike craft (note: without this ordinary waypoints will still work)

/obj/structure/vehicle_component/sensor
	name = "vehicle sensor package"
	icon_state = "sensor"
	mount_type = MOUNT_EXT
	mount_size = MOUNT_LARGE
	install_requires = INSTALL_BOLTED|INSTALL_CABLED//INSTALL_WELDED|INSTALL_CABLED|INSTALL_BOLTED|INSTALL_SCREWED|INSTALL_PIPED

	var/sensor_strength = 1

/obj/structure/vehicle_component/sensor/upon_install(var/obj/machinery/overmap_vehicle/new_vehicle)
	..()
	owned_vehicle.sensor_strength += sensor_strength

/obj/structure/vehicle_component/sensor/upon_uninstall()
	owned_vehicle.sensor_strength -= sensor_strength
	..()
