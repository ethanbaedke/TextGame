#!/bin/bash

# PARAMS: CHARACTER_NAME
# EXIT: 0 = success, 1 = fail, 2 = party-full

# Ensure a file exists for the input character
bash src/data/verify-file-existence.sh data/characters/$1-data.bin
if [ $? -eq 1 ]; then
    exit 1
fi

party_size=($(bash src/data/get-party-size.sh))

# Is the party full?
if [ $party_size -lt 4 ]; then

    # The party has space, add the characters name and increment the party size
    bash src/data/core/write-string.sh data/party-data.bin $1 10 $(((party_size * 10) + 3))
    bash src/data/core/write-byte.sh data/party-data.bin $((party_size + 1)) 2
    exit 0
else
    # The party was full
    exit 2
fi