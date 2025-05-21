#!/bin/bash

# EXIT CODE: 1 if the party was knocked out during this quest

clear

party_characters=($(bash src/data/get-party-characters.sh))
player_display_name=$(bash src/data/get-actor-info.sh ${party_characters[0]} "DISPLAY_NAME")
leader_display_name=$(bash src/data/get-actor-info.sh max "DISPLAY_NAME")

bash src/print-dialogue.sh "[You are taken to the leader of -Schwartzville-]"
bash src/print-dialogue.sh "Soldier: *$leader_display_name*, this is *$player_display_name*, they have requested your attention."
bash src/print-dialogue.sh "$player_display_name: *$leader_display_name*, there is a tyrant rising in the southeast. I have come to rally support."
bash src/print-dialogue.sh "[*$leader_display_name* consideres your proposition]"
bash src/print-dialogue.sh "$leader_display_name: I believe your cause is worthy, however, I must stay here and protect my town."
bash src/print-dialogue.sh "$leader_display_name: You see, our combat squad left on patrol this morning and has yet to return. I cannot leave the town defenseless."
bash src/print-dialogue.sh "$leader_display_name: If you +find the combat squad+ and return with them safely, you will have my blade at your side."
bash src/print-dialogue.sh "$leader_display_name: They were last seen +patroling the plains+ surrounding this town."

bash src/data/increment-quest-progress.sh schwartzville