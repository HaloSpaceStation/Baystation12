
/datum/vehicle_mount
	var/name
	var/name_abbr
	var/mount_type = MOUNT_INT
	var/mount_size = MOUNT_LARGE
	var/mount_index = 0
	var/obj/machinery/overmap_vehicle/my_vehicle
	var/obj/structure/vehicle_component/my_component

	var/screenpos_offsetx = 0
	var/screenpos_offsety = 0
	//
	var/obj/vehicle_hud/mount/screen_sysmount
	var/obj/vehicle_hud/mount_background/screen_bg
	var/list/hud_objects = list()
	//mount offsets are from the bottom left corner when the vehicle faces NORTH

/datum/vehicle_mount/New(var/obj/machinery/overmap_vehicle/owning_vehicle)
	my_vehicle = owning_vehicle

	screen_sysmount = new(owning_vehicle, null, src)
	screen_bg = new(my_vehicle, my_component)

	hud_objects += screen_sysmount
	hud_objects += screen_bg

/datum/vehicle_mount/proc/set_vehicle_component(var/obj/structure/vehicle_component/vehicle_component)
	my_component = vehicle_component
	my_component.owned_vehicle = my_vehicle
	screen_sysmount.my_weapon = vehicle_component

/datum/vehicle_mount/proc/update_screen()
	screen_sysmount.screen_loc = "[1+screenpos_offsetx],[2+screenpos_offsety]"
	screen_bg.screen_loc = "[1+screenpos_offsetx],[1+screenpos_offsety]"
	if(my_component)
		my_component.update_screen()

/datum/vehicle_mount/proc/get_hud_objects()
	. = list()
	. += hud_objects
	if(my_component && my_component.install_status == my_component.install_requires)
		. += my_component.get_hud_objects()

/datum/vehicle_mount/proc/position_weapon(var/obj/structure/vehicle_component/weapon/weapon)
	world << "WARNING: Virtual proc called /datum/vehicle_mount/proc/position_weapon([weapon])"
