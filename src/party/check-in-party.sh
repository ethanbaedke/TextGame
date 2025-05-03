#!/bin/bash

# PARAMS: CHARACTER_NAME
# EXIT CODE: 1 if CHARACTER_NAME is in the party and 0 if not

# Exit if the party-data file doesn't exist
if [ ! -f "data/party-data.bin" ]; then
    echo "ERROR! $0 called but data/party-data.bin could not be found."
    exit
fi

party_size=$(dd if=data/party-data.bin bs=1 skip=2 count=1 status=none)

# Check if the character is in the party
for ((i=1; i<$party_size; i++)); do

    party_member=$(dd if=data/party-data.bin bs=1 skip=$(((i * 10) + 3)) count=10 status=none | tr -d '\0')

    if [ "$party_member" == "$1" ]; then
        exit 1
    fi
done

exit 0