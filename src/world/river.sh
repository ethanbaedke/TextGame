#!/bin/bash

# EXIT CODE: 1 if the party was wiped out in this area

# PROMPT: Fantasy forest river scene, clear flowing water reflecting sunlight through trees, smooth river stones, soft shadows, shimmering fish, magical atmosphere, high detail, fantasy concept art style.
bash src/display-image.sh "images/landscapes/river.png"

echo
echo "The river winds through the landscape like a living ribbon, its waters clear and swift, reflecting the dappled light of the forest canopy."
echo "Smooth stones line the banks."
read -p "The gentle gurgle of flowing water is broken only by the occasional splash of a silver fish or the rustle of unseen creatures watching from the shadows."

# Tyus Estates quest
tyus_estates_quest_progress=$(bash src/data/get-quest-progress.sh tyus-estates)
if [ $tyus_estates_quest_progress -eq 2 ]; then
    bash src/world/trigger-activity.sh src/world/quests/tyus-estates-step-2.sh
    if [ $? -eq 1 ]; then
        exit 1
    else
        exit 0
    fi
fi

# RANDOM ENCOUNTERS

# 1/3 chance
chance=$((RANDOM % 3))

if [ $chance -gt 0 ]; then
    exit
fi

# Start one of the random encounters
encounter=$((RANDOM % 3))
case $encounter in
    0)
        bash src/print-dialogue.sh "[You have stumbled across river random encounter 1]"
        ;;
    1)
        bash src/print-dialogue.sh "[You have stumbled across river random encounter 2]"
        ;;
esac