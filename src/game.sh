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
    
    clear

    bash src/data/update-map-area-visited-status.sh $current_map_x_coord $current_map_y_coord 2
    bash src/data/update-map-area-visited-status.sh $((current_map_x_coord + 1)) $current_map_y_coord 1
    bash src/data/update-map-area-visited-status.sh $((current_map_x_coord - 1)) $current_map_y_coord 1
    bash src/data/update-map-area-visited-status.sh $current_map_x_coord $((current_map_y_coord + 1)) 1
    bash src/data/update-map-area-visited-status.sh $current_map_x_coord $((current_map_y_coord - 1)) 1

    local area_name=$(bash src/data/get-map-area.sh $current_map_x_coord $current_map_y_coord)
    bash src/world/$area_name.sh

    # Party died in the area
    if [ $? -eq 1 ]; then
        bash src/print-dialogue.sh "[Your vision blurs and your knees buckle]"
        bash src/print-dialogue.sh "[You fall to the ground and die]"
        echo "GAME OVER"
        exit 1
    fi
}

# Main quest
main_quest_progress=$(bash src/data/get-quest-progress.sh main)
if [ $main_quest_progress -eq 0 ]; then

    clear
    player_display_name=$(bash src/data/get-actor-info.sh ethan "DISPLAY_NAME")

    bash src/print-dialogue.sh "[You stumble around the beach, weaving through dancers making merry around a blazing fire]"
    bash src/print-dialogue.sh "[A *Stranger* approaches you]"
    bash src/print-dialogue.sh "Stranger: *$player_display_name*?"
    bash src/print-dialogue.sh "[You stumble into him, spilling your drink]"
    
    bash src/request-selection.sh "act aggressive" "apologize"
    selection=$(bash src/data/get-selection.sh)
    case "$selection" in
        "act aggressive")
            bash src/print-dialogue.sh "[You shove the *Stranger* away]"
            bash src/print-dialogue.sh "$player_display_name: What's your problem man? Look what you made me do!"
            bash src/print-dialogue.sh "Stranger: Your aggression is precisely why I've picked you."
            ;;
        "apologize")
            bash src/print-dialogue.sh "$player_display_name: Woah! Sorry friend, I didn't see you there!"
            bash src/print-dialogue.sh "[The *Stranger* laughs]"
            bash src/print-dialogue.sh "Stranger: Your compassion is precisely why I've picked you."
            ;;
    esac

    bash src/print-dialogue.sh "[You stare at the *Stranger* confused]"
    bash src/print-dialogue.sh "$player_display_name: Picked me for wh..."
    bash src/print-dialogue.sh "[You feel a wave of nausea come over you]"
    bash src/print-dialogue.sh "[Your knees buckle and you collapse]"
    bash src/print-dialogue.sh "[You feel the *Stranger* slip something into your pocket before his footsteps echo off]"
    bash src/print-dialogue.sh "Stranger: -Schwartzville- sure throws a hell of a party."
    bash src/print-dialogue.sh "[Everything fades to black]"

    bash src/data/increment-quest-progress.sh main
fi

# Main quest
main_quest_progress=$(bash src/data/get-quest-progress.sh main)
if [ $main_quest_progress -eq 1 ]; then

    clear
    player_display_name=$(bash src/data/get-actor-info.sh ethan "DISPLAY_NAME")

    bash src/print-dialogue.sh "[The sun stabs at your eyes as you awaken on the beach]"
    bash src/print-dialogue.sh "[Memories swirl through your mind, too cloudy to make out]"
    bash src/print-dialogue.sh "[As you stand a *weathered scroll* falls out of your pocket]"
    bash src/print-dialogue.sh "$player_display_name: What's this?"
    bash src/print-dialogue.sh "[You pick up and unravel the *weathered scroll*]"
    bash src/print-dialogue.sh "Weathered Scroll: *$player_display_name*."
    bash src/print-dialogue.sh "Weathered Scroll: A great and evil power is brewing in the southeast."
    bash src/print-dialogue.sh "Weathered Scroll: I believe you are the key to stopping this threat."
    bash src/print-dialogue.sh "Weathered Scroll: +Make your way to the tyrnat's castle in the far southeast+, where I will be waiting for you."
    bash src/print-dialogue.sh "Weathered Scroll: It may be wise to +recruit factions from around the world+ for the battle to come."
    bash src/print-dialogue.sh "Weathered Scroll: Good luck."

    echo
    echo "Setting up game state, please wait..."

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
    bash "src/request-selection.sh" "move" "view map" "view party" "exit to main menu"
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
        "view map")
            bash src/print-map.sh
            ;;
        "view party")
            bash src/open-party-menu.sh
            ;;
        "exit to main menu")
            exited=1
            ;;
    esac
done