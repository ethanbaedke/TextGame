#!/bin/bash

# PARAMS: PRE_STRING, CHARACTER_NAME, DATA_NAME, POST_STRING
# Prints DATA_NAME from CHARACTER_NAME between PRE_STRING and POST_STRING

# Exit if character-data does not exist
if [ ! -f "data/characters/$2-data.bin" ]; then
    echo "ERROR! $0 called but data/characters/$2-data.bin could not be found."
    exit
fi

case "$3" in
        "CR_STR")
            value=$(dd if=data/characters/$2-data.bin bs=1 skip=0 count=1 status=none)
            echo "$1$value$4"
            ;;
        "CR_DEX")
            value=$(dd if=data/characters/$2-data.bin bs=1 skip=1 count=1 status=none)
            echo "$1$value$4"
            ;;
        "CR_INT")
            value=$(dd if=data/characters/$2-data.bin bs=1 skip=2 count=1 status=none)
            echo "$1$value$4"
            ;;
        "CR_NAM")
            value=$(dd if=data/characters/$2-data.bin bs=1 skip=3 count=30 status=none | tr -d '\0')
            echo "$1$value$4"
            ;;
        "CR_COL")
            value=$(dd if=data/characters/$2-data.bin bs=1 skip=33 count=30 status=none | tr -d '\0')
            echo "$1$value$4"
            ;;
esac