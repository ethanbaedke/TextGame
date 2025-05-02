#!/bin/bash

# PARAMS: CHARACTER_NAME
# Prints all character data on CHARACTER_NAME

# Exit if character-data does not exist
if [ ! -f "data/characters/$1-data.bin" ]; then
    echo "ERROR! $0 called but data/characters/$1-data.bin could not be found."
    exit
fi

bash src/display-image.sh "images/characters/beautiful/$1.png"

cr_str=$(dd if=data/characters/$1-data.bin bs=1 skip=0 count=1 status=none)
cr_dex=$(dd if=data/characters/$1-data.bin bs=1 skip=1 count=1 status=none)
cr_int=$(dd if=data/characters/$1-data.bin bs=1 skip=2 count=1 status=none)
cr_nam=$(dd if=data/characters/$1-data.bin bs=1 skip=3 count=30 status=none | tr -d '\0')
cr_col=$(dd if=data/characters/$1-data.bin bs=1 skip=33 count=30 status=none | tr -d '\0')

echo
echo "Name: $cr_nam"
echo "Strength: $cr_str"
echo "Dexterity: $cr_dex"
echo "Intelligence: $cr_int"
echo "Favorite Color: $cr_col"