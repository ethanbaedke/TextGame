#!/bin/bash

# Stats
readonly NUM_POINTS_FOR_DISTRIBUTION=5
remaining_points=$NUM_POINTS_FOR_DISTRIBUTION

strength=0
dexterity=0
intellect=0

max_points_per_stat=5

# Info
readonly MAX_CHARACTERS_FOR_STRING_INFO=32
character_name="---------------------------------" # 33 characters, over max size of 32
favorite_color="---------------------------------" # 33 characters, over max size of 32

print_stats() {
    echo "Strength: $strength / $max_points_per_stat"
    echo "Dexterity: $dexterity / $max_points_per_stat"
    echo "Intellect: $intellect / $max_points_per_stat"
}

# Takes in the name of the stat to increase
try_add_point() {
    # Make sure a parameter was passed in
    if [ -z $1 ]; then
        return
    fi

    if [ ${!1} -lt $max_points_per_stat ]; then
        (($1 += 1))
        ((remaining_points -= 1))
    fi
}

reset_stats() {
    strength=0
    dexterity=0
    intellect=0
    remaining_points=$NUM_POINTS_FOR_DISTRIBUTION
}

# Have the user fill out their stats
stats_locked_in=0
while [ $stats_locked_in -eq 0 ]; do

    # Have the user fill out their stats
    while [ $remaining_points -gt 0 ]; do

        # Show the user their current point distribution
        echo
        echo "You have $remaining_points points left to assign"
        print_stats

        # Have the user select a stat to put a point into
        bash "src/request-selection.sh" "strength" "dexterity" "intellect" "reset"

        case $? in
            1)
                try_add_point strength
                ;;
            2)
                try_add_point dexterity
                ;;
            3)
                try_add_point intellect
                ;;
            4)
                reset_stats
                ;;
        esac
    done

    # Allow the user to lock in or reset their stats
    echo
    print_stats
    echo "Are you satisfied with these stats?"
    bash "src/request-selection.sh" "yes" "no"

    case $? in
        1)
            stats_locked_in=1
            ;;
        2)
            reset_stats
            ;;
    esac
done

# Have the user fill out the characters name
name_locked_in=0
while [ $name_locked_in -eq 0 ]; do

    # Have the user fill out the characters name
    echo
    while [ true ]; do
        echo "What is your name?"
        read character_name

        if [ ${#character_name} -le $MAX_CHARACTERS_FOR_STRING_INFO ]; then
            break
        fi

        echo
        echo "Please choose a shorter name."
    done

    # Allow the user to lock in their name or choose another one
    echo
    echo "Are you satisfied with the name $character_name?"
    bash "src/request-selection.sh" "yes" "no"

    case $? in
        1)
            name_locked_in=1
            ;;
        2)
            ;;
    esac
done

# Have the user fill out the characters favorite color
favorite_color_locked_in=0
while [ $favorite_color_locked_in -eq 0 ]; do

    # Have the user fill out the characters favorite color
    echo
    while [ true ]; do
        echo "What is your favorite color?"
        read favorite_color

        if [ ${#favorite_color} -le $MAX_CHARACTERS_FOR_STRING_INFO ]; then
            break
        fi

        echo
        echo "Please choose a color with a shorter name."
    done

    # Allow the user to lock in their favorite color or choose another one
    echo
    echo "Are you satisfied with $favorite_color as your favorite color?"
    bash "src/request-selection.sh" "yes" "no"

    case $? in
        1)
            favorite_color_locked_in=1
            ;;
        2)
            ;;
    esac
done

echo
echo "Character created."
bash src/save-character-data.sh "player" "CR_STR" $strength "CR_DEX" $dexterity "CR_INT" $intellect "CR_NAM" "$character_name" "CR_COL" "$favorite_color"
echo "Character saved."