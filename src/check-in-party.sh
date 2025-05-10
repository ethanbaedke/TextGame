#!/bin/bash

# PARAMS: CHARACTER_NAME
# EXIT CODE: 1 if CHARACTER_NAME is in the party and 0 if not

characters=($(bash src/data/get-party-characters.sh))

# Check if the character is in the party
for character in ${characters[@]}; do
    if [ "$character" == "$1" ]; then
        exit 1
    fi
done

exit 0