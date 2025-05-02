#!/bin/bash

# Exit if the unlocked-character-data file doesn't exist
if [ ! -f "data/unlocked-character-data.bin" ]; then
    echo "ERROR! $0 called but data/unlocked-character-data.bin could not be found."
    exit
fi

num_characters=$(dd if=data/unlocked-character-data.bin bs=1 skip=0 count=1 status=none)

# Iterate all unlocked characters not currently in the party to a list
swapable_characters=()
for ((i=0; i<num_characters; i++)); do

    party_member=$(dd if=data/unlocked-character-data.bin bs=1 skip=$(((i * 10) + 1)) count=10 status=none | tr -d '\0')

    bash src/party/check-in-party.sh $party_member
    
    if [ ! $? -eq 1 ]; then
        swapable_characters+=("$party_member ")
    fi

done

echo
echo "You enter the tavern."

# Leave the tavern if there are no unlocked characters outside the current party
if [ ${#swapable_characters[@]} -eq 0 ]; then
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
bash src/request-selection.sh ${swapable_characters[@]}
selection_ind=$?

# Get the list index of the user's selection
character_ind=$((selection_ind-1))

bash src/party/add-to-party.sh ${swapable_characters[$character_ind]}