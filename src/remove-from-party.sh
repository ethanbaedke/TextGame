#!/bin/bash

# PARAMS: CHARACTER_NAME
# EXIT: 0 = success, 1 = fail
# NOTE: If no params are passed, this function asks the user who they would like to remove

# Ask the user who to remove if an input parameter was not used
if [ -z "$1" ]; then

    # Get all characters currently in party
    in_party=($(bash src/data/get-party-characters.sh))

    if [ ${#in_party[@]} -eq 1 ]; then
        echo "ERROR: $0 called with 1 member in the party, and party cannot be empty"
        exit 1
    fi

    # Allow the user to select a character from the list
    echo
    echo "Who would you like to remove from your party?"
    bash src/request-selection.sh ${in_party[@]}
    selection=$(bash src/data/get-selection.sh)

    to_remove=$selection
else
    to_remove=$1
fi

bash src/data/remove-from-party.sh $to_remove

exit 0