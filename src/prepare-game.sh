#!/bin/bash

erase_data() {
    find data -type f -delete
}

echo

# There is already player-data present on this computer
if [ -f "data/characters/player-data.bin" ]; then
    echo "The following player data was found on this device..."
    bash src/print-character-data-full.sh "player"

    # Does the user want to continue their adventure?
    echo
    echo "Would you like to continue your adventure?"
    bash "src/request-selection.sh" "yes" "no"

    case $? in
    1)
        bash src/verify-npc-data.sh
        bash src/game.sh
        ;;
    2)
        # Does the user want to create a new character?
        echo
        echo "Would you like to create a new character?"
        bash "src/request-selection.sh" "yes" "no"

        case $? in
            1)
                erase_data
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
                        bash src/verify-npc-data.sh
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
    echo "No player data was found on this device. Would you like to create a new character?"
    bash "src/request-selection.sh" "yes" "no"

    case $? in
        1)
            erase_data
            bash "src/create-character.sh"

            # Is the user ready to begin their adventure?
            echo
            echo "Are you ready to begin your adventure?"
            bash "src/request-selection.sh" "yes" "no"

            case $? in
                1)
                    bash src/verify-npc-data.sh
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