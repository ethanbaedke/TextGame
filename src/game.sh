#!/bin/bash

echo
bash "src/request-selection.sh" "create character" "exit to main menu"

case $? in
    1)
        bash "src/create-character.sh"
        ;;
    2)
        exit
esac