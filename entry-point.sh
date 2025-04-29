#!/bin/bash

clear

program_running=1
while [ $program_running -ne 0 ]; do

    echo
    bash src/request-selection.sh "start game" "exit game"

    case $? in
        1)
            bash src/prepare-game.sh
            ;;
        2)
            echo
            echo "Thank you for playing!"
            program_running=0
            ;;
    esac
done

echo