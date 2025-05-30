#!/bin/bash

bash src/data/request-help-menu.sh "PRINT_MAP"

party_coord_x=$(bash src/data/get-party-location-x.sh)
party_coord_y=$(bash src/data/get-party-location-y.sh)

map=""

echo
for ((y=0; y<5; y++)); do

    line=""

    for ((x=0; x<5; x++)); do

        visited_status=$(bash src/data/get-map-area-visited-status.sh $x $y)
        
        if [ $visited_status -eq 1 ]; then
            line+="?????"
        elif [ $visited_status -eq 2 ]; then

            area_name=$(bash src/data/get-map-area.sh $x $y)
            case $area_name in
                "beach")
                    line+="\033[48;2;233;213;156m"
                    ;;
                "plains")
                    line+="\033[48;2;156;212;92m"
                    ;;
                "schwartzville")
                    line+="\033[48;2;156;212;92m"
                    ;;
                "tyus-estates")
                    line+="\033[48;2;156;212;92m"
                    ;;
                "river")
                    line+="\033[48;2;35;128;149m"
                    ;;
            esac

            if [ $x -eq $party_coord_x ] && [ $y -eq $party_coord_y ]; then
                line+=" @@@ \033[49m"
            else
                line+="     \033[49m"
            fi
        fi
    done

    for ((i=0; i<2; i++)); do
        map+="$line\n"
    done
done
map+="\033[0m"

echo -e "$map"