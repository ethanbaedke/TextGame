#!/bin/bash

# PARAMS: ENEMY_NAME ENEMY_NAME ...
# EXIT CODE: 0 if characters win the combat and 1 if enemies win the combat

characters=($(bash src/data/get-party-characters.sh))
enemies=($@)
all_actors=(${characters[@]} ${enemies[@]})

bash src/init-temp-health.sh ${enemies[@]}

# Sort all actors in order of highest intelligence to lowest intelligence
turn_order=($(for actor in "${all_actors[@]}"; do
        printf "%s\t%s\n" "$(bash src/data/get-actor-info.sh $actor "INTELLIGENCE")" "$actor"
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
        local character_temp_health=$(bash src/data/get-actor-info.sh $character "TEMP_HEALTH")

        # Color the characters's info yellow if it's their turn, and leave it uncolored if not
        if [ "$character" == "${turn_order[$turn_index]}" ]; then
            echo -e "\\e[33m$character_display_name (health=$character_temp_health/$character_max_health)\\e[0m"
        else
            echo "$character_display_name (health=$character_temp_health/$character_max_health)"
        fi
    done

    echo
    echo "ENEMIES"
    local enemy
    for enemy in ${enemies[@]}; do
        local enemy_display_name=$(bash src/data/get-actor-info.sh $enemy "DISPLAY_NAME")
        local enemy_max_health=$(bash src/data/get-actor-info.sh $enemy "MAX_HEALTH")
        local enemy_TEMP_HEALTH=$(bash src/data/get-actor-info.sh $enemy "TEMP_HEALTH")

        # Color the enemy's info yellow if it's their turn
        if [ "$enemy" == "${turn_order[$turn_index]}" ]; then
            echo -e "\\e[33m$enemy_display_name (health=$enemy_TEMP_HEALTH/$enemy_max_health)\\e[0m"
        else
            echo "$enemy_display_name (health=$enemy_TEMP_HEALTH/$enemy_max_health)"
        fi
    done
}

# PARAMS: ACTOR_NAME
# Returns 0 if the actor is alive, and 1 otherwise
is_actor_alive() {
    local TEMP_HEALTH=$(bash src/data/get-actor-info.sh $1 "TEMP_HEALTH")
    if [ $TEMP_HEALTH -eq 0 ]; then
        return 1
    fi
    return 0
}

# PARAMS: CHARACTER_NAME
character_turn() {

    # Have the actor make a common combat decision
    echo
    bash src/request-selection.sh "use weapon" "mend self"
    selection=$(bash src/data/get-selection.sh)

    case "$selection" in
        "use weapon")

            # Get the enemies still alive
            living_enemies=()
                for enemy in ${enemies[@]}; do
                    is_actor_alive $enemy
                    if [ $? -eq 0 ]; then
                        living_enemies+=($enemy)
                    fi
            done

            # If there is more than one enemy still alive, have the user select a target
            if [ ${#living_enemies[@]} -gt 1 ]; then
                echo
                echo "Select a target..."
                bash src/request-selection.sh ${living_enemies[@]}
                selection=$(bash src/data/get-selection.sh)
                bash src/combat/handle-weapon-attack.sh $1 $selection
            
            # If there is only one enemy remaining, auto-target that enemy
            else
                bash src/combat/handle-weapon-attack.sh $1 ${living_enemies[0]}
            fi
            ;;
        "mend self")
            local display_name=$(bash src/data/get-actor-info.sh $1 "DISPLAY_NAME")
            echo
            read -p "$display_name healed themselves 1 point of health."
            bash src/modify-temp-health.sh $1 1
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

update_party_health() {
    local character
    for character in ${characters[@]}; do
        local TEMP_HEALTH=$(bash src/data/get-actor-info.sh $character "TEMP_HEALTH")
        bash src/data/save-actor-info.sh $character "CURRENT_HEALTH" $TEMP_HEALTH
    done
}

# Loop through the turn_order array activating actors turns
while (true); do

    bash src/is-party-knocked-out.sh
    if [ $? -eq 1 ]; then
        echo
        echo "All characters have been knocked out."
        exit 1
    fi

    bash src/are-actors-knocked-out.sh ${enemies[@]}
    if [ $? -eq 1 ]; then
        echo
        echo "All enemies have been defeated."
        exit 0
    fi

    current_actor=${turn_order[$turn_index]}

    is_actor_alive $current_actor
    if [ $? -eq 1 ]; then
        turn_index=$(((turn_index + 1) % ${#turn_order[@]}))
        continue
    fi

    #clear
    echo
    echo "------------------------------------------------------------"
    print_combat_info
    echo
    echo "------------------------------------------------------------"

    take_turn $current_actor

    # Move the index to the next actor in the turn_order, looping to 0 if the end of the array was hit
    turn_index=$(((turn_index + 1) % ${#turn_order[@]}))

done