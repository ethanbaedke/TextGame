#!/bin/bash

echo

# There is already character data on this device
if [ -f "data/character-data.bin" ]; then
    echo "Character data was found on this device. Would you like to continue your adventure?"
    bash "src/request-selection.sh" "yes" "no"

    case $? in
    1)
        echo
        echo "NOT YET IMPLEMENTED (continue adventure)"
        ;;
    2)
        echo
        echo "Would you like to create a new character?"

        bash "src/request-selection.sh" "yes" "no"

        case $? in
            1)
                bash "src/create-character.sh"
                echo
                echo "NOT YET IMPLEMENTED (start adventure)"
                ;;
            2)
                echo
                echo "Okay! Returning to main menu."
                ;;
        esac
        ;;
    esac

#There is not already character data on this device
else
    echo "No character data was found on this device. Would you like to create a new character?"
    bash "src/request-selection.sh" "yes" "no"

    case $? in
        1)
            bash "src/create-character.sh"
            echo
            echo "NOT YET IMPLEMENTED (start adventure)"
            ;;
        2)
            echo
            echo "Okay! Returning to main menu."
            ;;
    esac
fi