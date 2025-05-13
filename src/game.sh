#!/bin/bash

MAP_WIDTH=5
MAP_HEIGHT=5

current_map_x_coord=0
current_map_y_coord=0

retrieve_map_coordinates() {
    current_map_x_coord=$(bash src/data/get-party-location-x.sh)
    current_map_y_coord=$(bash src/data/get-party-location-y.sh)
}

save_map_coordinates() {
    bash src/data/update-party-location.sh $current_map_x_coord $current_map_y_coord
}

enter_current_area() {
    bash src/world/map/area-$current_map_x_coord-$current_map_y_coord.sh
    if [ $? -eq 1 ]; then
        echo "TODO: Implement party wiped out logic here (game.sh)"
    fi
}

# Main quest
main_quest_progress=$(bash src/data/get-quest-progress.sh main)
if [ $main_quest_progress -eq 0 ]; then

    bash src/print-inaudible-line.sh "The music thumps, surf crashes, and laughter echoes across the lantern-lit beach. Warm sand shifts beneath your feet as you dance with reckless joy."
    bash src/print-audible-line.sh "Ethan" "WOOOOOO! Somebody get me another drink!"
    bash src/print-inaudible-line.sh "A bottle is already in your hand. You take a long swig and spin wildly, nearly toppling into a roasting spit nearby."
    bash src/print-inaudible-line.sh "From the crowd, a hooded figure approaches—quiet, purposeful."
    bash src/print-audible-line.sh "Mysterious Stranger" "Ethan?"
    bash src/print-inaudible-line.sh "You blink at the man, sweat running down your brow."
    bash src/print-audible-line.sh "Ethan" "That’s me, unless I owe you money. Then I’m… Darren."
    bash src/print-inaudible-line.sh "The man doesn't laugh."
    bash src/print-audible-line.sh "Mysterious Stranger" "A tyrant is rising in the southeast. Villages burn. Farmers hang. The people need a symbol. A leader. I’ve heard whispers about you."
    bash src/print-audible-line.sh "Ethan" "(grinning) You’ve heard wrong, my guy. I’m just the symbol of a good time."
    bash src/print-audible-line.sh "Mysterious Stranger" "That may be. But when the tide turns, even fools become legends."
    bash src/print-inaudible-line.sh "He pulls a weathered scroll from inside his coat and holds it out."
    bash src/print-audible-line.sh "Mysterious Stranger" "This is the plan. Read it—if you're brave enough to matter."
    bash src/print-inaudible-line.sh "You reach out with one hand… and take another drink with the other."
    bash src/print-inaudible-line.sh "You squint at the scroll. It swims in your vision. Your hand drops. Your legs buckle."
    bash src/print-audible-line.sh "Ethan" "Wait... what was your na—"
    bash src/print-inaudible-line.sh "Everything fades to black. You collapse into the sand."
    bash src/print-inaudible-line.sh "Somewhere behind you, the stranger sighs."
    bash src/print-audible-line.sh "Mysterious Stranger" "Schwartzville throws a hell of a party."
    bash src/print-inaudible-line.sh "You lose consciousness."

    bash src/data/increment-quest-progress.sh main
fi

# Main quest
main_quest_progress=$(bash src/data/get-quest-progress.sh main)
if [ $main_quest_progress -eq 1 ]; then

    bash src/print-inaudible-line.sh "You groan. The sun scorches your face. Waves lap nearby. Your head pounds like a war drum."
    bash src/print-audible-line.sh "Ethan" "Ugh… where am I? …Oh. Right. Beach. Party."
    bash src/print-inaudible-line.sh "You sit up, spitting sand. Something crackles beneath you."
    bash src/print-inaudible-line.sh "You brush away the sand to reveal a scroll, sealed with a wax emblem—an upturned torch wrapped in thorns."
    bash src/print-inaudible-line.sh "You break the seal and unroll the parchment. The handwriting is jagged, but urgent."
    bash src/print-audible-line.sh "Scroll" "Ethan,"
    bash src/print-audible-line.sh "Scroll" "You may not remember me, but we spoke last night. The rebellion is real. The tyrant’s grip tightens daily."
    bash src/print-audible-line.sh "Scroll" "If you’re willing to rise—meet us at the old smithy behind the blue-roofed inn in Schwartzville."
    bash src/print-audible-line.sh "Scroll" "Noon."
    bash src/print-audible-line.sh "Scroll" "Don’t be late."
    bash src/print-inaudible-line.sh "You lower the scroll. The sun is high, nearly overhead."
    bash src/print-audible-line.sh "Ethan" "Noon?! Damn it—how long was I out!?"
    bash src/print-inaudible-line.sh "Your heart races. Somewhere in town, someone’s waiting."

    bash src/data/unlock-character.sh ethan
    bash src/add-to-party.sh ethan
    bash src/data/increment-quest-progress.sh main
fi

# Starting point
retrieve_map_coordinates
enter_current_area

exited=0
while [ $exited -eq 0 ]; do

    # Give the user standard options
    echo
    echo "What would you like to do?"
    bash "src/request-selection.sh" "move" "view party" "exit to main menu"
    selection=$(bash src/data/get-selection.sh)

    case "$selection" in
        "move")
            # Allow the party to move
            retrieve_map_coordinates
            echo
            echo "In which direction shall you set forth?"
            bash "src/request-selection.sh" "west" "north" "south" "east"
            selection=$(bash src/data/get-selection.sh)

            case "$selection" in
                "west")
                    if [ $current_map_x_coord -eq 0 ]; then
                        bash src/world/describe-map-edge.sh
                    else
                        current_map_x_coord=$((current_map_x_coord - 1))
                        save_map_coordinates
                        enter_current_area
                    fi
                    ;;
                "north")
                    if [ $current_map_y_coord -eq 0 ]; then
                        bash src/world/describe-map-edge.sh
                    else
                        current_map_y_coord=$((current_map_y_coord - 1))
                        save_map_coordinates
                        enter_current_area
                    fi
                    ;;
                "south")
                    if [ $current_map_y_coord -eq $((MAP_HEIGHT - 1)) ]; then
                        bash src/world/describe-map-edge.sh
                    else
                        current_map_y_coord=$((current_map_y_coord + 1))
                        save_map_coordinates
                        enter_current_area
                    fi
                    ;;
                "east")
                    if [ $current_map_x_coord -eq $((MAP_WIDTH - 1)) ]; then
                        bash src/world/describe-map-edge.sh
                    else
                        current_map_x_coord=$((current_map_x_coord + 1))
                        save_map_coordinates
                        enter_current_area
                    fi
                    ;;
            esac
            ;;
        "view party")
            bash src/open-party-menu.sh
            ;;
        "exit to main menu")
            exited=1
            ;;
    esac
done