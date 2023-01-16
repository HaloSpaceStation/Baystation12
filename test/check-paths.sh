#!/usr/bin/env bash
set -eo pipefail

FAILED=0
shopt -s globstar

exactly() { # exactly N name search [mode] [filter]
	count="$1"
	name="$2"
	search="$3"
	mode="${4:--E}"
	filter="${5:-**/*.dm}"

	num="$(grep "$mode" "$search" $filter | wc -l || true)"

	if [ $num -eq $count ]; then
		echo "$num $name"
	else
		echo "$(tput setaf 9)$num $name (expecting exactly $count)$(tput sgr0)"
		FAILED=1
	fi
}

# Commented out exactly procs are pending for future PRs/Integrations
# With the potential exception of << if you increase any of these numbers you're probably doing it wrong
exactly 0 "escapes" '\\\\(red|blue|green|black|b|i[^mc])'
exactly 6 "Del()s" '\WDel\(' # Baystation 4
exactly 2 "/atom text paths" '"/atom'
exactly 2 "/area text paths" '"/area'
exactly 2 "/datum text paths" '"/datum'
exactly 2 "/mob text paths" '"/mob'
exactly 12 "/obj text paths" '"/obj' # Baystation 10
exactly 8 "/turf text paths" '"/turf'
#exactly 117 "to_world uses" '\sto_world\('
#exactly 0 "globals with leading /" '^/var' -P
#exactly 0 "globals without global sugar" '^var/(?!global/)' -P
exactly 0 "apparent paths with trailing /" '\w/[,\)\n]' -P
#exactly 51 "to_world_log uses" '\sto_world_log\('
exactly 1 "world<< uses" 'world<<|world[[:space:]]<<' # Baystation 0
exactly 41 "world.log<< uses" 'world.log<<|world.log[[:space:]]<<' # Baystation 0
exactly 731 "<< uses" '(?<!<)<<(?!<)' -P # Baystation 2
#exactly 2 ">> uses" '(?<!>)>>(?!>)' -P
#exactly 0 "incorrect indentations" '^( {4,})' -P
#exactly 25 "text2path uses" 'text2path'
#exactly 3 "update_icon() override" '/update_icon\((.*)\)'  -P
#exactly 5 "goto use" 'goto '
#exactly 1 "NOOP match" 'NOOP'
#exactly 352 "spawn uses" '^\s*spawn\s*\(\s*(-\s*)?\d*\s*\)' -P
#exactly 0 "tag uses" '\stag = ' -P '**/*.dmm'
#exactly 0 "anchored = 0/1" 'anchored\s*=\s*\d' -P
#exactly 2 "density = 0/1" 'density\s*=\s*\d' -P
#exactly 0 "emagged = 0/1" 'emagged\s*=\s*\d' -P
#exactly 0 "simulated = 0/1" 'simulated\s*=\s*\d' -P
#exactly 2 "var/ in proc arguments" '(^/[^/].+/.+?\(.*?)var/' -P
#exactly 0 "tmp/ vars" 'var.*/tmp/' -P
# With the potential exception of << if you increase any of these numbers you're probably doing it wrong

num=`find ./html/changelogs -not -name "*.yml" | wc -l`
echo "$num non-yml files (expecting exactly 2)"
[ $num -eq 2 ] || FAILED=1

num=`find . -perm /111 -name "*.dm*" | wc -l`
echo "$num executable *.dm? files (expecting exactly 0)"
[ $num -eq 0 ] || FAILED=1

exit $FAILED
