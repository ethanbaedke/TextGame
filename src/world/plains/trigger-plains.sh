#!/bin/bash

# PARAMS: TRIGGERER_CHARACTER_NAME
# EXIT CODE: 1 if the trigger wiped out the party

# Schwartzville quest
schwartzville_quest_progress=$(bash src/data/get-quest-progress.sh schwartzville)
if [ $schwartzville_quest_progress -eq 2 ]; then
    
    party_characters=$(bash src/data/get-party-characters.sh)
    leader_display_name=$(bash src/data/get-actor-info.sh ${party_characters[0]} "DISPLAY_NAME")

    bash src/print-inaudible-line.sh "You hear it before you see it—shouting. Panic. The pounding of hooves."
    bash src/print-inaudible-line.sh "You sprint toward the sound, brush whipping your legs. Suddenly, the grass parts."
    bash src/print-inaudible-line.sh "The combat squad—dust-covered and bloodied—rides hard across the open field, shouting over their shoulders."
    bash src/print-audible-line.sh "Squad Member" "PLAINSRUNNERS! MOVE!"
    bash src/print-inaudible-line.sh "Behind them, lean shapes streak through the grass, fast and hungry. Their long limbs and jagged teeth shimmer with spit and sun."
    bash src/print-inaudible-line.sh "Two jackals break from the pack, locking eyes with you. Snarling."
    bash src/print-audible-line.sh "$leader_display_name" "Oh no you don’t."
    bash src/print-inaudible-line.sh "They veer, howling, and charge straight at you."

    bash src/combat/enter-combat.sh plainsrunner

    # Combat lost
    if [ $? -eq 1 ]; then

        bash src/print-inaudible-line.sh "Your vision blurs. The world spins. You hear shouting as the squad doubles back."
        bash src/print-audible-line.sh "Squad Member" "Soldier's down! Get him out of here—NOW!"
        bash src/print-inaudible-line.sh "The jackal retreats as blades flash. Darkness presses in."

        exit 1
    fi

    # Combat won
    bash src/print-audible-line.sh "Squad Member" "By the gods… remind me never to bet against you."
    bash src/print-inaudible-line.sh "You nod, catching your breath. The path home is clear."

    bash src/data/increment-quest-progress.sh schwartzville
fi