#!/bin/bash

# Add all unlocked characters not currently in the party to a list
unlocked_characters=($(bash src/data/get-unlocked-characters.sh))
non_party_unlocked_characters=()
for character in ${unlocked_characters[@]}; do
    bash src/party/check-in-party.sh $character
    if [ ! $? -eq 1 ]; then
        non_party_unlocked_characters+=("$character ")
    fi
done

echo
echo "You enter the tavern."

# Leave the tavern if there are no unlocked characters outside the current party
if [ ${#non_party_unlocked_characters[@]} -eq 0 ]; then
    echo
    echo "It is deserted, there are no adventurers here."
    echo "You leave the tavern."
    exit
fi

echo "You see some adventurers awaiting desiny's call."
echo "Would you like to add an unlocked character to your party?"
bash src/request-selection.sh "yes" "no"

if [ $? -eq 2 ]; then
    echo
    echo "You leave the tavern."
    exit
fi

# Allow the user to select a character from the list
echo
echo "Who would you like to accompany you on your journey?"
bash src/request-selection.sh ${non_party_unlocked_characters[@]}
selection_ind=$?

# Get the list index of the user's selection
character_ind=$((selection_ind-1))

bash src/party/add-to-party.sh ${non_party_unlocked_characters[$character_ind]}