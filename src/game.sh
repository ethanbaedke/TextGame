#!/bin/bash

MAP_WIDTH=3
MAP_HEIGHT=3

current_map_x_coord=0
current_map_y_coord=0

retrieve_map_coordinates() {
    bash src/party/get-party-location-x.sh
    current_map_x_coord=$?
    bash src/party/get-party-location-y.sh
    current_map_y_coord=$?
}

save_map_coordinates() {
    bash src/party/update-party-location.sh $current_map_x_coord $current_map_y_coord
}

enter_current_area() {
    bash src/world/map/area-$current_map_x_coord-$current_map_y_coord.sh
}

# Exit if quest-data does not exist
if [ ! -f "data/quest-data.bin" ]; then
    echo "ERROR! $0 called but data/quest-data.bin could not be found."
    exit
fi

# QUEST #0 = MAIN QUEST
bash src/get-quest-progress.sh 0
if [ $? -eq 0 ]; then
    bash src/increment-quest-progress.sh 0
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
            bash src/party/open-party-menu.sh
            ;;
        3)
            exited=1
            ;;
    esac
done