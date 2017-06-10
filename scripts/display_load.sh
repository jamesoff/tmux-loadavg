#!/bin/bash

which=${1:-short}
#cpus=$( sysctl -n hw.ncpu )

declare -a uptimes
uptimes=( $( uptime | awk '{
	min15=NF
	min5=NF-1
	min1=NF-2

	print $min1, $min5, $min15
}' ) )

if [[ $which == "short" ]]; then
	echo "${uptimes[0]}"
else
	echo "${uptimes[0]} ${uptimes[1]} ${uptimes[2]}"
fi
