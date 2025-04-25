#!/bin/bash

readonly NUM_POINTS_FOR_DISTRIBUTION=5

remaining_points=$NUM_POINTS_FOR_DISTRIBUTION

strength=0
dexterity=0
intellect=0

max_points_per_stat=5

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
        bash request-selection.sh "strength" "dexterity" "intellect" "reset"

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
    bash request-selection.sh "yes" "no"

    case $? in
        1)
            echo
            echo "Character created!"
            stats_locked_in=1
            ;;
        2)
            reset_stats
            ;;
    esac
done