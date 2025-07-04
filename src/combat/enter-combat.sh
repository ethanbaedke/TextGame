#!/bin/bash

# PARAMS: ENEMY_NAME ENEMY_NAME ...
# EXIT CODE: 0 if characters win the combat and 1 if enemies win the combat

characters=($(bash src/data/get-party-characters.sh))
enemies=($@)
all_actors=(${characters[@]} ${enemies[@]})

bash src/init-temp-health.sh ${enemies[@]}
for enemy in ${enemies[@]}; do
    bash src/data/save-actor-info.sh $enemy "TEMP_ELEMENTAL_AFFLICTION" "none"
done

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
        local character_temp_elemental_affliction=$(bash src/data/get-actor-info.sh $character "TEMP_ELEMENTAL_AFFLICTION")

        # Color the characters's info yellow if it's their turn, and leave it uncolored if not
        if [ "$character" == "${turn_order[$turn_index]}" ]; then
            echo -n -e "\\e[33m$character_display_name (health=$character_temp_health/$character_max_health)\\e[0m"
            if [ ! "$character_temp_elemental_affliction" == "none" ]; then
                echo " ($character_temp_elemental_affliction)"
            else
                echo
            fi
        else
            echo -n "$character_display_name (health=$character_temp_health/$character_max_health)"
            if [ ! "$character_temp_elemental_affliction" == "none" ]; then
                echo " ($character_temp_elemental_affliction)"
            else
                echo
            fi
        fi
    done

    echo
    echo "ENEMIES"
    local enemy
    for enemy in ${enemies[@]}; do
        local enemy_display_name=$(bash src/data/get-actor-info.sh $enemy "DISPLAY_NAME")
        local enemy_max_health=$(bash src/data/get-actor-info.sh $enemy "MAX_HEALTH")
        local enemy_TEMP_HEALTH=$(bash src/data/get-actor-info.sh $enemy "TEMP_HEALTH")
        local enemy_temp_elemental_affliction=$(bash src/data/get-actor-info.sh $enemy "TEMP_ELEMENTAL_AFFLICTION")

        # Color the enemy's info yellow if it's their turn
        if [ "$enemy" == "${turn_order[$turn_index]}" ]; then
            echo -n -e "\\e[33m$enemy_display_name (health=$enemy_TEMP_HEALTH/$enemy_max_health)\\e[0m"
            if [ ! "$enemy_temp_elemental_affliction" == "none" ]; then
                echo " ($enemy_temp_elemental_affliction)"
            else
                echo
            fi
        else
            echo -n "$enemy_display_name (health=$enemy_TEMP_HEALTH/$enemy_max_health)"
            if [ ! "$enemy_temp_elemental_affliction" == "none" ]; then
                echo " ($enemy_temp_elemental_affliction)"
            else
                echo
            fi
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

    bash src/display-image.sh images/characters/beautiful/$1.png -s

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
            bash src/combat/handle-mend.sh $1
            ;;
    esac
}

# PARAMS: ENEMY_NAME
enemy_turn() {

    bash src/display-image.sh images/enemies/$1.png -s

    # If the enemy is not at full health, have a 25% for the enemy to mend itself instead of attacking
    local temp_health=$(bash src/data/get-actor-info.sh $1 "TEMP_HEALTH")
    local max_health=$(bash src/data/get-actor-info.sh $1 "MAX_HEALTH")
    if [ $temp_health -lt $max_health ]; then
        local chance=$((RANDOM % 4))
        if [ $chance -eq 0 ]; then
            bash src/combat/handle-mend.sh $1
            return
        fi
    fi

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

# PARAMS: ACTOR_NAME
# RETURN: 1 if an elemental affliction was activated, and 0 otherwise
handle_elemental_affliction() {

    affliction=$(bash src/data/get-actor-info.sh $1 "TEMP_ELEMENTAL_AFFLICTION")

    if [ "$affliction" == "none" ]; then
        return 0
    fi

    bash src/data/request-help-menu.sh "COMBAT_ELEMENTAL_AFFLICTION_ACTIVATION"

    local display_name=$(bash src/data/get-actor-info.sh $1 "DISPLAY_NAME")
    case $affliction in
        "flaming")
            bash src/print-dialogue.sh "[*$display_name* was hurt from burning alive]"
            bash src/modify-temp-health.sh $1 -1
            ;;
    esac

    return 1
}

update_party_health() {
    local character
    for character in ${characters[@]}; do
        local TEMP_HEALTH=$(bash src/data/get-actor-info.sh $character "TEMP_HEALTH")
        bash src/data/save-actor-info.sh $character "CURRENT_HEALTH" $TEMP_HEALTH
    done
}

# Loop through the turn_order array activating actors turns
actor_on_second_turn=0
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

    clear

    bash src/data/request-help-menu.sh "COMBAT_INFO"
    bash src/data/request-help-menu.sh "COMBAT_INTELLIGENCE"

    echo
    echo "------------------------------------------------------------"
    print_combat_info
    echo
    echo "------------------------------------------------------------"

    handle_elemental_affliction $current_actor
        if [ $? -eq 1 ]; then
        is_actor_alive $current_actor
        if [ $? -eq 1 ]; then
            turn_index=$(((turn_index + 1) % ${#turn_order[@]}))
            continue
        fi

        clear

        echo
        echo "------------------------------------------------------------"
        print_combat_info
        echo
        echo "------------------------------------------------------------"
    fi

    take_turn $current_actor

    # Roll charisma check to see if actor takes a second turn
    bash src/roll-stat-check.sh $current_actor "CHARISMA" -d
    result=$?
    if [ $actor_on_second_turn -eq 0 ] && [ $result -eq 0 ]; then
        bash src/data/request-help-menu.sh "COMBAT_CHARISMA"
        display_name=$(bash src/data/get-actor-info.sh $current_actor "DISPLAY_NAME")
        bash src/print-dialogue.sh "[*$display_name's* charismatic nature distracted the others, allowing them to act an additional time]"
        actor_on_second_turn=1
        continue
    fi

    # Move the index to the next actor in the turn_order, looping to 0 if the end of the array was hit
    turn_index=$(((turn_index + 1) % ${#turn_order[@]}))
    actor_on_second_turn=0
done