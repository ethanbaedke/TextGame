#!/bin/bash

# EXIT CODE: 1 if the party was knocked out during this quest

clear

party_characters=($(bash src/data/get-party-characters.sh))
player_display_name=$(bash src/data/get-actor-info.sh ${party_characters[0]} "DISPLAY_NAME")
leader_display_name=$(bash src/data/get-actor-info.sh max "DISPLAY_NAME")

bash src/print-dialogue.sh "[You ride into town with the combat squad]"
bash src/print-dialogue.sh "[*$leader_display_name* looks upon the squad with relief]"
bash src/print-dialogue.sh "$leader_display_name: I'm glad to see you have all returned safely. Times are changing, you must be more careful."
bash src/print-dialogue.sh "$leader_display_name: I shall be departing on a journey with *$player_display_name*."
bash src/print-dialogue.sh "$leader_display_name: I hope to see all of you in good health when I return."

# Unlock and add max to the party
bash src/data/unlock-character.sh max
bash src/add-to-party.sh max
bash src/data/increment-quest-progress.sh schwartzville

# Begin progress on max's individual quest
bash src/data/increment-quest-progress.sh max