#!/bin/bash

# EXIT CODE: 1 if the party was wiped out in this area

area_left=0
while [ $area_left -eq 0 ]; do

    clear
    bash src/display-image.sh "images/landscapes/schwartzville.png"
    echo
    echo "A tidy village sits nestled among the open plains, its timber-framed homes and cobbled paths radiating quiet industry."
    echo "Smoke drifts lazily from chimneys, and the air hums with the sounds of trade, gossip, and clinking tools."
    echo "Modest yet proud, the villagers thrive between golden fields and the open sky, rooted in tradition and neighborly strength."
    bash src/print-dialogue.sh "[Welcome to -Schwartzville-]"

    options=()

    # Schwartzville quest
    schwartzville_quest_progress=$(bash src/data/get-quest-progress.sh schwartzville)
    if [ $schwartzville_quest_progress -eq 1 ]; then
        options+=("recruit schwartzville")
    elif [ $schwartzville_quest_progress -eq 3 ]; then
        bash src/world/trigger-activity.sh src/world/quests/schwartzville-step-3.sh
        exit $?
    fi

    options+=("visit market")
    options+=("visit tavern")
    options+=("leave")

    bash src/request-selection.sh "${options[@]}"
    selection=$(bash src/data/get-selection.sh)

    case "$selection" in

        "recruit schwartzville")
            bash src/world/trigger-activity.sh src/world/quests/schwartzville-step-1.sh
            exit $?
            ;;

        "visit market")
            bash src/world/market.sh sword hammer bow shirt
            ;;

        "visit tavern")
            bash src/world/tavern.sh
            ;;

        "leave")
            area_left=1
            ;;
    esac

done