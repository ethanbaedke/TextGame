#!/bin/bash

# PARAMS: CHARACTER_NAME

name=$(bash src/data/get-actor-info.sh $1 "DISPLAY_NAME")
level=$(bash src/data/get-actor-info.sh $1 "LEVEL")

new_level=$(($level + 1))
bash src/data/save-actor-info.sh $1 "LEVEL" $new_level

bash src/print-dialogue.sh "[*$name* reached level $new_level]"

point_assigned=0
while [ $point_assigned -eq 0 ]; do

    clear

    # Print the characters current stats
    strength=$(bash src/data/get-actor-info.sh $1 "STRENGTH")
    dexterity=$(bash src/data/get-actor-info.sh $1 "DEXTERITY")
    intelligence=$(bash src/data/get-actor-info.sh $1 "INTELLIGENCE")
    charisma=$(bash src/data/get-actor-info.sh $1 "CHARISMA")
    luck=$(bash src/data/get-actor-info.sh $1 "LUCK")
    echo
    echo "Strength: $strength"
    echo "Dexterity: $dexterity"
    echo "Intelligence: $intelligence"
    echo "Charisma: $charisma"
    echo "Luck: $luck"

    echo
    echo "In which area should $name apply their experience?"
    bash src/request-selection.sh "strength" "dexterity" "intelligence" "charisma" "luck"
    selection=$(bash src/data/get-selection.sh)

    case $selection in

        "strength")
            strength=$(bash src/data/get-actor-info.sh $1 "STRENGTH")

            # Ensure the character isn't at max strength already
            if [ $strength -eq 5 ]; then
                bash src/print-dialogue.sh "[*$name* is already at maximum strength]"
                continue
            fi

            new_strength=$(($strength + 1))
            bash src/data/save-actor-info.sh $1 "STRENGTH" $new_strength
            bash src/print-dialogue.sh "[*$name* gained a point of strength]"
            point_assigned=1
            ;;

        "dexterity")
            dexterity=$(bash src/data/get-actor-info.sh $1 "DEXTERITY")

            # Ensure the character isn't at max dexterity already
            if [ $dexterity -eq 5 ]; then
                bash src/print-dialogue.sh "[*$name* is already at maximum dexterity]"
                continue
            fi

            new_dexterity=$(($dexterity + 1))
            bash src/data/save-actor-info.sh $1 "DEXTERITY" $new_dexterity
            bash src/print-dialogue.sh "[*$name* gained a point of dexterity]"
            point_assigned=1
            ;;

        "intelligence")
            intelligence=$(bash src/data/get-actor-info.sh $1 "INTELLIGENCE")

            # Ensure the character isn't at max intelligence already
            if [ $intelligence -eq 5 ]; then
                bash src/print-dialogue.sh "[*$name* is already at maximum intelligence]"
                continue
            fi

            new_intelligence=$(($intelligence + 1))
            bash src/data/save-actor-info.sh $1 "INTELLIGENCE" $new_intelligence
            bash src/print-dialogue.sh "[*$name* gained a point of intelligence]"
            point_assigned=1
            ;;

        "charisma")
            charisma=$(bash src/data/get-actor-info.sh $1 "CHARISMA")

            # Ensure the character isn't at max charisma already
            if [ $charisma -eq 5 ]; then
                bash src/print-dialogue.sh "[*$name* is already at maximum charisma]"
                continue
            fi

            new_charisma=$(($charisma + 1))
            bash src/data/save-actor-info.sh $1 "CHARISMA" $new_charisma
            bash src/print-dialogue.sh "[*$name* gained a point of charisma]"
            point_assigned=1
            ;;

        "luck")
            luck=$(bash src/data/get-actor-info.sh $1 "LUCK")

            # Ensure the character isn't at max luck already
            if [ $luck -eq 5 ]; then
                bash src/print-dialogue.sh "[*$name* is already at maximum luck]"
                continue
            fi

            new_luck=$(($luck + 1))
            bash src/data/save-actor-info.sh $1 "LUCK" $new_luck
            bash src/print-dialogue.sh "[*$name* gained a point of luck]"
            point_assigned=1
            ;;
    esac
done