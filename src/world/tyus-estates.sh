#!/bin/bash

# EXIT CODE: 1 if the party was wiped out in this area

area_left=0
while [ $area_left -eq 0 ]; do

    bash src/display-image.sh "images/landscapes/tyus-estates.png"
    echo
    echo "Rising from the plains like a jewel in the grass, the upper-class settlement boasts elegant stone manors, manicured gardens, and wrought iron gates."
    echo "Decorative banners flutter in the breeze, and finely dressed citizens stroll along polished walkways beneath carefully planted trees."
    echo "Though serene and refined, the air carries a sense of quiet vigilance."
    bash src/print-dialogue.sh "[Welcome to the -Tyus Estates-]"

    options=()

    # Tyus Estates quest
    tyus_estates_quest_progress=$(bash src/data/get-quest-progress.sh tyus-estates)
    if [ $tyus_estates_quest_progress -eq 1 ]; then
        options+=("recruit the tyus estates")
    elif [ $tyus_estates_quest_progress -eq 3 ]; then
        bash src/world/trigger-activity.sh src/world/quests/tyus-estates-step-3.sh
        if [ $? -eq 1 ]; then
            exit 1
        else
            exit 0
        fi
    fi

    options+=("leave")

    bash src/request-selection.sh "${options[@]}"
    selection=$(bash src/data/get-selection.sh)

    case "$selection" in

        "recruit the tyus estates")
            bash src/world/trigger-activity.sh src/world/quests/tyus-estates-step-1.sh
            if [ $? -eq 1 ]; then
                exit 1
            else
                exit 0
            fi
            ;;

        "leave")
            area_left=1
            ;;
    esac

done