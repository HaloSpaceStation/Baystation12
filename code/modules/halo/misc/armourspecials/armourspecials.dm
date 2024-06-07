/datum/armourspecials
	var/handleshield_stop_processing = 0 //If we should stop processing handleshields once we hit this.

/datum/armourspecials/proc/tryemp(var/severity)

/datum/armourspecials/proc/tryexplosion(var/severity)

/datum/armourspecials/proc/handle_shield(mob/user, var/damage, atom/damage_source = null, mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")
	return 0

/datum/armourspecials/proc/try_item_action()

/datum/armourspecials/proc/on_equip(var/obj/source_armour)

/datum/armourspecials/proc/on_drop(var/obj/source_armour)

/datum/armourspecials/Process()

/datum/armourspecials/proc/update_mob_overlay(var/image/generated_overlay)