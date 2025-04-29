#!/bin/bash

# PARAMS: CHARACTER_NAME

FILE_SIZE=41 # Holds 1 byte for how many characters are in the party and 4 character names at 10 bytes each

# Create the party-data file if it doesn't exist
if [ ! -f "data/party-data.bin" ]; then
    dd if=/dev/zero of=data/party-data.bin bs=1 count="$FILE_SIZE" status=none
    printf "0" | dd of=data/party-data.bin bs=1 seek=0 count="$FILE_SIZE" status=none conv=notrunc
fi

party_size=$(dd if=data/party-data.bin bs=1 skip=0 count=1 status=none)

# Remove the character from the party
removed=0
for ((i=1; i<$party_size; i++)); do

    party_member=$(dd if=data/party-data.bin bs=1 skip=$(((i * 10) + 1)) count=10 status=none | tr -d '\0')

    # Search for the character's name in the data-file
    if [ $removed -eq 0 ]; then
        if [ "$party_member" == "$1" ]; then
            dd if=/dev/zero of=data/party-data.bin bs=1 seek=$(((i * 10) + 1)) count=10 status=none conv=notrunc
            removed=1
        fi

    # The character's name was found, move subsequent names back one index in the data-file
    else
        ii=$((i - 1))
        printf "$party_member" | dd of=data/party-data.bin bs=1 seek=$(((ii * 10) + 1)) count=10 status=none conv=notrunc
        dd if=/dev/zero of=data/party-data.bin bs=1 seek=$(((i * 10) + 1)) count=10 status=none conv=notrunc
    fi
done

if [ ! $removed -eq 0 ]; then

    # Decrease the party size by one
    new_party_size=$((party_size - 1))
    printf "$new_party_size" | dd of=data/party-data.bin bs=1 seek=0 count=1 status=none conv=notrunc

    echo
    bash src/print-character-data-inline.sh "" $1 "CR_NAM" " has been removed from the party."
else
    echo "ERROR! $0 called but the character name "$1" could not be found in data/party-data.bin"
fi