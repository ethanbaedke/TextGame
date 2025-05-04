#!/bin/bash

# PARAMS: AREA_NAME

# Ensure a directory for the input area exists
bash src/data/verify-directory-existence.sh "src/world/$1"
if [ $? -eq 1 ]; then
    exit 1
fi

# Select a random party character
party_character=($(bash src/data/get-random-party-character.sh))

# Select a random encounter from the input area
individual_encounter=$(find src/world/$1/individual-encounters -maxdepth 1 -type f | shuf -n 1)

bash $individual_encounter "$party_character"