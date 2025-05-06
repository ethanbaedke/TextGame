#!/bin/bash

echo
echo "Members in your party..."

party_characters=($(bash src/data/get-party-characters.sh))

for character in ${party_characters[@]}; do
    display_name=$(bash src/data/get-actor-info.sh $character "DISPLAY_NAME")
    echo "$display_name"
done

echo
echo "Inspect a particular party member?"
bash src/request-selection.sh "yes" "no"

if [ $? -eq 1 ]; then
    echo
    echo "Which party member would you like to inspect?"
    bash src/request-selection.sh ${party_characters[@]}
    selection_ind=$?

    # Get the list index of the user's selection
    character_ind=$((selection_ind-1))

    bash src/print-character-data-full.sh ${party_characters[$character_ind]}
fi