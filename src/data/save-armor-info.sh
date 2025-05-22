#!/bin/bash

# PARAMS: ARMOR_NAME, DATA_NAME, NEW_VALUE, DATA_NAME, NEW_VALUE, ...
# Sets any amount of DATA_NAME's to NEW_VALUE's on ARMOR_NAME

for ((i=2; i<=$#; i+=2)); do

    # Get the name and value of the passed data
    data_name="${!i}"
    ii=$((i + 1))
    data_value="${!ii}"

    case "$data_name" in
        "BASE_RESISTANCE")
            bash src/data/core/write-byte.sh data/armor/$1-data.bin $data_value 0
            ;;
        "PHYSICAL_RESISTANCE")
            bash src/data/core/write-string.sh data/armor/$1-data.bin $data_value 10 1
            ;;
        "ELEMENTAL_RESISTANCE")
            bash src/data/core/write-string.sh data/armor/$1-data.bin $data_value 10 11
            ;;
        "DISPLAY_NAME")
            bash src/data/core/write-string.sh data/armor/$1-data.bin "$data_value" 30 21
            ;;
    esac
done