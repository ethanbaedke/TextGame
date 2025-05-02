#!/bin/bash

MAP_WIDTH=3
MAP_HEIGHT=3

current_map_x_coord=0
current_map_y_coord=0

describe_current_area() {
    (
        source src/world/map/area-$current_map_x_coord-$current_map_y_coord.sh
        print_area_name | bash src/world/map/describe-area.sh
    )
}

trigger_individual_encounter_in_current_area() {
    (
        source src/world/map/area-$current_map_x_coord-$current_map_y_coord.sh
        print_area_name | bash src/trigger-individual-encounter.sh
    )
}

# Populate party
bash src/party/add-to-party.sh player
bash src/unlock-character.sh aidan
bash src/party/add-to-party.sh aidan
bash src/unlock-character.sh aly
bash src/party/add-to-party.sh aly
bash src/unlock-character.sh ceci
bash src/party/add-to-party.sh ceci

# Describe where the party is starting
describe_current_area

exited=0
while [ $exited -eq 0 ]; do

    # Give the user standard options
    echo
    echo "What would you like to do?"
    bash "src/request-selection.sh" "move" "exit to menu"

    case $? in
        1)
            # Allow the party to move
            echo
            echo "In which direction shall you set forth?"
            bash "src/request-selection.sh" "east" "north" "west" "south"

            case $? in
                1)
                    if [ $current_map_x_coord -eq $((MAP_WIDTH - 1)) ]; then
                        echo "ocean" | bash src/world/map/describe-area.sh
                    else
                        current_map_x_coord=$((current_map_x_coord + 1))
                        describe_current_area
                        trigger_individual_encounter_in_current_area
                    fi
                    ;;
                2)
                    if [ $current_map_y_coord -eq $((MAP_HEIGHT - 1)) ]; then
                        echo "ocean" | bash src/world/map/describe-area.sh
                    else
                        current_map_y_coord=$((current_map_y_coord + 1))
                        describe_current_area
                        trigger_individual_encounter_in_current_area
                    fi
                    ;;
                3)
                    if [ $current_map_x_coord -eq 0 ]; then
                        echo "ocean" | bash src/world/map/describe-area.sh
                    else
                        current_map_x_coord=$((current_map_x_coord - 1))
                        describe_current_area
                        trigger_individual_encounter_in_current_area
                    fi
                    ;;
                4)
                    if [ $current_map_y_coord -eq 0 ]; then
                        echo "ocean" | bash src/world/map/describe-area.sh
                    else
                        current_map_y_coord=$((current_map_y_coord - 1))
                        describe_current_area
                        trigger_individual_encounter_in_current_area
                    fi
                    ;;
            esac
            ;;
        2)
            exited=1
            ;;
    esac
done