#!/bin/bash

# Stats
readonly NUM_POINTS_FOR_DISTRIBUTION=5
remaining_points=$NUM_POINTS_FOR_DISTRIBUTION

strength=0
dexterity=0
intellect=0
charisma=0
luck=0

max_points_per_stat=5

# Info
readonly MAX_CHARACTERS_FOR_STRING_INFO=32
character_name="---------------------------------" # 33 characters, over max size of 32
favorite_color="---------------------------------" # 33 characters, over max size of 32

print_stats() {
    echo "Strength: $strength / $max_points_per_stat"
    echo "Dexterity: $dexterity / $max_points_per_stat"
    echo "Intellect: $intellect / $max_points_per_stat"
    echo "Charisma: $charisma / $max_points_per_stat"
    echo "Luck: $luck / $max_points_per_stat"
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
    charisma=0
    luck=0
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
        bash "src/request-selection.sh" "strength" "dexterity" "intellect" "charisma" "luck" "reset"
        selection=$(bash src/data/get-selection.sh)

        case "$selection" in
            "strength")
                try_add_point strength
                ;;
            "dexterity")
                try_add_point dexterity
                ;;
            "intellect")
                try_add_point intellect
                ;;
            "charisma")
                try_add_point charisma
                ;;
            "luck")
                try_add_point luck
                ;;
            "reset")
                reset_stats
                ;;
        esac
    done

    # Allow the user to lock in or reset their stats
    echo
    print_stats
    echo "Are you satisfied with these stats?"
    bash "src/request-selection.sh" "yes" "no"
    selection=$(bash src/data/get-selection.sh)

    case "$selection" in
        "yes")
            stats_locked_in=1
            ;;
        "no")
            reset_stats
            ;;
    esac
done

# Have the user choose the characters starting weapon
weapon_locked_in=0
while [ $weapon_locked_in -eq 0 ]; do

    # Have the user choose the characters starting weapon
    echo
    echo "Choose your starting weapon..."
    bash src/request-selection.sh sword hammer bow
    selection=$(bash src/data/get-selection.sh)

    case "$selection" in
        "sword")
            starting_weapon="sword"
            ;;
        "hammer")
            starting_weapon="hammer"
            ;;
        "bow")
            starting_weapon="bow"
            ;;
    esac

    # Allow the user to lock in their starting weapon or choose another one
    echo
    echo "Are you satisfied with a $starting_weapon as your starting weapon?"
    bash "src/request-selection.sh" "yes" "no"
    selection=$(bash src/data/get-selection.sh)

    case "$selection" in
        "yes")
            weapon_locked_in=1
            ;;
        "no")
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
    selection=$(bash src/data/get-selection.sh)

    case "$selection" in
        "yes")
            name_locked_in=1
            ;;
        "no")
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
    selection=$(bash src/data/get-selection.sh)

    case "$selection" in
        "yes")
            favorite_color_locked_in=1
            ;;
        "no")
            ;;
    esac
done

bash src/data/create-actor-data.sh player
bash src/data/save-actor-info.sh "player" "STRENGTH" $strength "DEXTERITY" $dexterity "INTELLIGENCE" $intellect "CHARISMA" $charisma "LUCK" $luck "MAX_HEALTH" 5 "CURRENT_HEALTH" 5 "COMBAT_HEALTH" 0 "DISPLAY_NAME" "$character_name" "FAVORITE_COLOR" "$favorite_color" "WEAPON" $starting_weapon

echo
echo "Character created."