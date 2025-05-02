#!/bin/bash

# PARAMS: CHARACTER_NAME

FILE_SIZE=41 # Holds 1 byte for how many characters are in the party and 4 character names at 10 bytes each

# Create the party-data file if it doesn't exist
if [ ! -f "data/party-data.bin" ]; then
    dd if=/dev/zero of=data/party-data.bin bs=1 count="$FILE_SIZE" status=none
    printf "0" | dd of=data/party-data.bin bs=1 seek=0 count="$FILE_SIZE" status=none conv=notrunc
fi

# Exit if character-data does not exist
if [ ! -f "data/characters/$1-data.bin" ]; then
    echo "ERROR! $0 called but data/characters/$1-data.bin could not be found."
    exit
fi

party_size=$(dd if=data/party-data.bin bs=1 skip=0 count=1 status=none)

bash src/check-party-full.sh

if [ $? -eq 0 ]; then

    # Add the character to the party
    printf "$1" | dd of=data/party-data.bin bs=1 seek=$(((party_size * 10) + 1)) count="$FILE_SIZE" status=none conv=notrunc
    new_party_size=$((party_size + 1))
    printf "$new_party_size" | dd of=data/party-data.bin bs=1 seek=0 count="$FILE_SIZE" status=none conv=notrunc

    echo
    bash src/print-character-data-inline.sh "" $1 "CR_NAM" " has been added to the party."
else

    # The party is full
    echo "ERROR! $0 called but the party is full"
fi