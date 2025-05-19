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
    
    clear
    plainsrunner_display_name=$(bash src/data/get-actor-info.sh plainsrunner "DISPLAY_NAME")
    leader_display_name=$(bash src/data/get-actor-info.sh max "DISPLAY_NAME")

    bash src/print-dialogue.sh "[You hear a rumbling coming from trees on the horizon]"
    bash src/print-dialogue.sh "[A group of panicked riders bursts fourth into the clearing]"
    bash src/print-dialogue.sh "[You see them waving their hands at you, panicked]"
    bash src/print-dialogue.sh "Rider: PLAINSRUNNERS! MOVE!"
    bash src/print-dialogue.sh "[Without a moment to think, you see five furious beasts dart out of the trees, in close pursuit of the riders]"
    bash src/print-dialogue.sh "[As the riders approach, one of the *$plainsrunner_display_name*'s split from the pack and begin dashing toward you]"

    bash src/combat/enter-combat.sh plainsrunner

    # Combat lost
    if [ $? -eq 1 ]; then
        exit 1
    fi

    # Combat won
    bash src/print-dialogue.sh "[The riders circle back, having dealt with the remainder of the *$plainsrunner_display_name*'s]"
    bash src/print-dialogue.sh "Rider: Thanks for helping us out back there! We were in quite a pinch."
    bash src/print-dialogue.sh "Rider: Lets +return to -Schwartzville-+ and report to *$leader_display_name*"

    bash src/data/increment-quest-progress.sh schwartzville
    exit
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
        bash src/print-dialogue.sh "[You have stumbled across plains random encounter 0]"
        ;;
    1)
        bash src/print-dialogue.sh "[You have stumbled across plains random encounter 1]"
        ;;
    2)
        bash src/print-dialogue.sh "[You have stumbled across plains random encounter 2]"
        ;;
esac
