#!/bin/bash

# TYUS ESTATES
# PROMPT: Elegant upper-class fantasy settlement on grassy plains, grand stone manors with ornate details, manicured gardens, wrought iron fences, decorative banners, well-dressed people walking tree-lined paths, warm afternoon light, refined and serene atmosphere, high detail, fantasy concept art style.

# EXIT CODE: 1 if the party was knocked out in this area

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

        clear
        party_characters=($(bash src/data/get-party-characters.sh))
        player_display_name=$(bash src/data/get-actor-info.sh ${party_characters[0]} "DISPLAY_NAME")
        leader_display_name=$(bash src/data/get-actor-info.sh liberty "DISPLAY_NAME")
        bandit_display_name=$(bash src/data/get-actor-info.sh bandit "DISPLAY_NAME")

        bash src/print-dialogue.sh "[You return to *$leader_display_name*]"
        bash src/print-dialogue.sh "$player_display_name: I have defeated the *$bandit_display_name's* dwelling in the -Bandit Camp- south of here."
        bash src/print-dialogue.sh "$leader_display_name: As promised, I shall depart with you. Let us go."

        bash src/data/unlock-character.sh liberty
        bash src/add-to-party.sh liberty
        bash src/data/increment-quest-progress.sh tyus-estates

        # Begin progress on liberty's individual quest
        bash src/data/increment-quest-progress.sh liberty
        continue
    fi

    options+=("leave")

    bash src/request-selection.sh "${options[@]}"
    selection=$(bash src/data/get-selection.sh)

    case "$selection" in

        "recruit the tyus estates")

            clear
            party_characters=($(bash src/data/get-party-characters.sh))
            player_display_name=$(bash src/data/get-actor-info.sh ${party_characters[0]} "DISPLAY_NAME")
            leader_display_name=$(bash src/data/get-actor-info.sh liberty "DISPLAY_NAME")

            bash src/print-dialogue.sh "[You are taken to the leader of the -Tyus Estates-]"
            bash src/print-dialogue.sh "Queensguard: *$leader_display_name*, there is an *$player_display_name* here for you."
            bash src/print-dialogue.sh "$player_display_name: *$leader_display_name*, there is a tyrant rising in the southeast. I have come to rally support."
            bash src/print-dialogue.sh "[*$leader_display_name* consideres your proposition]"
            bash src/print-dialogue.sh "$leader_display_name: As honored as I would be to help you in such a noble cause, we have problems of our own."
            bash src/print-dialogue.sh "$leader_display_name: The -Tyus Estates- academy has been educating the youth of the southern town of -Linksburg- for decades."
            bash src/print-dialogue.sh "$leader_display_name: Recently, -Bandits- have set up camp on the river south, blocking the route between the -Tyus Estates- and -Linksburg-."
            bash src/print-dialogue.sh "$leader_display_name: If you +take out the bandits on the river south of the -Tyus Estates-+, I will join you in your cause."

            bash src/data/increment-quest-progress.sh tyus-estates
            ;;

        "leave")
            area_left=1
            ;;
    esac

done