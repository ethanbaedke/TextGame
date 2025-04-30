#!/bin/bash

# PARAMS: AREA_NAME

# Exit if area does not exist
if [ ! -d "src/biomes/$1" ]; then
    echo "ERROR! $0 called but src/biomes/$1 could not be found."
    exit
fi

# Ensure the party is not empty
party_size=$(dd if=data/party-data.bin bs=1 skip=0 count=1 status=none)
if [ $party_size -eq 0 ]; then
    echo "ERROR! $0 called but party size is 0."
    exit
fi

# Select a random party member
random_party_index=$((RANDOM % $party_size))
party_member=$(dd if=data/party-data.bin bs=1 skip=$(((random_party_index * 10) + 1)) count=10 status=none | tr -d '\0')

individual_encounter=$(find src/biomes/$1/individual-encounters -maxdepth 1 -type f | shuf -n 1)
bash $individual_encounter "$party_member"