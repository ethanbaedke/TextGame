#!/bin/bash

# Exit if the party-data file doesn't exist
if [ ! -f "data/party-data.bin" ]; then
    echo "ERROR! $0 called but data/party-data.bin could not be found."
    exit
fi

echo
echo "Members in your party..."

party_size=$(dd if=data/party-data.bin bs=1 skip=2 count=1 status=none)
party_members=()

for ((i=0; i<$party_size; i++)); do
    party_member=$(dd if=data/party-data.bin bs=1 skip=$(((i * 10) + 3)) count=10 status=none | tr -d '\0')
    party_members+=("$party_member ")
    bash src/print-character-data-inline.sh "" $party_member "CR_NAM" ""
done

echo
echo "Inspect a particular party member?"
bash src/request-selection.sh "yes" "no"

if [ $? -eq 1 ]; then
    echo
    echo "Which party member would you like to inspect?"
    bash src/request-selection.sh ${party_members[@]}
    selection_ind=$?

    # Get the list index of the user's selection
    character_ind=$((selection_ind-1))

    bash src/print-character-data-full.sh ${party_members[$character_ind]}
fi