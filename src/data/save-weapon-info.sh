#!/bin/bash

# PARAMS: WEAPON_NAME, DATA_NAME, NEW_VALUE, DATA_NAME, NEW_VALUE, ...
# Sets any amount of DATA_NAME's to NEW_VALUE's on WEAPON_NAME

for ((i=2; i<=$#; i+=2)); do

    # Get the name and value of the passed data
    data_name="${!i}"
    ii=$((i + 1))
    data_value="${!ii}"

    case "$data_name" in
        "WP_DAM")
            bash src/data/core/write-byte.sh data/weapons/$1-data.bin $data_value 0
            ;;
        "WP_NAM")
            bash src/data/core/write-string.sh data/weapons/$1-data.bin "$data_value" 30 1
            ;;
    esac
done