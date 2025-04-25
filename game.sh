#!/bin/bash

echo
bash request-selection.sh "create character" "exit to main menu"

case $? in
    1)
        bash create-character.sh
        ;;
    2)
        exit
esac