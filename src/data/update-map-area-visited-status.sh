#!/bin/bash

# PARAMS: AREA_X AREA_Y VISITED_STATUS
# Updates the area's status to the input status ONLY IF it is greater than the current status (cannot "unlearn" of an area)

# Quietly discard if the area is outside the map
if [ $1 -lt 0 ] || [ $2 -lt 0 ] || [ $1 -ge 5 ] || [ $2 -ge 5 ]; then
    exit
fi

visited_status=$(bash src/data/get-map-area-visited-status.sh $1 $2)

if [ $visited_status -lt $3 ]; then
    offset=$((($1 * 21) + ($2 * 21 * 16) + 20))
    bash src/data/core/write-byte.sh data/map-data.bin "$3" $offset
fi