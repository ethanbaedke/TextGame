#!/bin/bash

# Asking the user to install catimg
if ! command -v catimg >/dev/null 2>&1; then
    echo
    echo "catimg may be installed for visuals."
    echo "Install now?"
    bash src/request-selection.sh "y" "n"
    if [ $? -eq 1 ]; then
        if command -v apt >/dev/null 2>&1; then
            sudo apt update && sudo apt install catimg
        elif command -v pacman >/dev/null 2>&1; then
            sudo pacman -Sy catimg
        elif command -v brew >/dev/null 2>&1; then
            brew install catimg
        else
            echo "Unsupported package manager. For visuals, install catimg manually."
        fi
    fi
fi

bash src/data/verify-file-existence.sh data/actors/player-data.bin > /dev/null 2>&1
# There is already player-data present on this computer
if [ $? -eq 0 ]; then
    echo
    echo "The following player data was found on this device..."
    bash src/print-character-data-full.sh "player"

    # Does the user want to continue their adventure?
    echo
    echo "Would you like to continue your adventure?"
    bash "src/request-selection.sh" "yes" "no"

    case $? in
    1)
        bash src/game.sh
        ;;
    2)
        # Does the user want to create a new character?
        echo
        echo "Would you like to create a new character?"
        bash "src/request-selection.sh" "yes" "no"

        case $? in
            1)
                bash src/data/erase-data.sh
                bash src/data/verify-data.sh
                bash "src/create-character.sh"
                echo
                echo "Here is the character you created..."
                bash src/print-character-data-full.sh "player"

                # Is the user ready to begin their adventure?
                echo
                echo "Are you ready to begin your adventure?"
                bash "src/request-selection.sh" "yes" "no"

                case $? in
                    1)
                        bash src/game.sh
                        ;;
                    2)
                        echo "Okay! Returning to the main menu."
                        ;;
                esac
                ;;
            2)
                echo
                echo "Okay! Returning to the main menu."
                ;;
        esac
        ;;
    esac

# There is no character-data present on this computer
else
    # Does the user want to create a new character?
    echo
    echo "No player data was found on this device. Would you like to create a new character?"
    bash "src/request-selection.sh" "yes" "no"

    case $? in
        1)
            bash src/data/erase-data.sh
            bash src/data/verify-data.sh
            bash "src/create-character.sh"

            # Is the user ready to begin their adventure?
            echo
            echo "Are you ready to begin your adventure?"
            bash "src/request-selection.sh" "yes" "no"

            case $? in
                1)
                    bash src/game.sh
                    ;;
                2)
                    echo
                    echo "Okay! Returning to the main menu."
                    ;;
            esac
            ;;
        2)
            echo
            echo "Okay! Returning to main menu."
            ;;
    esac
fi