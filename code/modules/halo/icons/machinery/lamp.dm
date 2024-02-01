
/obj/machinery/light/lamp
	name = "lamp"
	desc = "A lamp, used for lighting outdoor areas."
	icon = 'code/modules/halo/icons/machinery/lamp.dmi'
	icon_state = "lamp1"
	base_state = "lamp"
	brightness_range = 5
	brightness_power = 2
	layer = OBJ_LAYER
	brightness_color = "#FFE6CC"
	light_type = /obj/item/weapon/light/bulb
	var/lamp_shade = 1
	anchored = 1
	density = 1