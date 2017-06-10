#!/bin/bash

which=${1:-short}
cpus=$( sysctl -n hw.ncpu )

format_load() {
	load=$1
	if [[ $load > $cpus ]]; then
		printf "#[fg=colour160]"
	elif [[ $load > $(( cpus / 2 )) ]]; then
		printf "#[fg=colour226]"
	else
		printf "#[fg=colour40]"
	fi
	echo "$load"
}


declare -a uptimes
uptimes=( $( uptime | awk '{
	min15=NF
	min5=NF-1
	min1=NF-2

	print $min1, $min5, $min15
}' ) )

if [[ $which == "short" ]]; then
	format_load "${uptimes[0]}"
else
	echo "${uptimes[0]} ${uptimes[1]} ${uptimes[2]}"
fi
