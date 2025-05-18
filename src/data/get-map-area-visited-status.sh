#!/bin/bash

# PARAMS: AREA_X AREA_Y
# Prints the visited status of the area to standard output

# Ensure the area is within the bounds of the map
if [ $1 -lt 0 ] || [ $2 -lt 0 ] || [ $1 -ge 5 ] || [ $2 -ge 5 ]; then
    echo "ERROR! $0 called but ($1, $2) is outside the 5x5 confines of the map."
    exit 1
fi

offset=$((($1 * 21) + ($2 * 21 * 16) + 20))
visited_status=$(bash src/data/core/read-byte.sh data/map-data.bin $offset)
echo $visited_status