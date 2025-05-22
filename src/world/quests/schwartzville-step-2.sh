#!/bin/bash

# EXIT CODE: 1 if the party was knocked out during this quest

clear

plainsrunner_display_name=$(bash src/data/get-actor-info.sh plainsrunner "DISPLAY_NAME")
leader_display_name=$(bash src/data/get-actor-info.sh maxareth "DISPLAY_NAME")

bash src/print-dialogue.sh "[You hear a rumbling coming from trees on the horizon]"
bash src/print-dialogue.sh "[A group of panicked riders bursts fourth into the clearing]"
bash src/print-dialogue.sh "[You see them waving their hands at you, panicked]"
bash src/print-dialogue.sh "Rider: PLAINSRUNNERS! MOVE!"
bash src/print-dialogue.sh "[Without a moment to think, you see five furious beasts dart out of the trees, in close pursuit of the riders]"
bash src/print-dialogue.sh "[As the riders approach, one of the *$plainsrunner_display_name*'s split from the pack and begin dashing toward you]"

bash src/combat/enter-combat.sh plainsrunner plainsrunner-pup alpha-plainsrunner

# Combat lost
if [ $? -eq 1 ]; then
    exit 1
fi

# Combat won
bash src/print-dialogue.sh "[The riders circle back, having dealt with the remainder of the *$plainsrunner_display_name*'s]"
bash src/print-dialogue.sh "Rider: Thanks for helping us out back there! We were in quite a pinch."
bash src/print-dialogue.sh "Rider: Lets +return to -Schwartzville-+ and report to *$leader_display_name*"

bash src/data/increment-quest-progress.sh schwartzville