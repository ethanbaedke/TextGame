#!/bin/bash

# PARAMS ENCOUNTER_PATH
# EXIT CODE: 1 if the party was knocked out during the encounter

party=$(bash src/data/get-party-characters.sh)
bash src/init-temp-health.sh ${party[@]}

bash $1
if [ $? -eq 1 ]; then
    exit 1
fi

bash src/save-party-temp-health.sh