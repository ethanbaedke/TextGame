#!/bin/bash

# PARAMS: WEAPON_NAME, DATA_NAME, NEW_VALUE, DATA_NAME, NEW_VALUE, ...
# Sets any amount of DATA_NAME's to NEW_VALUE's on WEAPON_NAME

for ((i=2; i<=$#; i+=2)); do

    # Get the name and value of the passed data
    data_name="${!i}"
    ii=$((i + 1))
    data_value="${!ii}"

    case "$data_name" in
        "VALUE")
            bash src/data/core/write-byte.sh data/weapons/$1-data.bin $data_value 0
            ;;
        "DAMAGE")
            bash src/data/core/write-byte.sh data/weapons/$1-data.bin $data_value 1
            ;;
        "PHYSICAL_TYPE")
            bash src/data/core/write-string.sh data/weapons/$1-data.bin $data_value 10 2
            ;;
        "ELEMENTAL_TYPE")
            bash src/data/core/write-string.sh data/weapons/$1-data.bin $data_value 10 12
            ;;
        "DISPLAY_NAME")
            bash src/data/core/write-string.sh data/weapons/$1-data.bin "$data_value" 30 22
            ;;
    esac
done