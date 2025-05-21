#!/bin/bash

# EXIT CODE: 1 if the party was knocked out during this encounter

#clear

character=$(bash src/data/get-random-party-character.sh)
name=$(bash src/data/get-actor-info.sh $character "DISPLAY_NAME")

bash src/print-dialogue.sh "[While traveling through the -plains-, *$name* notices some berries of various colors]"

bash src/request-selection.sh "try some berries" "move on"
selection=$(bash src/data/get-selection.sh)
case $selection in

    "try some berries")
        bash src/request-individual-stat-check-selection.sh $character "INTELLIGENCE" "LUCK"
        selection=$(bash src/data/get-selection.sh)
        bash src/roll-stat-check.sh $character $selection
        roll_result=$?
        case $selection in

            "INTELLIGENCE")
                bash src/print-dialogue.sh "[*$name* studies the berries, trying to discern the properties of the different colors]"
                if [ $roll_result -eq 0 ]; then
                    bash src/print-dialogue.sh "[*$name* comes to the conclusion that the green berries have healing properties, while the red berries are poisonous]"
                    bash src/print-dialogue.sh "[*$name* eats the green berries]"
                    bash src/modify-temp-health.sh $character "1"
                else
                    bash src/print-dialogue.sh "[*$name* comes to the conclusion that the red berries have healing properties, while the green berries are poisonous]"
                    bash src/print-dialogue.sh "[*$name* eats the red berries]"
                    bash src/modify-temp-health.sh $character "-1"
                fi
                ;;

            "LUCK")
                bash src/print-dialogue.sh "[*$name* can't tell the berries apart, but can tell which look the tastiest]"
                if [ $roll_result -eq 0 ]; then
                    bash src/print-dialogue.sh "[*$name* eats the plump green berries]"
                    bash src/modify-temp-health.sh $character "1"
                else
                    bash src/print-dialogue.sh "[*$name* eats the plump red berries]"
                    bash src/modify-temp-health.sh $character "-1"
                fi
                ;;
        esac
        ;;

    "move on")
        bash src/print-dialogue.sh "[*$name* leaves the berries alone]"
        ;;
esac