#!/bin/bash

area="test-area"

rm data/party-data.bin # TEMPORARY, REMOVE WHEN LOADING GAME

bash src/add-to-party.sh player
bash src/add-to-party.sh aidan
bash src/add-to-party.sh aly
bash src/add-to-party.sh ceci

bash src/trigger-individual-encounter.sh "$area"