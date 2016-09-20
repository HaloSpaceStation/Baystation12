
var/global/asteroid_masks = list()

/turf/unsimulated/mask/New()
	var/list/zlevel_asteroid_masks = asteroid_masks["[src.z]"]
	if(!zlevel_asteroid_masks)
		zlevel_asteroid_masks = list()
		asteroid_masks["[src.z]"] = zlevel_asteroid_masks
	zlevel_asteroid_masks.Add(src)
