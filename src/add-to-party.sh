#!/bin/bash

# PARAMS: CHARACTER_NAME
# EXIT: 0 = success, 1 = fail

# Try to add the character to the party
bash src/data/add-to-party.sh $1

case $? in
    0)
        # Party had space
        display_name=$(bash src/data/get-actor-info.sh $1 "DISPLAY_NAME")
        echo
        echo "$display_name has been added to the party."
        ;;
    1)
        # Unknown error
        exit 1
        ;;
    2)
        # The party was full, give the user the option to remove a party member
        echo
        echo "Your party is full!"
        echo "Would you like to remove a member from your party?"

        bash src/request-selection.sh "yes" "no"

        if [ $? -eq 1 ]; then
            bash src/remove-from-party.sh
            bash src/add-to-party.sh $1
        fi
        ;;
esac