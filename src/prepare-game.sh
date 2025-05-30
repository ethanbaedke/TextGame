#!/bin/bash

# Asking the user to install catimg
if ! command -v catimg >/dev/null 2>&1; then
    echo
    echo "catimg may be installed for visuals."
    echo "Install now?"
    bash src/request-selection.sh "y" "n"
    selection=$(bash src/data/get-selection.sh)

    if [ "$selection" == "y" ]; then
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

bash src/data/verify-file-existence.sh data/quest-data.bin > /dev/null 2>&1
# There is already quest-data present on this computer
if [ $? -eq 0 ]; then
    # Does the user want to continue their adventure?
    echo
    echo "Quest data was found on this computer, would you like to continue your adventure?"
    bash "src/request-selection.sh" "yes" "no"
    selection=$(bash src/data/get-selection.sh)
    
    case "$selection" in
    "yes")
        bash src/game.sh
        ;;
    "no")
        # Does the user want to start a new adventure?
        echo
        echo "Would you like to start a new adventure? (this will delete your old save data)"
        bash "src/request-selection.sh" "yes" "no"
        selection=$(bash src/data/get-selection.sh)

        case "$selection" in
            "yes")
                bash src/data/erase-data.sh
                echo
                echo "Creating save data..."
                bash src/data/verify-data.sh
                bash src/game.sh
                ;;
            "no")
                echo
                echo "Okay! Returning to the main menu."
                ;;
        esac
        ;;
    esac

# There is no quest-data present on this computer
else
    # Does the user want to start a new adventure?
    echo
    echo "No save data was found on this device. Would you like to start a new adventure?"
    bash "src/request-selection.sh" "yes" "no"
    selection=$(bash src/data/get-selection.sh)

    case "$selection" in
        "yes")
            bash src/data/erase-data.sh
            echo
            echo "Creating save data..."
            bash src/data/verify-data.sh
            bash src/game.sh
            ;;
        "no")
            echo
            echo "Okay! Returning to main menu."
            ;;
    esac
fi