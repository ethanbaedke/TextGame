#!/bin/bash

# PARAMS: ARMOR_NAME, STAT_NAME

case "$2" in
        "BASE_RESISTANCE")
            value=($(bash src/data/core/read-byte.sh data/armor/$1-data.bin 0))
            echo $value
            ;;
        "PHYSICAL_RESISTANCE")
            value=$(bash src/data/core/read-string.sh data/armor/$1-data.bin 10 1)
            echo $value
            ;;
        "ELEMENTAL_RESISTANCE")
            value=$(bash src/data/core/read-string.sh data/armor/$1-data.bin 10 11)
            echo $value
            ;;
        "DISPLAY_NAME")
            value=$(bash src/data/core/read-string.sh data/armor/$1-data.bin 30 21)
            echo $value
            ;;
esac