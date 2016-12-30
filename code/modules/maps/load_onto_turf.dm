/*
~Turf Map Loader~

	Written by Cael_Aislinn January 9th 2016
	Uses dmm_suite version 1.0

	Purpose: Plugs lightly into dmm_suite to enable loading of smaller "maplets" onto specific turfs.
	Setup: This works without any edits to dmm_suite itself (just copy paste the file and use the procs).

	Originally written for Halostation13 for shuttle loading but released under all applicable licences etc
	See https://github.com/HaloSpaceStation/HaloSpaceStation13 for licencing info

	Quote: "Haha why does 5 year old code still work so nicely..."
*/

/*
	Mostly a copy paste of:
	dmm_suite/load_map(var/dmm_file as file, var/z_offset as num)
*/
//Warnings
//1. This doesn't safety check the map dimensions, ensure you do that before calling it! (results unpredictable otherwise)
//2. Will overwrite any turfs but other pre-existing atoms such as mobs or objs should persist (not sure about areas)
dmm_suite/verb/load_onto_turf(var/dmm_file as file, var/turf/start_turf)
	if(!start_turf)
		return

	var/quote = ascii2text(34)
	var/tfile = file2text(dmm_file)//the map file we're creating
	var/tfile_len = length(tfile)
	var/lpos = 1 // the models definition index

	///////////////////////////////////////////////////////////////////////////////////////
	//first let's map model keys (e.g "aa") to their contents (e.g /turf/space{variables})
	///////////////////////////////////////////////////////////////////////////////////////
	var/list/grid_models = list()
	var/key_len = length(copytext(tfile,2,findtext(tfile,quote,2,0)))//the length of the model key (e.g "aa" or "aba")

	//proceed line by line
	for(lpos=1; lpos<tfile_len; lpos=findtext(tfile,"\n",lpos,0)+1)
		var/tline = copytext(tfile,lpos,findtext(tfile,"\n",lpos,0))
		if(copytext(tline,1,2) != quote)//we reached the map "layout"
			break
		var/model_key = copytext(tline,2,2+key_len)
		var/model_contents = copytext(tline,findtext(tfile,"=")+3,length(tline))
		grid_models[model_key] = model_contents
		sleep(-1)

	///////////////////////////////////////////////////////////////////////////////////////
	//now let's fill the map with turf and objects using the constructed model map
	///////////////////////////////////////////////////////////////////////////////////////

	//position of the currently processed square
	var/ycrd=0
	var/xcrd=0

	for(var/zpos=findtext(tfile,"\n(1,1,",lpos,0);zpos!=0;zpos=findtext(tfile,"\n(1,1,",zpos+1,0))	//in case there's several maps to load

		var/zgrid = copytext(tfile,findtext(tfile,quote+"\n",zpos,0)+2,findtext(tfile,"\n"+quote,zpos,0)+1) //copy the whole map grid
		var/z_depth = length(zgrid)

		var/x_depth = length(copytext(zgrid,1,findtext(zgrid,"\n",2,0)))
		var/y_depth = z_depth / (x_depth+1)//x_depth + 1 because we're counting the '\n' characters in z_depth

		//then proceed it line by line, starting from top
		ycrd = y_depth - 1

		for(var/gpos=1;gpos!=0;gpos=findtext(zgrid,"\n",gpos,0)+1)
			var/grid_line = copytext(zgrid,gpos,findtext(zgrid,"\n",gpos,0))

			//fill the current square using the model map
			xcrd=0
			for(var/mpos=1;mpos<=x_depth;mpos+=key_len)
				var/model_key = copytext(grid_line,mpos,mpos+key_len)
				parse_grid(grid_models[model_key], xcrd + start_turf.x, ycrd + start_turf.y, start_turf.z)
				xcrd++

			//reached end of current map
			if(gpos+x_depth+1>z_depth)
				break

			ycrd--

			sleep(-1)

		//reached End Of File
		if(findtext(tfile,quote+"}",zpos,0)+2==tfile_len)
			break
		sleep(-1)

		//ignore successive zlevels, only grab the top 1
		break
