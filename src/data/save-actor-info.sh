#!/bin/bash

# PARAMS: CHARACTER_NAME, DATA_NAME, NEW_VALUE, DATA_NAME, NEW_VALUE, ...
# Sets any amount of DATA_NAME's to NEW_VALUE's on CHARACTER_NAME

for ((i=2; i<=$#; i+=2)); do

    # Get the name and value of the passed data
    data_name="${!i}"
    ii=$((i + 1))
    data_value="${!ii}"

    case "$data_name" in
        "STRENGTH")
            bash src/data/core/write-byte.sh data/actors/$1-data.bin $data_value 0
            ;;
        "DEXTERITY")
            bash src/data/core/write-byte.sh data/actors/$1-data.bin $data_value 1
            ;;
        "INTELLIGENCE")
            bash src/data/core/write-byte.sh data/actors/$1-data.bin $data_value 2
            ;;
        "SPEED")
            bash src/data/core/write-byte.sh data/actors/$1-data.bin $data_value 3
            ;;
        "DISPLAY_NAME")
            bash src/data/core/write-string.sh data/actors/$1-data.bin "$data_value" 30 4
            ;;
        "FAVORITE_COLOR")
            bash src/data/core/write-string.sh data/actors/$1-data.bin "$data_value" 30 34
            ;;
        "CR_WEP")
            bash src/data/verify-file-existence.sh data/weapons/$data_value-data.bin
            if [ $? -eq 1 ]; then
                exit 1
            fi
            bash src/data/core/write-string.sh data/actors/$1-data.bin "$data_value" 10 64
            ;;
    esac
done