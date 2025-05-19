#!/bin/bash

# EXIT CODE: 1 if the party was wiped out in this area

# PROMPT: Vast fantasy plains under a wide sky, golden grasses swaying in the wind, scattered wildflowers and ancient standing stones, soft sunlight, open landscape, ethereal and mystical mood, high detail, fantasy concept art style.
bash src/display-image.sh "images/landscapes/plains.png"

echo
echo "Endless plains stretch to the horizon, covered in golden grasses that sway like waves under a wide, cloud-dappled sky."
echo "Occasional clusters of wildflowers and standing stones break the monotony, whispering of ancient rites and forgotten paths."
read -p "The wind carries the scent of earth and freedom, stirring memories of old battles and roaming spirits."

# Schwartzville quest
schwartzville_quest_progress=$(bash src/data/get-quest-progress.sh schwartzville)
if [ $schwartzville_quest_progress -eq 2 ]; then
    
    clear
    plainsrunner_display_name=$(bash src/data/get-actor-info.sh plainsrunner "DISPLAY_NAME")
    leader_display_name=$(bash src/data/get-actor-info.sh max "DISPLAY_NAME")

    bash src/print-dialogue.sh "[You hear a rumbling coming from trees on the horizon]"
    bash src/print-dialogue.sh "[A group of panicked riders bursts fourth into the clearing]"
    bash src/print-dialogue.sh "[You see them waving their hands at you, panicked]"
    bash src/print-dialogue.sh "Rider: PLAINSRUNNERS! MOVE!"
    bash src/print-dialogue.sh "[Without a moment to think, you see five furious beasts dart out of the trees, in close pursuit of the riders]"
    bash src/print-dialogue.sh "[As the riders approach, one of the *$plainsrunner_display_name*'s split from the pack and begin dashing toward you]"

    bash src/combat/enter-combat.sh plainsrunner

    # Combat lost
    if [ $? -eq 1 ]; then
        exit 1
    fi

    # Combat won
    bash src/print-dialogue.sh "[The riders circle back, having dealt with the remainder of the *$plainsrunner_display_name*'s]"
    bash src/print-dialogue.sh "Rider: Thanks for helping us out back there! We were in quite a pinch."
    bash src/print-dialogue.sh "Rider: Lets +return to -Schwartzville-+ and report to *$leader_display_name*"

    bash src/data/increment-quest-progress.sh schwartzville
    exit
fi

# RANDOM ENCOUNTERS

# 1/3 chance
chance=$((RANDOM % 1))

if [ $chance -gt 0 ]; then
    exit
fi

