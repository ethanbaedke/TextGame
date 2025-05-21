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
        "CHARISMA")
            bash src/data/core/write-byte.sh data/actors/$1-data.bin $data_value 3
            ;;
        "LUCK")
            bash src/data/core/write-byte.sh data/actors/$1-data.bin $data_value 4
            ;;
        "PHYSICAL_RESISTANCE")
            bash src/data/core/write-string.sh data/actors/$1-data.bin "$data_value" 10 5
            ;;
        "ELEMENTAL_RESISTANCE")
            bash src/data/core/write-string.sh data/actors/$1-data.bin "$data_value" 10 15
            ;;
        "MAX_HEALTH")
            bash src/data/core/write-byte.sh data/actors/$1-data.bin $data_value 25
            ;;
        "CURRENT_HEALTH")
            bash src/data/core/write-byte.sh data/actors/$1-data.bin $data_value 26
            ;;
        "TEMP_HEALTH")
            # This is a temporary data slot to track current health while the actor is in combat
            # This way, combat damage is only saved if desired (for characters) and only after combat has finished (doesn't save if combat ends abruptly)
            bash src/data/core/write-byte.sh data/actors/$1-data.bin $data_value 27
            ;;
        "WEAPON")
            bash src/data/verify-file-existence.sh data/weapons/$data_value-data.bin
            if [ $? -eq 1 ]; then
                exit 1
            fi
            bash src/data/core/write-string.sh data/actors/$1-data.bin "$data_value" 10 28
            ;;
        "DISPLAY_NAME")
            bash src/data/core/write-string.sh data/actors/$1-data.bin "$data_value" 30 38
            ;;
        "FAVORITE_COLOR")
            bash src/data/core/write-string.sh data/actors/$1-data.bin "$data_value" 30 68
            ;;
    esac
done