
/obj/structure/vehicle_component
	name = "generic vehicle component module"
	var/component_name = "generic vehicle component"
	desc = "Install this into a strike craft (fighter, dropship or shuttle) to enable its functionality."
	icon = 'code/modules/overmap/overmap_vehicles/icons/components.dmi'
	var/mount_type = MOUNT_INT
	var/mount_size = MOUNT_SMALL
	var/list/required_mount_types = list()		//to limit this component to specific mount types
	//var/mount_index = 0

	var/install_status = 0
	var/install_requires = INSTALL_CABLED|INSTALL_BOLTED|INSTALL_SCREWED//INSTALL_WELDED|INSTALL_CABLED|INSTALL_BOLTED|INSTALL_SCREWED|INSTALL_PIPED

	var/hud_icon_state
	var/list/hud_objects = list()
	var/screenpos_offsetx = 0
	var/screenpos_offsety = 0
	//
	var/obj/vehicle_hud/wep_select/screen_icon

	var/obj/machinery/overmap_vehicle/owned_vehicle
	var/datum/vehicle_mount/my_mount

	var/damage = 0			//up to 100 max

	var/datum/component_group/my_component_group

	var/is_processing = 0

/obj/structure/vehicle_component/New(var/obj/machinery/overmap_vehicle/spawned_vehicle, var/datum/vehicle_mount/vehicle_mount)
	my_mount = vehicle_mount

	desc += " It goes in a [vehicle_component_size_string(mount_size)] [vehicle_component_type_string(mount_type)] mounting slot."

	init_hud_objects()
	set_vehicle(spawned_vehicle)

/obj/structure/vehicle_component/proc/init_hud_objects()
	//world << "/obj/structure/vehicle_component/proc/init_hud_objects()"
	screen_icon = new(owned_vehicle, src)

	hud_objects += screen_icon

/obj/structure/vehicle_component/proc/get_hud_objects()
	return hud_objects

/obj/structure/vehicle_component/proc/update_screen()
	screen_icon.screen_loc = "[4+screenpos_offsetx],[2+screenpos_offsety]"

/obj/structure/vehicle_component/proc/activate()
	//world << "Warning: [src] no proc/activate() defined ([usr])"

	//enable hud components
	//OVERRIDE IN CHILDREN

/obj/structure/vehicle_component/proc/deactivate()
	//world << "Warning: [src] no proc/deactivate() defined ([usr])"

	//disable hud components
	//OVERRIDE IN CHILDREN

/obj/structure/vehicle_component/proc/select()
	//world << "Warning: [src] no proc/select() defined ([usr])"

	//select hud components
	//OVERRIDE IN CHILDREN

/obj/structure/vehicle_component/proc/deselect()
	//world << "Warning: [src] no proc/deselect() defined ([usr])"

	//deselect hud components
	//OVERRIDE IN CHILDREN

/obj/structure/vehicle_component/proc/select_deselect(var/direction = -1)
	//world << "Warning: [src] no proc/select_deselect() defined ([usr])"

	//toggle or set selection status hud component
	//OVERRIDE IN CHILDREN

/obj/structure/vehicle_component/proc/set_vehicle(var/obj/machinery/overmap_vehicle/overmap_vehicle)
	if(istype(overmap_vehicle))
		owned_vehicle = overmap_vehicle
		screen_icon.my_vehicle = overmap_vehicle
		return 1
	return 0

/*
Fuel types
0 = energy
1 = diesel
2 = plasma
3 = h-fuel
4 = dt-fuel
*/

/*
/datum/overmap_vehicle_component
	var/rate = 0				//depends on type of component
	var/integrity = 1			//0-1
	var/fuel_type = 0			//default to use 1 fuel per sec
	var/heat = 0
	var/max_heat = 100
	var/heat_damage = 0.1		//damage per sec if overheated
	var/running_heat = 1		//heat per sec while running

	var/overclock_enabled = 1
	var/clock_multiplier = 1
	var/overclock_heat = 1		//additional heat per sec if overclocking (multiplied by clock rate)

/datum/overmap_vehicle_component/verb/enable_hover()
	set name = "Enable hover mode"
	set category = "Vehicle"
	set src = usr.loc

	if(istype(src, /obj/machinery/overmap_vehicle))
		var/obj/machinery/overmap_vehicle/O = src
		O.set_hovering(1)

/datum/overmap_vehicle_component/verb/disable_hover()
	set name = "Disable hover mode"
	set category = "Vehicle"
	set src = usr.loc

	if(istype(src, /obj/machinery/overmap_vehicle))
		var/obj/machinery/overmap_vehicle/O = src
		O.set_hovering(0)

/datum/overmap_vehicle_component/verb/extend_landing_gear()
	set name = "Extend landing gear"
	set category = "Vehicle"
	set src = usr.loc

	if(istype(src, /obj/machinery/overmap_vehicle))
		var/obj/machinery/overmap_vehicle/O = src
		O.set_landing_gear(1)

/datum/overmap_vehicle_component/verb/retract_landing_gear()
	set name = "Retract landing gear"
	set category = "Vehicle"
	set src = usr.loc

	if(istype(src, /obj/machinery/overmap_vehicle))
		var/obj/machinery/overmap_vehicle/O = src
		O.set_landing_gear(0)
*/

/obj/structure/vehicle_component/proc/upon_install(var/obj/machinery/overmap_vehicle/new_vehicle)
	owned_vehicle = new_vehicle
	src.loc = owned_vehicle

/obj/structure/vehicle_component/proc/upon_uninstall()
	src.loc = owned_vehicle.loc
	owned_vehicle = null
