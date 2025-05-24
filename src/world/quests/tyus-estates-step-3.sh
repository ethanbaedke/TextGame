#!/bin/bash

# EXIT CODE: 1 if the party was knocked out during this quest

clear

party_characters=($(bash src/data/get-party-characters.sh))
player_display_name=$(bash src/data/get-actor-info.sh ${party_characters[0]} "DISPLAY_NAME")
leader_display_name=$(bash src/data/get-actor-info.sh libarun "DISPLAY_NAME")
bandit_display_name=$(bash src/data/get-actor-info.sh bandit "DISPLAY_NAME")

bash src/print-dialogue.sh "[You return to *$leader_display_name*]"
bash src/print-dialogue.sh "$player_display_name: I have defeated the *$bandit_display_name's* dwelling in the -Bandit Camp- south of here."
bash src/print-dialogue.sh "$leader_display_name: As promised, I shall journey alongside you."
bash src/print-dialogue.sh "$leader_display_name: I will be waiting at the -tavern-. Find me there whenever you wish to depart with me."

bash src/print-dialogue.sh "[*$leader_display_name* awards your party 20 gold for their bravery]"
bash src/data/modify-gold.sh 20

bash src/data/unlock-character.sh libarun
bash src/data/increment-quest-progress.sh tyus-estates

# Begin progress on libarun's individual quest
bash src/data/increment-quest-progress.sh libarun