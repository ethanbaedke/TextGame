#!/bin/bash

# EXIT CODE: 1 if the party was knocked out during this encounter

#clear

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
            bash src/combat/enter-combat.sh plainsrunner plainsrunner-pup alpha-plainsrunner
            if [ $? -eq 1 ]; then
                exit 1
            fi
        else
            bash src/combat/enter-combat.sh plainsrunner-pup alpha-plainsrunner
            if [ $? -eq 1 ]; then
                exit 1
            fi
        fi

        bash src/print-dialogue.sh "[The *$plainsrunner_name's* bodies lie still in the grass]"
        bash src/distribute-experience.sh 2
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
            bash src/combat/enter-combat.sh plainsrunner plainsrunner-pup alpha-plainsrunner
            if [ $? -eq 1 ]; then
                exit 1
            fi
            bash src/print-dialogue.sh "[The *$plainsrunner_name's* bodies lie still in the grass]"
            bash src/distribute-experience.sh 2
        else
            bash src/distribute-experience.sh 1
        fi
        ;;
esac