#!/bin/bash

# PARAMS: ARMOR_NAME, STAT_NAME

case "$2" in
        "VALUE")
            value=($(bash src/data/core/read-byte.sh data/armor/$1-data.bin 0))
            echo $value
            ;;
        "BASE_RESISTANCE")
            value=($(bash src/data/core/read-byte.sh data/armor/$1-data.bin 1))
            echo $value
            ;;
        "PHYSICAL_RESISTANCE")
            value=$(bash src/data/core/read-string.sh data/armor/$1-data.bin 10 2)
            echo $value
            ;;
        "ELEMENTAL_RESISTANCE")
            value=$(bash src/data/core/read-string.sh data/armor/$1-data.bin 10 12)
            echo $value
            ;;
        "DISPLAY_NAME")
            value=$(bash src/data/core/read-string.sh data/armor/$1-data.bin 30 22)
            echo $value
            ;;
esac