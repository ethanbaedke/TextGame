#!/bin/bash

# PARAMS: CHARACTER_NAME

# Exit if trying to unlock player
if [ "$1" == "player" ]; then
    exit
fi

unlocked_characters=($(bash src/data/get-unlocked-characters.sh))
num_characters_unlocked=($(bash src/data/core/read-byte.sh data/unlocked-character-data.bin 0))

# Exit if the character is already unlocked
for character in ${unlocked_characters[@]}; do
    if [ "$character" == "$1" ]; then
        echo "ERROR! $0 called but character $1 is already unlocked."
        exit
    fi
done

# Add the character to the unlocked character file
byte_offset=$(((num_characters_unlocked * 10) + 1))
bash src/data/core/write-string.sh data/unlocked-character-data.bin "$1" 10 $byte_offset
new_num_characters_unlocked=$((num_characters_unlocked + 1))
bash src/data/core/write-byte.sh data/unlocked-character-data.bin $new_num_characters_unlocked 0

display_name=$(bash src/data/get-character-info.sh $1 "CR_NAM")

echo
echo "$display_name has been unlocked."