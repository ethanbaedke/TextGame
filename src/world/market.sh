#!/bin/bash

# PARAMS: ITEM_NAME ITEM_NAME ITEM_NAME ...

clear

# Ensure all input items exist
for item in $@; do
    if [ ! -f data/weapons/$item-data.bin ] && [ ! -f data/armor/$item-data.bin ]; then
        echo "ERROR! $0 called but $item-data.bin could not be found in data/weapons or data/armor."
        exit 1
    fi
done

bash src/print-dialogue.sh "[Your party enters the market]"

market_left=0
while [ $market_left -eq 0 ]; do

    clear

    player_gold=$(bash src/data/get-gold.sh)

    # Print the market items with their prices
    echo
    echo "MARKET"
    for item in $@; do
        name=""
        value=0
        if [ -f data/weapons/$item-data.bin ]; then
            name=$(bash src/data/get-weapon-info.sh $item "DISPLAY_NAME")
            value=$(bash src/data/get-weapon-info.sh $item "VALUE")
        else
            name=$(bash src/data/get-armor-info.sh $item "DISPLAY_NAME")
            value=$(bash src/data/get-armor-info.sh $item "VALUE")
        fi
        price=$((value + 1))

        # Color the price based on whether the player can afford it or not
        if [ $price -lt $player_gold ]; then
            echo -e "$name [\\e[32m$price gold\\e[0m]"
        else
            echo -e "$name [\\e[31m$price gold\\e[0m]"
        fi
    done

    # Print the players gold and their inventory items
    echo
    echo "INVENTORY"
    echo "Gold: $player_gold"
    inventory_items=($(bash src/data/get-inventory.sh))
    for item in ${inventory_items[@]}; do
        name=""
        if [ -f data/weapons/$item-data.bin ]; then
            name=$(bash src/data/get-weapon-info.sh $item "DISPLAY_NAME")
        else
            name=$(bash src/data/get-armor-info.sh $item "DISPLAY_NAME")
        fi
        echo "$name"
    done

    echo
    bash src/request-selection.sh "buy" "sell" "leave"
    selection=$(bash src/data/get-selection.sh)
    case $selection in

        "buy")

            # Ensure the player has space in their inventory for the item
            bash src/data/get-inventory-full.sh
            if [ $? -eq 1 ]; then
                bash src/print-dialogue.sh "[Your inventory is full, clear out some items before buying more]"
                continue
            fi

            # Have the player select an item for purchase
            echo
            bash src/request-selection.sh $@ "back"
            selection=$(bash src/data/get-selection.sh)

            # Handle the player returning to the main market menu
            if [ $selection == "back" ]; then
                continue
            fi

            # Get info about the item the player selected
            selected_item=$selection
            name=""
            value=0
            if [ -f data/weapons/$selected_item-data.bin ]; then
                name=$(bash src/data/get-weapon-info.sh $selected_item "DISPLAY_NAME")
                value=$(bash src/data/get-weapon-info.sh $selected_item "VALUE")
            else
                name=$(bash src/data/get-armor-info.sh $selected_item "DISPLAY_NAME")
                value=$(bash src/data/get-armor-info.sh $selected_item "VALUE")
            fi
            price=$((value + 1))

            # Ensure the player can afford the item
            if [ $price -gt $player_gold ]; then
                bash src/print-dialogue.sh "[Your party cannot afford the $name]"
                continue
            fi

            # Ensure the player wants to buy the item
            echo
            echo "Are you sure you want to buy the $name for $price gold?"
            bash src/request-selection.sh "yes" "no"
            selection=$(bash src/data/get-selection.sh)

            if [ $selection == "yes" ]; then
                bash src/data/add-to-inventory.sh $selected_item
                bash src/data/modify-gold.sh -$price
            fi
            ;;

        "sell")

            # Ensure the players inventory is not empty
            if [ ${#inventory_items} -eq 0 ]; then
                bash src/print-dialogue.sh "[There are no items in your inventory]"
                continue
            fi

            echo
            bash src/request-selection.sh ${inventory_items[@]} "back"
            selection=$(bash src/data/get-selection.sh)

            if [ $selection == "back" ]; then
                continue
            fi

            # Get info about the item the player selected
            selected_item=$selection
            name=""
            value=0
            if [ -f data/weapons/$selected_item-data.bin ]; then
                name=$(bash src/data/get-weapon-info.sh $selected_item "DISPLAY_NAME")
                value=$(bash src/data/get-weapon-info.sh $selected_item "VALUE")
            else
                name=$(bash src/data/get-armor-info.sh $selected_item "DISPLAY_NAME")
                value=$(bash src/data/get-armor-info.sh $selected_item "VALUE")
            fi
            price=$((value - 1))

            # Ensure the player wants to sell the item
            echo
            echo "Your party is offered $price gold for the $name."
            bash src/request-selection.sh "accept" "decline"
            selection=$(bash src/data/get-selection.sh)

            if [ $selection == "accept" ]; then
                bash src/data/remove-from-inventory.sh $selected_item
                bash src/data/modify-gold.sh $price
            fi
            ;;

        "leave")
            bash src/print-dialogue.sh "[Your party leaves the market]"
            market_left=1
            ;;
    esac
done