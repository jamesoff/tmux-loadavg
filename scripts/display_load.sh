#!/bin/bash

which=${1:-short}
os=$(uname -s)
case $os in
    Linux|Darwin)
        cpus=$( getconf NPROCESSORS_ONLN )
        ;;
    FreeBSD)
        cpus=$( getconf _NPROCESSORS_ONLN )
        ;;
    *)
        # What do I do now, Mum?
        cpus=4
esac


format_load() {
	load=$1
	if [[ $load > $cpus ]]; then
		printf "#[fg=colour160]"
	elif [[ $load > $(( cpus / 2 )) ]]; then
		printf "#[fg=colour214]"
	else
		printf "#[fg=colour70]"
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

case $which in
    short)
        format_load "${uptimes[0]}"
        ;;
    full)
        echo "$(format_load "${uptimes[0]}") $(format_load "${uptimes[1]}") $(format_load "${uptimes[2]}")"
        ;;
    *)
        echo "Usage: $0 [short|full]"
esac
