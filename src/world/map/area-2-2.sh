#!/bin/bash

# SCHWARTZVILLE

# PROMPT: Fantasy middle-class human village on open plains, timber-framed houses with thatched and tiled roofs, cobblestone streets, golden grass fields in the distance, smoke rising from chimneys, people working and talking, warm lighting, grounded fantasy atmosphere, high detail, fantasy concept art style.

echo
echo "A tidy village sits nestled among the open plains, its timber-framed homes and cobbled paths radiating quiet industry."
echo "Smoke drifts lazily from chimneys, and the air hums with the sounds of trade, gossip, and clinking tools."
echo "Modest yet proud, the villagers thrive between golden fields and the open sky, rooted in tradition and neighborly strength."

bash src/await-continuation.sh

area_left=0
while [ $area_left -eq 0 ]; do

    bash src/display-image.sh "images/landscapes/schwartzville.png"
    echo
    echo "Welcome to Schwartzville."

    options=()

    # Main quest
    main_quest_progress=$(bash src/data/get-quest-progress.sh main)
    if [ $main_quest_progress -eq 2 ]; then
        options+=("visit smithy")
    fi

    # Schwartzville quest
    schwartzville_quest_progress=$(bash src/data/get-quest-progress.sh schwartzville)
    if [ $schwartzville_quest_progress -eq 1 ]; then
        options+=("recruit schwartzville")
    elif [ $schwartzville_quest_progress -eq 3 ]; then
        options+=("speak with maximus")
    fi

    options+=("leave")

    bash src/request-selection.sh "${options[@]}"
    selection=$(bash src/data/get-selection.sh)
    echo $selection

    case "$selection" in

        "visit smithy")
            party_characters=$(bash src/data/get-party-characters.sh)
            leader_display_name=$(bash src/data/get-actor-info.sh ${party_characters[0]} "DISPLAY_NAME")

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
            bash src/data/increment-quest-progress.sh luceborough
            bash src/data/increment-quest-progress.sh rodmont
            bash src/data/increment-quest-progress.sh bakerhurst
            bash src/data/increment-quest-progress.sh sharps-hollow
            bash src/data/increment-quest-progress.sh seltzham
            bash src/data/increment-quest-progress.sh lawscrest
            bash src/data/increment-quest-progress.sh gunderhaven
            bash src/data/increment-quest-progress.sh coulterstone
            bash src/data/increment-quest-progress.sh hughesalot
            bash src/data/increment-quest-progress.sh grossmans-rivera
            bash src/data/increment-quest-progress.sh wrightmoor
            bash src/data/increment-quest-progress.sh tyus-estates
            bash src/data/increment-quest-progress.sh nordstead
            bash src/data/increment-quest-progress.sh kavalieros-ridge
            bash src/data/increment-quest-progress.sh schwartzville
            bash src/data/increment-quest-progress.sh linksburg
            ;;

        "recruit schwartzville")
            party_characters=$(bash src/data/get-party-characters.sh)
            leader_display_name=$(bash src/data/get-actor-info.sh ${party_characters[0]} "DISPLAY_NAME")

            bash src/print-inaudible-line.sh "The capital of Schwartzville stretches out before you: rows of sturdy homes, market stalls bustling with trade, and the sound of hammers ringing through the air. Everything is neat, practical, lived-in."
            bash src/print-inaudible-line.sh "A guard, leaning on a spear, eyes you as you approach."
            bash src/print-audible-line.sh "Guard" "You look like a man with purpose. If it’s business with the town, take the main road up to the Meeting Hall. You’ll find Maximus inside."
            bash src/print-inaudible-line.sh "You follow the road until you reach a long, low building of whitewashed stone and carved oak. Inside, a wiry man stands over a table strewn with maps and patrol reports. His riding leathers are worn but well-kept, dust still clinging to his boots."
            bash src/print-inaudible-line.sh "You follow the road until you reach a long, low building of whitewashed stone and carved oak. Inside, a wiry man stands over a table strewn with maps and patrol reports. His riding leathers are worn but well-kept, dust still clinging to his boots."
            bash src/print-inaudible-line.sh "He glances up as you enter, arms folded, posture relaxed—but coiled with purpose."
            bash src/print-audible-line.sh "Maximus" "You look like you've come a long way."
            bash src/print-audible-line.sh "Maximus" "What's your reason for standing in my hall?"
            bash src/print-audible-line.sh "$leader_display_name" "My name is $leader_display_name. I’ve come to ask for your help. A tyrant rises in the southeast. I’m gathering those who’ll stand and fight before it’s too late."
            bash src/print-inaudible-line.sh "Maximus tilts his head, considering."
            bash src/print-audible-line.sh "Maximus" "A noble cause."
            bash src/print-audible-line.sh "Maximus" "But Schwartzville doesn’t give lightly. You want our strength? Prove your own."
            bash src/print-inaudible-line.sh "He turns, pointing at a red-marked path on the map."
            bash src/print-audible-line.sh "Maximus" "Five of mine rode out on patrol two nights past. Sharp riders. Reliable."
            bash src/print-audible-line.sh "Maximus" "They haven’t come back."
            bash src/print-inaudible-line.sh "He meets your gaze—cool and steady."
            bash src/print-audible-line.sh "Maximus" "Bring them home. Do that, and I’ll see to it that Schwartzville rides with you."

            bash src/data/increment-quest-progress.sh schwartzville
            ;;

        "speak with maximus")
            party_characters=$(bash src/data/get-party-characters.sh)
            leader_display_name=$(bash src/data/get-actor-info.sh ${party_characters[0]} "DISPLAY_NAME")

            bash src/print-inaudible-line.sh "The combat squad rides just behind you—exhausted, but alive."
            bash src/print-inaudible-line.sh "Villagers gather as you pass. Murmurs ripple through the crowd."
            bash src/print-inaudible-line.sh "Inside the Meeting Hall, Maximus looks up from the table. His eyes scan the squad… then settle on you."
            bash src/print-audible-line.sh "Maximus" "They’re alive. All of them."
            bash src/print-audible-line.sh "Maximus" "You did what you said you would."
            bash src/print-inaudible-line.sh "He steps forward, offering a firm nod."
            bash src/print-audible-line.sh "Maximus" "Schwartzville stands with you, Ethan."
            bash src/print-audible-line.sh "Maximus" "Our blades, our riders, our loyalty—yours in this fight against the tyrant."
            bash src/print-inaudible-line.sh "He clasps your forearm, his grip iron."
            bash src/print-audible-line.sh "Maximus" "Let the world know: the plains ride to war."

            # Unlock and add max to the party
            bash src/data/unlock-character.sh max
            bash src/add-to-party.sh max
            bash src/data/increment-quest-progress.sh schwartzville

            # Begin progress on max's individual quest
            bash src/data/increment-quest-progress.sh max
            ;;
        "leave")
            area_left=1
            ;;
    esac

done