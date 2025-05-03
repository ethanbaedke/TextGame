#!/bin/bash

# PARAMS: CHARACTER_NAME

# Exit if the party-data file doesn't exist
if [ ! -f "data/party-data.bin" ]; then
    echo "ERROR! $0 called but data/party-data.bin could not be found."
    exit
fi

# Exit if character-data does not exist
if [ ! -f "data/characters/$1-data.bin" ]; then
    echo "ERROR! $0 called but data/characters/$1-data.bin could not be found."
    exit
fi

party_size=$(dd if=data/party-data.bin bs=1 skip=2 count=1 status=none)

bash src/party/check-party-full.sh

if [ $? -eq 0 ]; then

    # Add the character to the party
    printf "$1" | dd of=data/party-data.bin bs=1 seek=$(((party_size * 10) + 3)) count=10 status=none conv=notrunc
    new_party_size=$((party_size + 1))
    printf "$new_party_size" | dd of=data/party-data.bin bs=1 seek=2 count=10 status=none conv=notrunc

    echo
    bash src/print-character-data-inline.sh "" $1 "CR_NAM" " has been added to the party."
else

    # The party is full, give the user the option to remove a party member
    echo
    echo "Your party is full!"
    echo "Would you like to remove a member from your party?"

    bash src/request-selection.sh "yes" "no"

    if [ $? -eq 1 ]; then
        bash src/party/remove-from-party.sh
        bash src/party/add-to-party.sh $1
    fi
fi