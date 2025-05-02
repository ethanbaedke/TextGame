#!/bin/bash

# PARAMS: CHARACTER_NAME

# Exit if the unlocked-character-data file doesn't exist
if [ ! -f "data/unlocked-character-data.bin" ]; then
    echo "ERROR! $0 called but data/unlocked-character-data.bin could not be found."
    exit
fi

# Exit if character-data for CHARACTER_NAME does not exist
if [ ! -f "data/characters/$1-data.bin" ]; then
    echo "ERROR! $0 called but data/characters/$1-data.bin could not be found."
    exit
fi

num_characters_unlocked=$(dd if=data/unlocked-character-data.bin bs=1 skip=0 count=1 status=none)

# Add the character to the party
printf "$1" | dd of=data/unlocked-character-data.bin bs=1 seek=$(((num_characters_unlocked * 10) + 1)) count=10 status=none conv=notrunc
new_num_characters_unlocked=$((num_characters_unlocked + 1))
printf "$new_num_characters_unlocked" | dd of=data/unlocked-character-data.bin bs=1 seek=0 count=1 status=none conv=notrunc

echo
bash src/print-character-data-inline.sh "" $1 "CR_NAM" " has been unlocked."