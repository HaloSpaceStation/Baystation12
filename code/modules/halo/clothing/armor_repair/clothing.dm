


/* CLOTHING */

/obj/item/clothing
	var/armor_thickness = 20 //The thickness of the armor, in mm. Keep null to opt-out usage of system for item. This value, set at compile time is the maximum value of thickness for this item. Armor can only lose 10% of this value per-hit.
	var/armor_thickness_max = 20
	var/dam_desc = ""
	var/next_warning_time = 0
	var/armor_break_sound = 'code/modules/halo/sounds/effects/armor_break.ogg'

#define WARNING_DELAY 10 SECONDS // Keeping this high so people don't get their chats spammed.

/obj/item/clothing/proc/degrade_armor_thickness(var/damage,var/damage_type)
	damage /= 10
	var/thickness_dam_cap = ARMOUR_THICKNESS_DAMAGE_CAP

	var/new_thickness = armor_thickness - min(damage,thickness_dam_cap)
	new_thickness = max(0, new_thickness)

	var/mob/user = src.loc
	if(istype(user))
		if(world.time > next_warning_time)
			if(new_thickness == 0)
				to_chat(user, "<font size = 4><span class = 'warning'>Your [name]'s armor plating is [damage_type == BURN ? "melted away" : "destroyed"]! </span></font>")
				playsound(user, armor_break_sound, 70, 1)

			else if(istype(user))
				to_chat(user, "<span class = 'warning'>Your [name]'s armor plating is [damage_type == BURN ? "scorched" : "damaged"]! </span>")
			next_warning_time = world.time + WARNING_DELAY
	armor_thickness = new_thickness
	update_damage_description()

/obj/item/clothing/proc/update_damage_description(var/damage_type = BRUTE)
	var/desc_addition_to_apply = "Its armor plating is nominal."
	desc_addition_to_apply = "<span class = 'warning'>Its armor plating is at [round(max(0,(armor_thickness/armor_thickness_max)*100))]% integrity.</span>" // Examining armor will show the exact percentage of durability remaining.
/*	if(armor_thickness < initial(armor_thickness) * 0.75)
		desc_addition_to_apply = "<span class = 'warning'> It is [damage_type == BURN ? "slightly scorched" : "partially damaged"].</span>"
	if(armor_thickness < initial(armor_thickness) * 0.5)
		desc_addition_to_apply = "<span class = 'warning'> It is [damage_type == BURN ? "half-melted" : "scarred and cracked"].</span>"
	if(armor_thickness < initial(armor_thickness) * 0.25)
		desc_addition_to_apply = "<span class = 'warning'> It is [damage_type == BURN ? "mostly melted" : "scarred and shattered"].</span>"
	if(armor_thickness <= 0)
		desc_addition_to_apply = "<span class = 'warning'> It has [damage_type == BURN ? "melted away" : "become scarred and deformed"].</span>" */
	dam_desc = desc_addition_to_apply
