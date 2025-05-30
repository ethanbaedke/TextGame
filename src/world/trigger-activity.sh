#!/bin/bash

# PARAMS ACTIVITY_PATH
# Activities are encounters or quests
# EXIT CODE: 1 if the party was knocked out during the encounter or quest

if [[ "$1" == *"encounters"* ]]; then
    bash src/data/request-help-menu.sh "TRIGGER_ENCOUNTER"
fi

party=$(bash src/data/get-party-characters.sh)
bash src/init-temp-health.sh ${party[@]}

bash $1
if [ $? -eq 1 ]; then
    exit 1
fi

bash src/save-party-temp-health.sh