#!/bin/bash

if [ ! -t 0 ]; then
    read area_name
else
    echo "ERROR! $0 called but no area piped in."
    exit
fi

# Exit if area description does not exist
if [ ! -f "src/map/describe-$area_name.sh" ]; then
    echo "ERROR! $0 called but src/map/describe-$area_name.sh could not be found."
    exit
fi

echo
bash src/map/describe-$area_name.sh