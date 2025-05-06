#!/bin/bash

# PARAMS: ENEMY_NAME ENEMY_NAME ...
# EXIT CODE: 0 if characters win the combat and 1 if enemies win the combat

characters=$(bash src/data/get-party-characters.sh)
enemies=($@)
all_actors=(${characters[@]} ${enemies[@]})

# Initialize all actors combat health to their current health
(for actor in ${all_actors[@]}; do
    current_health=$(bash src/data/get-actor-info.sh $actor "CURRENT_HEALTH")
    bash src/data/save-actor-info.sh $actor "COMBAT_HEALTH" $current_health
done)

# Sort all actors in order of highest speed to lowest speed
turn_order=($(for actor in "${all_actors[@]}"; do
        printf "%s\t%s\n" "$(bash src/data/get-actor-info.sh $actor "SPEED")" "$actor"
    done | sort -n -r | cut -f2))

# Tracks which actor's turn it is in the turn_order array
turn_index=0

print_combat_info() {

    echo
    echo "CHARACTERS"
    local character
    for character in ${characters[@]}; do
        local character_display_name=$(bash src/data/get-actor-info.sh $character "DISPLAY_NAME")
        local character_max_health=$(bash src/data/get-actor-info.sh $character "MAX_HEALTH")
        local character_combat_health=$(bash src/data/get-actor-info.sh $character "COMBAT_HEALTH")
        echo "$character_display_name (health=$character_combat_health/$character_max_health)"
    done

    echo
    echo "ENEMIES"
    local enemy
    for enemy in ${enemies[@]}; do
        local enemy_display_name=$(bash src/data/get-actor-info.sh $enemy "DISPLAY_NAME")
        local enemy_max_health=$(bash src/data/get-actor-info.sh $enemy "MAX_HEALTH")
        local enemy_combat_health=$(bash src/data/get-actor-info.sh $enemy "COMBAT_HEALTH")
        echo "$enemy_display_name (health=$enemy_combat_health/$enemy_max_health)"
    done
}

# Returns 0 if the characters have won, and 1 otherwise
get_characters_won() {
    # If any enemy has health remaining, characters have not yet won the combat
    local enemy
    for enemy in ${enemies[@]}; do
        local combat_health=$(bash src/data/get-actor-info.sh $enemy "COMBAT_HEALTH")
        if [ ! $combat_health -eq 0 ]; then
            return 1
        fi
    done
    return 0
}

# Returns 0 if the enemies have won, and 1 otherwise
get_enemies_won() {
    # If any character has health remaining, enemies have not yet won the combat
    local character
    for character in ${characters[@]}; do
        local combat_health=$(bash src/data/get-actor-info.sh $character "COMBAT_HEALTH")
        if [ ! $combat_health -eq 0 ]; then
            return 1
        fi
    done
    return 0
}

# PARAMS: CHARACTER_NAME
character_turn() {

    # Have the actor make a common combat decision
    echo
    bash src/request-selection.sh "use weapon" "mend self"

    case $? in
        1)
            echo
            echo "Select a target..."
            bash src/request-selection.sh ${enemies[@]}
            bash src/combat/handle-weapon-attack.sh $1 ${enemies[(($? - 1))]}
            ;;
        2)
            local display_name=$(bash src/data/get-actor-info.sh $1 "DISPLAY_NAME")
            echo
            echo "$display_name healed themselves 1 point of health."
            bash src/await-continuation.sh
            bash src/combat/modify-combat-health.sh $1 1
            ;;
    esac
}

# PARAMS: ENEMY_NAME
enemy_turn() {

    # Attack a random character
    random_character=$((RANDOM % ${#characters[@]}))
    bash src/combat/handle-weapon-attack.sh $1 ${characters[$random_character]}
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

    get_enemies_won
    if [ $? -eq 0 ]; then
        echo
        echo "All characters have been knocked out."
        exit 1
    fi

    get_characters_won
    if [ $? -eq 0 ]; then
        echo
        echo "All enemies have been defeated."
        exit 0
    fi

    current_actor=${turn_order[$turn_index]}

    # Display actor whos turn it is
    current_actor_display_name=$(bash src/data/get-actor-info.sh $current_actor "DISPLAY_NAME")
    echo
    echo "Turn: $current_actor_display_name"

    take_turn $current_actor

    # Move the index to the next actor in the turn_order, looping to 0 if the end of the array was hit
    turn_index=$(((turn_index + 1) % ${#turn_order[@]}))

done