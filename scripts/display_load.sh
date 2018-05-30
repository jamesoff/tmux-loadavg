#!/usr/bin/env bash

which=${1:-short}
os=$(uname -s)
case $os in
    Linux|Darwin)
        cpus=$( getconf _NPROCESSORS_ONLN )
        ;;
    FreeBSD)
        cpus=$( getconf NPROCESSORS_ONLN )
        ;;
    *)
        # What do I do now, Mum?
        cpus=1
esac


format_load() {
	load_info=$( awk \
		-v "sys_load=$1" \
		-v "cpus=$cpus" \
		-v "half_cpus=$half_cpus" \
		'BEGIN {
			if ( sys_load > cpus ) {
				print "high"
			}
			else if ( sys_load > half_cpus ) {
				print "medium"
			}
			else {
				print "low"
			}
		}'
	)

	case $load_info in
		high)
			printf "#[fg=colour160]"
			;;
		medium)
			printf "#[fg=colour214]"
			;;
		low)
			printf "#[fg=colour70]"
			;;
	esac
	echo "$1"
}


declare -a uptimes
uptimes=( $( uptime | awk -v "cpus=$cpus" '
BEGIN {
        FS=",? "
}

{
	min15=NF
	min5=NF-1
	min1=NF-2

	print $min1, $min5, $min15, cpus / 2
}' ) )

half_cpus=${uptimes[3]}

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
