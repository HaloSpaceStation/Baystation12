
var/global/lore_accuracy = 0


/datum/admin_secret_item/fun_secret/lore_accuracy
	name = "Toggle Lore Accuracy"

/datum/admin_secret_item/fun_secret/lore_accuracy/can_execute(var/mob/user)
	if(!ticker) return 0
	return ..()

/datum/admin_secret_item/fun_secret/lore_accuracy/execute(var/mob/user)
	. = ..()
	if(lore_accuracy)
		lore_accuracy = 0
		to_world("<span class = 'warning'>Lore Accuracy Disabled</span>")
	else
		lore_accuracy = 1
		to_world("<span class = 'warning'>Lore Accuracy Enabled</span>")
