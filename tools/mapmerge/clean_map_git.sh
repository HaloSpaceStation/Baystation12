#!/bin/bash

for i in {1..4}
do
	MAPFILE="unsc_frigate-$i.dmm"

	git show HEAD:maps/$MAPFILE > tmp.dmm
	java -jar MapPatcher.jar -clean tmp.dmm '../../maps/'$MAPFILE '../../maps/'$MAPFILE
	rm tmp.dmm
done
