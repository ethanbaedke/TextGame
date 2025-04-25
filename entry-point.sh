#!/bin/bash

clear

bash request-input.sh "start game" "exit game"

case $? in
    1)
        bash game.sh
        ;;
    2)
        echo
        echo "Thank you for playing!"
        echo
        ;;
esac