#!/bin/bash

# PARAMS: WEAPON_NAME, STAT_NAME

case "$2" in
        "WP_DAM")
            value=($(bash src/data/core/read-byte.sh data/weapons/$1-data.bin 0))
            echo $value
            ;;
        "WP_NAM")
            value=$(bash src/data/core/read-string.sh data/weapons/$1-data.bin 30 1)
            echo $value
            ;;
esac