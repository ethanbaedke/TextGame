#!/bin/bash

# PARAMS: MAP_X MAP_Y
# Prints the name of the area at (MAP_X, MAP_Y) to standard output
# NOTE: Map coordinates are 0-indexed

offset=$((($1 * 20) + ($2 * 20 * 16)))
area_name=$(bash src/data/core/read-string.sh data/map-data.bin 20 $offset)
echo $area_name