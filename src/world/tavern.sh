#!/bin/bash

clear

# Add all unlocked characters not currently in the party to a list
unlocked_characters=($(bash src/data/get-unlocked-characters.sh))
non_party_unlocked_characters=()
for character in ${unlocked_characters[@]}; do
    bash src/check-in-party.sh $character
    if [ ! $? -eq 1 ]; then
        non_party_unlocked_characters+=("$character ")
    fi
done

bash src/print-dialogue.sh "[Your party enters the tavern]"

# Leave the tavern if there are no unlocked characters outside the current party
if [ ${#non_party_unlocked_characters[@]} -eq 0 ]; then
    bash src/print-dialogue.sh "[It is completely deserted, there are no adventurers here]"
    exit
fi

bash src/print-dialogue.sh "[You notice some adventurers awaiting desiny's call]"
bash src/print-dialogue.sh "[Would you like to add an unlocked character to your party?]"
bash src/request-selection.sh "yes" "no"
selection=$(bash src/data/get-selection.sh)

if [ "$selection" == "no" ]; then
    bash src/print-dialogue.sh "[You leave the tavern]"
    exit
fi

# Allow the user to select a character from the list
bash src/print-dialogue.sh "[Who shall accompany your party on their journey]"
bash src/request-selection.sh ${non_party_unlocked_characters[@]}
selection=$(bash src/data/get-selection.sh)

bash src/add-to-party.sh $selection