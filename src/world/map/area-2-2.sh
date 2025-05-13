#!/bin/bash

# SCHWARTZVILLE

# PROMPT: Fantasy middle-class human village on open plains, timber-framed houses with thatched and tiled roofs, cobblestone streets, golden grass fields in the distance, smoke rising from chimneys, people working and talking, warm lighting, grounded fantasy atmosphere, high detail, fantasy concept art style.

bash src/display-image.sh "images/landscapes/schwartzville.png"

echo "A tidy village sits nestled among the open plains, its timber-framed homes and cobbled paths radiating quiet industry."
echo "Smoke drifts lazily from chimneys, and the air hums with the sounds of trade, gossip, and clinking tools."
echo "Modest yet proud, the villagers thrive between golden fields and the open sky, rooted in tradition and neighborly strength."

bash src/await-continuation.sh

echo
echo "Welcome to Schwartzville."

options=()

# Main quest
main_quest_progress=$(bash src/data/get-quest-progress.sh main)
if [ $main_quest_progress -eq 2 ]; then
    options+=("visit smithy")
fi

options+=("leave")

bash src/request-selection.sh "${options[@]}"
selection=$(bash src/data/get-selection.sh)

case "$selection" in
    "visit smithy")
        party_characters=$(bash src/data/get-party-characters.sh)
        leader_display_name=$(bash src/data/get-actor-info.sh ${party_characters[0]} "DISPLAY_NAME")

        echo
        bash src/print-inaudible-line.sh "You sprint across sunlit paths and packed dirt roads, heart pounding. Townsfolk glance up from their morning routines as you barrel past."
        bash src/print-inaudible-line.sh "You skid to a stop behind the blue-roofed inn, catching your breath. The air smells of soot and oil."
        bash src/print-inaudible-line.sh "An old smithy, half-collapsed and abandoned, stands quietly in the shade."
        bash src/print-inaudible-line.sh "Inside, a few figures turn to face you—hooded, serious. At their center, the man from the beach."
        bash src/print-audible-line.sh "Mysterious Stranger" "Right on time. Barely."
        bash src/print-audible-line.sh "$leader_display_name" "Depends on your definition of \"time\"..."
        bash src/print-audible-line.sh "Mysterious Stranger" "I’ll keep this simple, $leader_display_name. The southeast is falling. Villages are being crushed or conscripted. We’re lighting a fire on the way there."
        bash src/print-inaudible-line.sh "He unfolds a worn map on the anvil."
        bash src/print-audible-line.sh "Mysterious Stranger" "Your path takes you through the heartlands. As many towns, cities, and outposts as you can reach. Convince them. Rally them. Warn them."
        bash src/print-audible-line.sh "$leader_display_name" "That’s… a lot of walking."
        bash src/print-audible-line.sh "Mysterious Stranger" "And talking. To people in power. Start with the ones here in Schwartzville. Win them to our side, and the others may follow."
        bash src/print-inaudible-line.sh "He steps back, eyes sharp."
        bash src/print-audible-line.sh "Mysterious Stranger" "It’s your choice, $leader_display_name. But the longer we wait, the more ground the tyrant gains."
        bash src/print-inaudible-line.sh "He hands you the map."
        bash src/print-audible-line.sh "Mysterious Stranger" "Good luck. We’ll be watching."

        bash src/data/increment-quest-progress.sh main
        ;;
esac