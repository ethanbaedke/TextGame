#!/bin/bash

# PARAMS: CHARACTER_NAME AMOUNT

name=$(bash src/data/get-actor-info.sh $1 "DISPLAY_NAME")
experience=$(bash src/data/get-actor-info.sh $1 "EXPERIENCE")

bash src/print-dialogue.sh "[*$name* gained $2 points of experience]"

new_experience=$(($experience + $2))

# Make sure experience is capped at 255
if [ $new_experience -gt 255 ]; then
    new_experience=255
fi

bash src/data/save-actor-info.sh $1 "EXPERIENCE" $new_experience

while [ true ]; do
    level=$(bash src/data/get-actor-info.sh $1 "LEVEL")
    case $level in
        1)
            if [ $new_experience -ge 2 ]; then
                bash src/level-up.sh $1
                continue
            fi
            ;;
        2)
            if [ $new_experience -ge 4 ]; then
                bash src/level-up.sh $1
                continue
            fi
            ;;
        3)
            if [ $new_experience -ge 8 ]; then
                bash src/level-up.sh $1
                continue
            fi
            ;;
        4)
            if [ $new_experience -ge 16 ]; then
                bash src/level-up.sh $1
                continue
            fi
            ;;
        5)
            if [ $new_experience -ge 32 ]; then
                bash src/level-up.sh $1
                continue
            fi
            ;;
        6)
            if [ $new_experience -ge 64 ]; then
                bash src/level-up.sh $1
                continue
            fi
            ;;
        7)
            if [ $new_experience -ge 128 ]; then
                bash src/level-up.sh $1
                continue
            fi
            ;;
        8)
            if [ $new_experience -eq 255 ]; then
                bash src/level-up.sh $1
                continue
            fi
            ;;
    esac
    break
done