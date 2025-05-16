#!/bin/bash

# EXIT CODE: 1 if the party was wiped out in this area

area_left=0
while [ $area_left -eq 0 ]; do

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

        clear
        party_characters=($(bash src/data/get-party-characters.sh))
        player_display_name=$(bash src/data/get-actor-info.sh ${party_characters[0]} "DISPLAY_NAME")
        leader_display_name=$(bash src/data/get-actor-info.sh max "DISPLAY_NAME")

        bash src/print-dialogue.sh "[You ride into town with the combat squad]"
        bash src/print-dialogue.sh "[*$leader_display_name* looks upon the squad with relief]"
        bash src/print-dialogue.sh "$leader_display_name: I'm glad to see you have all returned safely. Times are changing, you must be more careful."
        bash src/print-dialogue.sh "$leader_display_name: I shall be departing on a journey with *$player_display_name*."
        bash src/print-dialogue.sh "$leader_display_name: I hope to see all of you in good health when I return."

        # Unlock and add max to the party
        bash src/data/unlock-character.sh max
        bash src/add-to-party.sh max
        bash src/data/increment-quest-progress.sh schwartzville

        # Begin progress on max's individual quest
        bash src/data/increment-quest-progress.sh max
        continue
    fi

    options+=("leave")

    bash src/request-selection.sh "${options[@]}"
    selection=$(bash src/data/get-selection.sh)

    case "$selection" in

        "recruit schwartzville")

            clear
            party_characters=($(bash src/data/get-party-characters.sh))
            player_display_name=$(bash src/data/get-actor-info.sh ${party_characters[0]} "DISPLAY_NAME")
            leader_display_name=$(bash src/data/get-actor-info.sh max "DISPLAY_NAME")

            bash src/print-dialogue.sh "[You are taken to the leader of -Schwartzville-]"
            bash src/print-dialogue.sh "Soldier: *$leader_display_name*, this is *$player_display_name*, they have requested your attention."
            bash src/print-dialogue.sh "$player_display_name: *$leader_display_name*, there is a tyrant rising in the southeast. I have come to rally support."
            bash src/print-dialogue.sh "[*$leader_display_name* consideres your proposition]"
            bash src/print-dialogue.sh "$leader_display_name: I believe your cause is worthy, however, I must stay here and protect my town."
            bash src/print-dialogue.sh "$leader_display_name: You see, our combat squad left on patrol this morning and has yet to return. I cannot leave the town defenseless."
            bash src/print-dialogue.sh "$leader_display_name: If you +find the combat squad+ and return with them safely, you will have my blade at your side."
            bash src/print-dialogue.sh "$leader_display_name: They were last seen +patroling the plains+ surrounding this town."

            bash src/data/increment-quest-progress.sh schwartzville
            ;;

        "leave")
            area_left=1
            ;;
    esac

done