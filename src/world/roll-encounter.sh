#!/bin/bash

# PARAMS: AREA_NAME
# EXIT CODE: 1 if there was an encounter and the party was wiped out


# Ensure a directory for the input area exists
bash src/data/verify-directory-existence.sh "src/world/$1"
if [ $? -eq 1 ]; then
    exit 1
fi

# Chance for encounter to happen
chance=$((RANDOM % 3))
chance=0 # REMOVE LATER, THIS GURENTEES THE ROLL TO HIT FOR TESTING PURPOSES
if [ ! $chance -eq 0 ]; then
    exit
fi

# Select a random party character
party_character=($(bash src/data/get-random-party-character.sh))

bash src/world/$1/trigger-$1.sh $party_character

if [ $? -eq 1 ]; then
    exit 1
fi