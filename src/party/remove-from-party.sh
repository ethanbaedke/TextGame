#!/bin/bash

# PARAMS: CHARACTER_NAME
# NOTE: If no params are passed, this function asks the user who they would like to remove

# Exit if the party-data file doesn't exist
if [ ! -f "data/party-data.bin" ]; then
    echo "ERROR! $0 called but data/party-data.bin could not be found."
    exit
fi

party_size=$(dd if=data/party-data.bin bs=1 skip=2 count=1 status=none)

# Ask the user who to remove if an input parameter was not used
if [ -z "$1" ]; then

    # Get all characters currently in party excluding the player
    in_party=()
    for ((i=1; i<$party_size; i++)); do
        party_member=$(dd if=data/party-data.bin bs=1 skip=$(((i * 10) + 3)) count=10 status=none | tr -d '\0')
        in_party+=("$party_member ")
    done

    # Allow the user to select a character from the list
    echo
    echo "Who would you like to remove from your party?"
    bash src/request-selection.sh ${in_party[@]}
    selection_ind=$?

    # Get the list index of the user's selection
    character_ind=$((selection_ind-1))

    to_remove_with_space=${in_party[$character_ind]}
    to_remove="${to_remove_with_space::-1}"
else
    to_remove=$1
fi

# Remove the character from the party
removed=0
for ((i=1; i<$party_size; i++)); do

    party_member=$(dd if=data/party-data.bin bs=1 skip=$(((i * 10) + 3)) count=10 status=none | tr -d '\0')

    # Search for the character's name in the data-file
    if [ $removed -eq 0 ]; then
        if [ "$party_member" == "$to_remove" ]; then
            dd if=/dev/zero of=data/party-data.bin bs=1 seek=$(((i * 10) + 3)) count=10 status=none conv=notrunc
            removed=1
        fi

    # The character's name was found, move subsequent names back one index in the data-file
    else
        ii=$((i - 1))
        printf "$party_member" | dd of=data/party-data.bin bs=1 seek=$(((ii * 10) + 3)) count=10 status=none conv=notrunc
        dd if=/dev/zero of=data/party-data.bin bs=1 seek=$(((i * 10) + 3)) count=10 status=none conv=notrunc
    fi
done

if [ ! $removed -eq 0 ]; then

    # Decrease the party size by one
    new_party_size=$((party_size - 1))
    printf "$new_party_size" | dd of=data/party-data.bin bs=1 seek=2 count=1 status=none conv=notrunc

    echo
    bash src/print-character-data-inline.sh "" $to_remove "CR_NAM" " has been removed from the party."
else
    echo "ERROR! $0 called but the character name "$to_remove" could not be found in data/party-data.bin"
fi