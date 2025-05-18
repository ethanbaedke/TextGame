#!/bin/bash

# PARAMS: MAP_X MAP_Y AREA_NAME
# NOTE: Map coordinates are 0-indexed

offset=$((($1 * 21) + ($2 * 21 * 16)))
bash src/data/core/write-string.sh data/map-data.bin "$3" 20 $offset