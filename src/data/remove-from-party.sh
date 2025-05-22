#!/bin/bash

# PARAMS: CHARACTER_NAME
# EXIT: 0 = success, 1 = fail

party_size=($(bash src/data/get-party-size.sh))

if [ $party_size -eq 1 ]; then
    echo "ERROR: $0 called with 1 member in the party, and party cannot be empty"
    exit 1
fi

# Remove the character from the party
removed=0
for ((i=0; i<$party_size; i++)); do

    byte_offset=$(((i * 10) + 3))
    party_member=($(bash src/data/core/read-string.sh data/party-data.bin 10 $byte_offset))

    # Search for the character's name in the data-file
    if [ $removed -eq 0 ]; then
        if [ "$party_member" == "$1" ]; then
            bash src/data/core/write-null.sh data/party-data.bin 10 $byte_offset
            removed=1
        fi

    # The character's name was found, move subsequent names back one index in the data-file
    else
        ii=$((i - 1))
        byte_offset=$(((ii * 10) + 3))
        bash src/data/core/write-string.sh data/party-data.bin "$party_member" 10 $byte_offset
        byte_offset=$(((i * 10) + 3))
        bash src/data/core/write-null.sh data/party-data.bin 10 $byte_offset
    fi
done

if [ ! $removed -eq 0 ]; then

    # Decrease the party size by one
    new_party_size=$((party_size - 1))
    bash src/data/core/write-byte.sh data/party-data.bin $new_party_size 2

    display_name=$(bash src/data/get-actor-info.sh $1 "DISPLAY_NAME")

    echo
    bash src/print-dialogue.sh "[$display_name has been removed from the party]"
else
    echo "ERROR! $0 called but the character name "$1" could not be found in data/party-data.bin"
    exit 1
fi

exit 0