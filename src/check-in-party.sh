#!/bin/bash

# PARAMS: CHARACTER_NAME
# EXIT CODE: 1 if CHARACTER_NAME is in the party and 0 if not

party_size=$(dd if=data/party-data.bin bs=1 skip=0 count=1 status=none)

# Check if the character is in the party
for ((i=1; i<$party_size; i++)); do

    party_member=$(dd if=data/party-data.bin bs=1 skip=$(((i * 10) + 1)) count=10 status=none | tr -d '\0')

    if [ "$party_member" == "$1" ]; then
        exit 1
    fi
done

exit 0