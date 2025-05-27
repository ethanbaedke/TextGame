#!/bin/bash

clear

menu_left=0
while [ $menu_left -eq 0 ]; do

    clear

    # Print all party members current equipment
    party=($(bash src/data/get-party-characters.sh))
    for member in ${party[@]}; do
        name=$(bash src/data/get-actor-info.sh $member "DISPLAY_NAME")
        weapon=$(bash src/data/get-actor-info.sh $member "WEAPON")
        weapon_name=$(bash src/data/get-weapon-info.sh $weapon "DISPLAY_NAME")
        armor=$(bash src/data/get-actor-info.sh $member "ARMOR")
        armor_name=$(bash src/data/get-armor-info.sh $armor "DISPLAY_NAME")
        echo
        echo "Character: $name"
        echo "Weapon: $weapon_name"
        echo "Armor: $armor_name"
    done

    # Print all equipment in the players inventory
    echo
    echo "INVENTORY"
    weapons=()
    armors=()
    inventory=($(bash src/data/get-inventory.sh))
    for equipment in ${inventory[@]}; do
        name=""
        if [ -f data/weapons/$equipment-data.bin ]; then
            name=$(bash src/data/get-weapon-info.sh $equipment "DISPLAY_NAME")
            weapons+=($equipment)
        else
            name=$(bash src/data/get-armor-info.sh $equipment "DISPLAY_NAME")
            armors+=($equipment)
        fi
        echo "$name"
    done

    echo
    bash src/request-selection.sh "swap weapon" "swap armor" "exit"
    selection=$(bash src/data/get-selection.sh)

    case $selection in

        "swap weapon")

            # Ensure the player has a weapon in their inventory to swap
            if [ ${#weapons[@]} -eq 0 ]; then
                bash src/print-dialogue.sh "[Your party has no weapons in their inventory]"
                continue
            fi

            # Have the player select a party member to swap the weapon of
            echo
            echo "Whos weapon would you like to swap?"
            bash src/request-selection.sh ${party[@]}
            party_member=$(bash src/data/get-selection.sh)
            member_name=$(bash src/data/get-actor-info.sh $party_member "DISPLAY_NAME")

            # Have the player select a weapon from their inventory to swap
            echo
            echo "Which weapon would you like to give to $member_name?"
            bash src/request-selection.sh ${weapons[@]}
            new_weapon=$(bash src/data/get-selection.sh)

            # Give the character the weapon
            current_weapon=$(bash src/data/get-actor-info.sh $party_member "WEAPON")
            bash src/data/remove-from-inventory.sh $new_weapon
            bash src/data/save-actor-info.sh $party_member "WEAPON" $new_weapon

            # If the character already had a weapon, put it in the players inventory
            if [ ! $current_weapon == "none" ]; then
                bash src/data/add-to-inventory.sh $current_weapon
            fi
            ;;

        "swap armor")

            # Ensure the player has an armor in their inventory to swap
            if [ ${#armors[@]} -eq 0 ]; then
                bash src/print-dialogue.sh "[Your party has no armor in their inventory]"
                continue
            fi

            # Have the player select a party member to swap the armor of
            echo
            echo "Whos armor would you like to swap?"
            bash src/request-selection.sh ${party[@]}
            party_member=$(bash src/data/get-selection.sh)
            member_name=$(bash src/data/get-actor-info.sh $party_member "DISPLAY_NAME")

            # Have the player select a armor from their inventory to swap
            echo
            echo "Which armor would you like to give to $member_name?"
            bash src/request-selection.sh ${armors[@]}
            new_armor=$(bash src/data/get-selection.sh)

            # Give the character the armor
            current_armor=$(bash src/data/get-actor-info.sh $party_member "ARMOR")
            bash src/data/remove-from-inventory.sh $new_armor
            bash src/data/save-actor-info.sh $party_member "ARMOR" $new_armor

            # If the character already had a armor, put it in the players inventory
            if [ ! $current_armor == "none" ]; then
                bash src/data/add-to-inventory.sh $current_armor
            fi
            ;;

        "exit")
            menu_left=1
            ;;
    esac
done