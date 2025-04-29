#!/bin/bash

# PARAMS: CHARACTER_NAME

# Exit if character-data does not exist
if [ ! -f "data/characters/$1-data.bin" ]; then
    echo "ERROR! $0 called but data/characters/$1-data.bin could not be found."
    exit
fi

echo
bash src/print-character-data-inline.sh "" "$1" CR_NAM " was hit with $0!"