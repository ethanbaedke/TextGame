#!/bin/bash

# EXIT CODE: 1 if the party was knocked out during this quest

clear

party_characters=($(bash src/data/get-party-characters.sh))
player_display_name=$(bash src/data/get-actor-info.sh ${party_characters[0]} "DISPLAY_NAME")
leader_display_name=$(bash src/data/get-actor-info.sh liberty "DISPLAY_NAME")

bash src/print-dialogue.sh "[You are taken to the leader of the -Tyus Estates-]"
bash src/print-dialogue.sh "Queensguard: *$leader_display_name*, there is an *$player_display_name* here for you."
bash src/print-dialogue.sh "$player_display_name: *$leader_display_name*, there is a tyrant rising in the southeast. I have come to rally support."
bash src/print-dialogue.sh "[*$leader_display_name* consideres your proposition]"
bash src/print-dialogue.sh "$leader_display_name: As honored as I would be to help you in such a noble cause, we have problems of our own."
bash src/print-dialogue.sh "$leader_display_name: The -Tyus Estates- academy has been educating the youth of the southern town of -Linksburg- for decades."
bash src/print-dialogue.sh "$leader_display_name: Recently, -Bandits- have set up camp on the river south, blocking the route between the -Tyus Estates- and -Linksburg-."
bash src/print-dialogue.sh "$leader_display_name: If you +take out the bandits on the river south of the -Tyus Estates-+, I will join you in your cause."

bash src/data/increment-quest-progress.sh tyus-estates