#!/bin/bash

# EXIT CODE: 1 if the party was wiped out in this area

# PROMPT: Fantasy forest river scene, clear flowing water reflecting sunlight through trees, smooth river stones, soft shadows, shimmering fish, magical atmosphere, high detail, fantasy concept art style.
bash src/display-image.sh "images/landscapes/river.png"

echo
echo "The river winds through the landscape like a living ribbon, its waters clear and swift, reflecting the dappled light of the forest canopy."
echo "Smooth stones line the banks."
read -p "The gentle gurgle of flowing water is broken only by the occasional splash of a silver fish or the rustle of unseen creatures watching from the shadows."

# Tyus Estates quest
tyus_estates_quest_progress=$(bash src/data/get-quest-progress.sh tyus-estates)
if [ $tyus_estates_quest_progress -eq 2 ]; then

    clear
    party_characters=($(bash src/data/get-party-characters.sh))
    player_display_name=$(bash src/data/get-actor-info.sh ${party_characters[0]} "DISPLAY_NAME")
    leader_display_name=$(bash src/data/get-actor-info.sh liberty "DISPLAY_NAME")
    bandit_display_name=$(bash src/data/get-actor-info.sh bandit "DISPLAY_NAME")

    bash src/print-dialogue.sh "[You come across the -Bandit Camp- menioned by *$leader_display_name*]"
    bash src/print-dialogue.sh "[You notice three *$bandit_display_name's* setting up barricades with branches from surrounding trees]"
    
    # Stat check
    bash src/request-party-stat-check-selection.sh "STRENGTH" "DEXTERITY" "INTELLIGENCE" "CHARISMA" "LUCK"
    selection=$(bash src/data/get-selection.sh)
    stat_check_character=$(bash src/data/get-highest-stat-party-character.sh $selection)
    stat_check_character_display_name=$(bash src/data/get-actor-info.sh $stat_check_character "DISPLAY_NAME")
    bash src/roll-stat-check.sh $stat_check_character $selection
    roll_result=$?
    case $selection in
        "STRENGTH")
            bash src/print-dialogue.sh "[*$stat_check_character_display_name* attempts to pick up a large rock to hurl at the bandits]"
            if [ $roll_result -eq 0 ]; then
                bash src/print-dialogue.sh "[*$stat_check_character_display_name* chucks the rock toward the -Bandit Camp- where it strikes and kills one of the *$bandit_display_name's*]"
                bash src/print-dialogue.sh "[The two remaining *$bandit_display_name's* charge you]"
            else
                bash src/print-dialogue.sh "[*$stat_check_character_display_name* drops the rock on their foot, hurting themselves and alerting the *$bandit_display_name's*]"
                bash src/modify-health.sh $stat_check_character "-1"
                bash src/print-dialogue.sh "[All three *$bandit_display_name's* charge you]"
            fi
            ;;
        "DEXTERITY")
            bash src/print-dialogue.sh "[*$stat_check_character_display_name* attempts to sneak up behind the bandits]"
            if [ $roll_result -eq 0 ]; then
                bash src/print-dialogue.sh "[*$stat_check_character_display_name* scurries into the -Bandit Camp- unnoticed and assasinated one of the *$bandit_display_name's*]"
                bash src/print-dialogue.sh "[The two remaining *$bandit_display_name's* charge you]"
            else
                bash src/print-dialogue.sh "[*$stat_check_character_display_name* is caught scurrying into the -Bandit Camp-]"
                bash src/print-dialogue.sh "[A quick arrow fired by one of the *$bandit_display_name's* scrapes the check of *$stat_check_character_display_name*]"
                bash src/modify-health.sh $stat_check_character "-1"
                bash src/print-dialogue.sh "[All three *$bandit_display_name's* charge you]"
            fi
            ;;
        "INTELLIGENCE")
            bash src/print-dialogue.sh "[*$stat_check_character_display_name* surveys the environment, looking for an edge over the *$bandit_display_name's*]"
            if [ $roll_result -eq 0 ]; then
                bash src/print-dialogue.sh "[*$stat_check_character_display_name* notices a conveniently hung supply crate overlooking the camp on a nearby tree]"
                bash src/print-dialogue.sh "[*$stat_check_character_display_name* cuts the support rope and the supply crate falls and kills one of the *$bandit_display_name's*]"
                bash src/print-dialogue.sh "[The two remaining *$bandit_display_name's* charge you]"
            else
                bash src/print-dialogue.sh "[*$stat_check_character_display_name* can't find anything useful in the -Bandit Camp-]"
                bash src/print-dialogue.sh "[While wasting time searching for a creative approach, *$stat_check_character_display_name* is noticed by the *$bandit_display_name's*]"
                bash src/print-dialogue.sh "[A quick arrow fired by one of the *$bandit_display_name's* scrapes the check of *$stat_check_character_display_name*]"
                bash src/modify-health.sh $stat_check_character "-1"
                bash src/print-dialogue.sh "[All three *$bandit_display_name's* charge you]"
            fi
            ;;
        "CHARISMA")
            bash src/print-dialogue.sh "[*$stat_check_character_display_name* approaches and attempts to decieve the *$bandit_display_name's* by pretending to be one of them]"
            if [ $roll_result -eq 0 ]; then
                bash src/print-dialogue.sh "[The *$bandit_display_name's* are thoroughly fooled, and while distracted in conversation, *$stat_check_character_display_name* attacks and takes out one of the *$bandit_display_name's*]"
                bash src/print-dialogue.sh "[The two remaining *$bandit_display_name's* charge you]"
            else
                bash src/print-dialogue.sh "[The *$bandit_display_name's* would never fall for such a cheap trick]"
                bash src/print-dialogue.sh "[One of the *$bandit_display_name's* catches *$stat_check_character_display_name* off guard and takes a slash at their leg]"
                bash src/modify-health.sh $stat_check_character "-1"
                bash src/print-dialogue.sh "[All three *$bandit_display_name's* charge you]"
            fi
            ;;
        "LUCK")
            bash src/print-dialogue.sh "[*$stat_check_character_display_name* attempts to make friends with the *$bandit_display_name's*]"
            if [ $roll_result -eq 0 ]; then
                bash src/print-dialogue.sh "[The *$bandit_display_name's* are not easily fooled]"
                bash src/print-dialogue.sh "[One of the *$bandit_display_name's* begins to move against *$stat_check_character_display_name* when the -River's- current catches one of their legs and sweeps them away]"
                bash src/print-dialogue.sh "[The two remaining *$bandit_display_name's* charge you]"
            else
                bash src/print-dialogue.sh "[The *$bandit_display_name's* are not easily fooled]"
                bash src/print-dialogue.sh "[One of the *$bandit_display_name's* catches *$stat_check_character_display_name* off guard and takes a slash at their leg]"
                bash src/modify-health.sh $stat_check_character "-1"
                bash src/print-dialogue.sh "[All three *$bandit_display_name's* charge you]"
            fi
            ;;
    esac

    if [ $roll_result -eq 1 ]; then
        bash src/combat/enter-combat.sh bandit
        if [ $? -eq 1 ]; then
            exit 1
        fi
    else
        bash src/combat/enter-combat.sh bandit
        if [ $? -eq 1 ]; then
            exit 1
        fi
    fi

    bash src/print-dialogue.sh "[The *$bandit_display_name's* bodies lie scattered before you]"
    bash src/print-dialogue.sh "$player_display_name: I'd better +return to the -Tyus Estates-+ and notify *$leader_display_name* that I've taken care of the *$bandit_display_name's* at the -Bandit Camp-]"

    bash src/data/increment-quest-progress.sh tyus-estates
    exit
fi

# RANDOM ENCOUNTERS

# 1/3 chance
chance=$((RANDOM % 3))

if [ $chance -gt 0 ]; then
    exit
fi

# Start one of the random encounters
encounter=$((RANDOM % 3))
case $encounter in
    0)
        bash src/print-dialogue.sh "[You have stumbled across plains random encounter 1]"
        ;;
    1)
        bash src/print-dialogue.sh "[You have stumbled across plains random encounter 2]"
        ;;
    2)
        bash src/print-dialogue.sh "[You have stumbled across plains random encounter 3]"
        ;;
esac