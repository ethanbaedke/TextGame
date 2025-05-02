#!/bin/bash

# PIPE-INPUT: AREA_NAME

if [ ! -t 0 ]; then
    read area_name
else
    echo "ERROR! $0 called but no area piped in."
    exit
fi

# Exit if area folder does not exist
if [ ! -d "src/world/map/$area_name" ]; then
    echo "ERROR! $0 called but the directory src/world/map/$area_name could not be found."
    exit
fi

# Exit if area description does not exist
if [ ! -f "src/world/map/$area_name/describe-$area_name.sh" ]; then
    echo "ERROR! $0 called but the file src/world/map/describe-$area_name.sh could not be found."
    exit
fi

echo
bash src/world/map/$area_name/describe-$area_name.sh