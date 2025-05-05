#!/bin/bash

MAP_WIDTH=3
MAP_HEIGHT=3

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
}

# QUEST #0 = MAIN QUEST
main_quest_progress=$(bash src/data/get-quest-progress.sh 0)
if [ $main_quest_progress -eq 0 ]; then
    bash src/add-to-party.sh player
    bash src/data/increment-quest-progress.sh 0
fi

# Starting point
retrieve_map_coordinates
enter_current_area

exited=0
while [ $exited -eq 0 ]; do

    # Give the user standard options
    echo
    echo "What would you like to do?"
    bash "src/request-selection.sh" "move" "view party" "exit to menu"

    case $? in
        1)
            # Allow the party to move
            retrieve_map_coordinates
            echo
            echo "In which direction shall you set forth?"
            bash "src/request-selection.sh" "east" "north" "west" "south"

            case $? in
                1)
                    if [ $current_map_x_coord -eq $((MAP_WIDTH - 1)) ]; then
                        bash src/world/describe-map-edge.sh
                    else
                        current_map_x_coord=$((current_map_x_coord + 1))
                        save_map_coordinates
                        enter_current_area
                    fi
                    ;;
                2)
                    if [ $current_map_y_coord -eq $((MAP_HEIGHT - 1)) ]; then
                        bash src/world/describe-map-edge.sh
                    else
                        current_map_y_coord=$((current_map_y_coord + 1))
                        save_map_coordinates
                        enter_current_area
                    fi
                    ;;
                3)
                    if [ $current_map_x_coord -eq 0 ]; then
                        bash src/world/describe-map-edge.sh
                    else
                        current_map_x_coord=$((current_map_x_coord - 1))
                        save_map_coordinates
                        enter_current_area
                    fi
                    ;;
                4)
                    if [ $current_map_y_coord -eq 0 ]; then
                        bash src/world/describe-map-edge.sh
                    else
                        current_map_y_coord=$((current_map_y_coord - 1))
                        save_map_coordinates
                        enter_current_area
                    fi
                    ;;
            esac
            ;;
        2)
            bash src/open-party-menu.sh
            ;;
        3)
            exited=1
            ;;
    esac
done