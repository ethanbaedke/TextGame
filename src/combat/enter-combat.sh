#!/bin/bash

# PARAMS: ENEMY_NAME ENEMY_NAME ...

characters=$(bash src/data/get-party-characters.sh)
enemies=($@)
all_actors=(${characters[@]} ${enemies[@]})

# Sort all actors in order of highest speed to lowest speed
turn_order=($(for actor in "${all_actors[@]}"; do
        printf "%s\t%s\n" "$(bash src/data/get-actor-info.sh $actor "CR_SPE")" "$actor"
    done | sort -n -r | cut -f2))

# Tracks which actor's turn it is in the turn_order array
turn_index=0

print_combat_info() {

    echo
    echo "CHARACTERS"
    local character
    for character in ${characters[@]}; do
        local character_display_name=$(bash src/data/get-actor-info.sh $character "CR_NAM")
        echo "$character_display_name (health=?/?)"
    done

    echo
    echo "ENEMIES"
    local enemy
    for enemy in ${enemies[@]}; do
        local enemy_display_name=$(bash src/data/get-actor-info.sh $enemy "CR_NAM")
        echo "$enemy_display_name (health=?/?)"
    done

    # Display actor whos turn it is
    local display_name=$(bash src/data/get-actor-info.sh $1 "CR_NAM")
    echo
    echo "Turn: $display_name"
}

# PARAMS: CHARACTER_NAME
character_turn() {

    # Have the actor make a common combat decision
    bash src/request-selection.sh "use weapon" "mend self"

    case $? in
        1)
            echo
            echo "Select a target..."
            bash src/request-selection.sh ${enemies[@]}
            handle_weapon_attack $1 ${enemies[(($? - 1))]}
            ;;
        2)
            local display_name=$(bash src/data/get-actor-info.sh $1 "CR_NAM")
            echo
            echo "$display_name healed themselves 1 point of health"
            ;;
    esac
}

# PARAMS: ENEMY_NAME
enemy_turn() {

    # Attack a random character
    random_character=$((RANDOM % ${#characters[@]}))
    handle_weapon_attack $1 ${characters[$random_character]}
}

# PARAMS: ACTOR_NAME
take_turn() {

    # If the actor taking the turn is in the character array, route to the character_turn function
    local character
    for character in ${characters[@]}; do
        if [ "$1" == "$character" ]; then
            character_turn $1
            return
        fi
    done

    # Otherwise, route to the enemy_turn function
    enemy_turn $1
}

# Loop through the turn_order array activating actors turns
while (true); do

    print_combat_info

    current_actor=${turn_order[$turn_index]}
    take_turn $current_actor

    bash src/await-continuation.sh

    # Move the index to the next actor in the turn_order, looping to 0 if the end of the array was hit
    turn_index=$(((turn_index + 1) % ${#turn_order[@]}))

done