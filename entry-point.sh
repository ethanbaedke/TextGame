#!/bin/bash

clear

# Create the data folder if it doesn't exist
if [ ! -d "data" ]; then
    mkdir data
fi

# Create the selection-data file if it doesn't exist, which holds 20 bytes for the name of the last made selection
if [ ! -f "data/selection-data.bin" ]; then
    bash src/data/core/write-null.sh data/selection-data.bin 30 0
fi

program_running=1
while [ $program_running -ne 0 ]; do

    bash src/request-selection.sh "start game" "exit game"
    selection=$(bash src/data/get-selection.sh)

    case "$selection" in
        "start game")
            bash src/prepare-game.sh
            ;;
        "exit game")
            echo
            echo "Thank you for playing!"
            program_running=0
            ;;
    esac
done

echo