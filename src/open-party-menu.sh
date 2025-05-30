#!/bin/bash

clear

bash src/data/request-help-menu.sh "PARTY_MENU"

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
selection=$(bash src/data/get-selection.sh)

if [ "$selection" == "yes" ]; then
    echo
    echo "Which party member would you like to inspect?"
    bash src/request-selection.sh ${party_characters[@]}
    selection=$(bash src/data/get-selection.sh)

    bash src/print-character-data-full.sh $selection
fi