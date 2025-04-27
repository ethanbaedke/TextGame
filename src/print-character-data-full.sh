#!/bin/bash

# Prints all character-data

# Exit if character-data does not exist
if [ ! -f "data/character-data.bin" ]; then
    echo "ERROR! $0 called but character-data could not be found."
    exit
fi

cr_str=$(dd if=data/character-data.bin bs=1 skip=0 count=1 status=none)
cr_dex=$(dd if=data/character-data.bin bs=1 skip=1 count=1 status=none)
cr_int=$(dd if=data/character-data.bin bs=1 skip=2 count=1 status=none)
cr_nam=$(dd if=data/character-data.bin bs=1 skip=3 count=30 status=none | tr -d '\0')
cr_col=$(dd if=data/character-data.bin bs=1 skip=33 count=30 status=none | tr -d '\0')

echo
echo "Name: $cr_nam"
echo "Strength: $cr_str"
echo "Dexterity: $cr_dex"
echo "Intelligence: $cr_int"
echo "Favorite Color: $cr_col"