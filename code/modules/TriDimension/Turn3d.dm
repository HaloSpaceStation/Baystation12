
/proc/turn3d(var/turnDir, var/angle)
	//if it's not an up or down direction, just use the inbuilt byond proc
	if( !(turnDir & (UP|DOWN)) )
		return turn(turnDir, angle)

	//extract the 2d direction
	var/other_dir = (turnDir|UP|DOWN) ^ (UP|DOWN)

	//turn it like normal
	var/other_dir_turned = other_dir ? turn(other_dir, angle) : 0

	//extract the z direction (up or down)
	var/zdir = turnDir & (UP|DOWN)
	var/zdir_turned = zdir

	//flip the zdir to it's opposite
	if(zdir == UP)
		zdir_turned = DOWN
	else if(zdir == DOWN)
		zdir_turned = UP

	//return the result
	return other_dir_turned | zdir_turned
