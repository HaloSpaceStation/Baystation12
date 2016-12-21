/obj/docking_umbilical
	name = "Docking Umbilical"
	desc = "Connects to nearby ships"
	var/side
	var/obj/effect/overmapobj/ship
	var/broke = FALSE
	var/id = "CHANGE ME OR SUFFER!"
	var/valid_dests = list()
	var/obj/docking_umbilical/dest
	var/null
	var/deployed = FALSE

/obj/docking_umbilical/New()
	ship = map_sectors["[z]"] //TODO: This is bad!
	ship.connectors += src
	tag = id

/obj/docking_umbilical/proc/can_connect(var/obj/effect/overmapobj/otherShip, var/id)
	if(!broke)
		for(var/umbId in otherShip.connectors)
			if (umbId == id)
				var/obj/docking_umbilical/umbObj = locate(umbId)
				if (umbObj.side == turn(side, 180) && !umbObj.broke)
					return TRUE
				else
					return FALSE

/obj/docking_umbilical/proc/get_destinations()
	valid_dests = list()
	for(var/obj/effect/overmapobj/s in oview(2, ship))
		for(var/umbId in s.connectors)
			if(can_connect(s, umbId))
				valid_dests[umbId] = s

/obj/docking_umbilical/proc/connect(var/id, var/init = TRUE)
	if(valid_dests[id])
		if(can_connect(valid_dests[id], id) && !broke)
			dest = locate(id)
			deployed = TRUE
			if(init)
				dest.connect(src.id, FALSE)

/obj/docking_umbilical/proc/disconnect()
	dest.dest = null
	dest.deployed = FALSE
	dest = null
	deployed = FALSE

/obj/docking_umbilical/proc/rip()
	dest.dest = null
	dest.broke = TRUE
	dest = null
	broke = TRUE
	deployed = FALSE
	if(prob(99))
		explosion(get_turf(src), 0, 1, 2, 0)
	else //So unlucky D:
		explosion(get_turf(src), 5, 1, 1, 0)