#!/bin/bash

# Stores the value of the input STAT_NAME in this scripts exit code

# Exit if character-data does not exist
if [ ! -f "data/character-data.bin" ]; then
    echo "ERROR! $0 called but character-data could not be found."
    exit
fi

case "$1" in
        "CR_STR")
            value=$(dd if=data/character-data.bin bs=1 skip=0 count=1 status=none)
            exit "$value"
            ;;
        "CR_DEX")
            value=$(dd if=data/character-data.bin bs=1 skip=1 count=1 status=none)
            exit "$value"
            ;;
        "CR_INT")
            value=$(dd if=data/character-data.bin bs=1 skip=2 count=1 status=none)
            exit "$value"
            ;;
esac