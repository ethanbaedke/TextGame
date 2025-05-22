#!/bin/bash

# EXIT CODE: 1 if the party was wiped out in this area

# PROMPT: Vast fantasy plains under a wide sky, golden grasses swaying in the wind, scattered wildflowers and ancient standing stones, soft sunlight, open landscape, ethereal and mystical mood, high detail, fantasy concept art style.
bash src/display-image.sh "images/landscapes/plains.png"

echo
echo "Endless plains stretch to the horizon, covered in golden grasses that sway like waves under a wide, cloud-dappled sky."
echo "Occasional clusters of wildflowers and standing stones break the monotony, whispering of ancient rites and forgotten paths."
read -p "The wind carries the scent of earth and freedom, stirring memories of old battles and roaming spirits."

# Schwartzville quest
schwartzville_quest_progress=$(bash src/data/get-quest-progress.sh schwartzville)
if [ $schwartzville_quest_progress -eq 2 ]; then
    bash src/world/trigger-activity.sh src/world/quests/schwartzville-step-2.sh
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
encounter=$((RANDOM % 2))
encounter=$((encounter + 1))
bash src/world/trigger-activity.sh src/world/encounters/plains-encounter-$encounter.sh
if [ $? -eq 1 ]; then
    exit 1
fi
