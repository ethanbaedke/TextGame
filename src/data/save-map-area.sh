#!/bin/bash

# PARAMS: MAP_X MAP_Y AREA_NAME
# NOTE: Map coordinates are 0-indexed

offset=$((($1 * 20) + ($2 * 20 * 16)))
bash src/data/core/write-string.sh data/map-data.bin "$3" 20 $offset