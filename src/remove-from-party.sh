#!/bin/bash

# PARAMS: CHARACTER_NAME
# NOTE: If no params are passed, this function asks the user who they would like to remove

# Ask the user who to remove if an input parameter was not used
if [ -z "$1" ]; then

    # Get all characters currently in party excluding the player
    in_party=($(bash src/data/get-party-non-player-characters.sh))

    # Allow the user to select a character from the list
    echo
    echo "Who would you like to remove from your party?"
    bash src/request-selection.sh ${in_party[@]}
    selection_ind=$?

    # Get the list index of the user's selection
    character_ind=$((selection_ind-1))

    to_remove=${in_party[$character_ind]}
else
    to_remove=$1
fi

bash src/data/remove-from-party.sh $to_remove