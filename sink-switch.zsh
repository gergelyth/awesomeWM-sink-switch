function toggleaudiosink() {
	ignored_sinks=("hdmi")

	ignore_string="${(j:|:)ignored_sinks}"

	while IFS= read -r line; do
		if [[ $line =~ '.*index: ([0-9]+)$' ]]; then
			index_array+=("${match[1]}")
			if [[ "$line" == *"*"* ]]; then
				#this is the current sink
				current_sink_index=${#index_array}
			fi
		elif [[ $line =~ ".*name:.*?($ignore_string).*" ]]; then
			if [[ -n "${match[1]}" ]]; then
				# if the ignored sink was set as the current one, then we default to the first sink
				# technically we will then get to the next one at the end of the script
				# should be no issue, because if there will be no elements, then we throw
				if [[ $current_sink_index == ${#index_array} ]]; then
					current_sink_index=1
				fi
				
				# remove the last element of the array
				shift -p index_array
			fi
		fi
	done < <(pacmd list-sinks | grep -e 'index:' -A 1)

	if [[ ${#index_array} -eq 0 ]]; then
		echo "There are no sinks. Exiting..."
		exit 1
	fi

	target_sink_index=$(( ( $current_sink_index % ${#index_array} ) + 1 ))
	target_sink=${index_array[$target_sink_index]}

	pacmd set-default-sink $target_sink || echo "default sink switch failed"
	pacmd list-sink-inputs | awk '/index:/{print $2}' | xargs -r -I{} pacmd move-sink-input {} $target_sink || echo "sink reroute failed"
}
