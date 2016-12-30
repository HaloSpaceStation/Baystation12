
/obj/vehicle_hud/mount
	panel_icon_state = "weapon"
 var/datum/vehicle_mount/my_mount

/obj/vehicle_hud/mount/New(var/obj/machinery/overmap_vehicle/overmap_vehicle, var/obj/structure/vehicle_component/vehicle_component, var/datum/vehicle_mount/vehicle_mount)
	my_mount = vehicle_mount
	..()

/obj/vehicle_hud/mount/Click(location,control,params)
	if(my_weapon)
		usr << "\icon[my_vehicle] \icon[my_weapon]<span class='info'>[my_weapon.component_name] is installed in the [my_mount.name] mount</span>"
	else
		usr << "\icon[my_vehicle] <span class='info'>The [my_mount.name] mount does not have a component installed in it.</span>"

/obj/vehicle_hud/mount/update_icon()
	maptext = "<div style=\"[HUD_CSS_STYLE_LESSER]\">[my_mount.name_abbr]</div>"
	name = "[my_mount.name] mount"
