#!/bin/bash

# PARAMS: pre_string DATA_NAME post_string
# Prints the input DATA_NAME between the pre_string and post_string

# Exit if character-data does not exist
if [ ! -f "data/character-data.bin" ]; then
    echo "ERROR! $0 called but character-data could not be found."
    exit
fi

case "$2" in
        "CR_STR")
            value=$(dd if=data/character-data.bin bs=1 skip=0 count=1 status=none)
            echo "$1$value$3"
            ;;
        "CR_DEX")
            value=$(dd if=data/character-data.bin bs=1 skip=1 count=1 status=none)
            echo "$1$value$3"
            ;;
        "CR_INT")
            value=$(dd if=data/character-data.bin bs=1 skip=2 count=1 status=none)
            echo "$1$value$3"
            ;;
        "CR_NAM")
            value=$(dd if=data/character-data.bin bs=1 skip=3 count=30 status=none | tr -d '\0')
            echo "$1$value$3"
            ;;
        "CR_COL")
            value=$(dd if=data/character-data.bin bs=1 skip=33 count=30 status=none | tr -d '\0')
            echo "$1$value$3"
            ;;
esac