# Start one of the random encounters
clear
encounter=$((RANDOM % 2))
case $encounter in
    0)
        character=$(bash src/data/get-random-party-character.sh)
        name=$(bash src/data/get-actor-info.sh $character "DISPLAY_NAME")

        bash src/print-dialogue.sh "[While traveling through the -plains-, *$name* notices some berries of various colors]"

        bash src/request-selection.sh "try some berries" "move on"
        selection=$(bash src/data/get-selection.sh)
        case $selection in

            "try some berries")
                bash src/request-individual-stat-check-selection.sh $character "INTELLIGENCE" "LUCK"
                selection=$(bash src/data/get-selection.sh)
                bash src/roll-stat-check.sh $character $selection
                roll_result=$?
                case $selection in

                    "INTELLIGENCE")
                        bash src/print-dialogue.sh "[*$name* studies the berries, trying to discern the properties of the different colors]"
                        if [ $roll_result -eq 0 ]; then
                            bash src/print-dialogue.sh "[*$name* comes to the conclusion that the green berries have healing properties, while the red berries are poisonous]"
                            bash src/print-dialogue.sh "[*$name* eats the green berries]"
                            bash src/modify-health.sh $character "1"
                        else
                            bash src/print-dialogue.sh "[*$name* comes to the conclusion that the red berries have healing properties, while the green berries are poisonous]"
                            bash src/print-dialogue.sh "[*$name* eats the red berries]"
                            bash src/modify-health.sh $character "-1"
                        fi
                        ;;

                    "LUCK")
                        bash src/print-dialogue.sh "[*$name* can't tell the berries apart, but can tell which look the tastiest]"
                        if [ $roll_result -eq 0 ]; then
                            bash src/print-dialogue.sh "[*$name* eats the plump green berries]"
                            bash src/modify-health.sh $character "1"
                        else
                            bash src/print-dialogue.sh "[*$name* eats the plump red berries]"
                            bash src/modify-health.sh $character "-1"
                        fi
                        ;;
                esac
                ;;

            "move on")
                bash src/print-dialogue.sh "[*$name* leaves the berries alone]"
                ;;
        esac
        ;;
    1)
        plainsrunner_name=$(bash src/data/get-actor-info.sh plainsrunner "DISPLAY_NAME")
        party=($(bash src/data/get-party-characters.sh))
        bash src/print-dialogue.sh "[While traveling through the -plains-, your party notices a pack of three *$plainsrunner_name's* sleeping in some tall brush]"

        bash src/request-selection.sh "attack" "sneak away"
        selection=$(bash src/data/get-selection.sh)
        case $selection in

            "attack")
                bash src/request-compound-stat-check-selection.sh "STRENGTH" "LUCK"
                selection=$(bash src/data/get-selection.sh)
                bash src/roll-compound-stat-check.sh $selection ${party[@]}
                roll_result=$?
                case $selection in

                    "STRENGTH")
                        bash src/print-dialogue.sh "[Your party jumps on one of the *$plainsrunner_name's*]"
                        if [ $roll_result -eq 0 ]; then
                            bash src/print-dialogue.sh "[They beat the *$plainsrunner_name* to death with their bare hands]"
                            bash src/print-dialogue.sh "[The remaining two *$plainsrunner_name's* jolt up and charge at your party]"
                        else
                            bash src/print-dialogue.sh "[They're far too weak to kill the *$plainsrunner_name*]"
                            bash src/print-dialogue.sh "[All three *$plainsrunner_name's* jolt up and charge at your party]"
                        fi
                        ;;

                    "LUCK")
                        bash src/print-dialogue.sh "[Your party runs at the *$plainrunner_name's* screaming]"
                        if [ $roll_result -eq 0 ]; then
                            bash src/print-dialogue.sh "[One of the *$plainsrunner_name's* wakes up with such shock it has a heart attack and dies]"
                            bash src/print-dialogue.sh "[The remaining two *$plainsrunner_name's* jolt up and charge at your party]"
                        else
                            bash src/print-dialogue.sh "[The *$plainsrunner_name's* jolt up unphased]"
                        fi
                        ;;
                esac

                if [ $roll_result -eq 1 ]; then
                    bash src/combat/enter-combat.sh plainsrunner
                    if [ $? -eq 1 ]; then
                        exit 1
                    fi
                else
                    bash src/combat/enter-combat.sh plainsrunner
                    if [ $? -eq 1 ]; then
                        exit 1
                    fi
                fi

                bash src/print-dialogue.sh "[The *$plainsrunner_name's* bodies lie still in the grass]"
                ;;

            "sneak away")
                bash src/request-compound-stat-check-selection.sh "DEXTERITY" "INTELLIGENCE"
                selection=$(bash src/data/get-selection.sh)
                bash src/roll-compound-stat-check.sh $selection ${party[@]}
                roll_result=$?
                case $selection in

                    "DEXTERITY")
                        bash src/print-dialogue.sh "[Your party attempts to tip-toe away from the *$plainsrunner_name's*]"
                        if [ $roll_result -eq 0 ]; then
                            bash src/print-dialogue.sh "[The queitness of their footsteps allows for a clean getaway]"
                        else
                            bash src/print-dialogue.sh "[The thumping of their massive toes wakes the *$plainsrunner_name's*]"
                        fi
                        ;;

                    "INTELLIGENCE")
                        bash src/print-dialogue.sh "[Your party members kneel down and begin tossing rocks to distract the *$plainsrunner_name's*]"
                        if [ $roll_result -eq 0 ]; then
                            bash src/print-dialogue.sh "[The *$plainsrunner_name's* wake up confused and begin investigating the source of the strange noise]"
                            bash src/print-dialogue.sh "[Your party makes a clean getaway]"
                        else
                            bash src/print-dialogue.sh "[The plan to throw the rocks is poorly executed and one of them hits a sleeping *$plainsrunner_name*]"
                            bash src/print-dialogue.sh "[The three sleeping *$plainsrunner_name's* wake up and begin charging toward you]"
                        fi
                        ;;
                esac

                if [ $roll_result -eq 1 ]; then
                    bash src/combat/enter-combat.sh plainsrunner
                    if [ $? -eq 1 ]; then
                        exit 1
                    fi
                    bash src/print-dialogue.sh "[The *$plainsrunner_name's* bodies lie still in the grass]"
                fi
                ;;
        esac
        ;;
esac
