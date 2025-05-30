#!/bin/bash

# PARAMS: MENU_NAME

case $1 in
    "PRINT_DIALOGUE")
        value=$(bash src/data/core/read-byte.sh data/help-menu-data.bin 0)
        if [ $value -eq 0 ]; then
            value=$(bash src/data/core/write-byte.sh data/help-menu-data.bin 1 0)
            echo
            echo -e "\\e[33m(HINT: press ENTER to continue)\\e[0m"
        fi
        ;;
    "TRIGGER_ENCOUNTER")
        value=$(bash src/data/core/read-byte.sh data/help-menu-data.bin 1)
        if [ $value -eq 0 ]; then
            value=$(bash src/data/core/write-byte.sh data/help-menu-data.bin 1 1)
            echo
            echo -e "\\e[33m(HINT: when traveling, your party will sometimes stumble upon random encounters)\\e[0m"
        fi
        ;;
    "EQUIPMENT_MENU")
        value=$(bash src/data/core/read-byte.sh data/help-menu-data.bin 2)
        if [ $value -eq 0 ]; then
            value=$(bash src/data/core/write-byte.sh data/help-menu-data.bin 1 2)
            echo
            echo -e "\\e[33m(HINT: this is where you can swap equipment between your inventory and characters in your party)\\e[0m"
        fi
        ;;
    "PRINT_MAP")
        value=$(bash src/data/core/read-byte.sh data/help-menu-data.bin 3)
        if [ $value -eq 0 ]; then
            value=$(bash src/data/core/write-byte.sh data/help-menu-data.bin 1 3)
            echo
            echo -e "\\e[33m(HINT: the @ symbol denotes the parties current position on the map)\\e[0m"
            echo -e "\\e[33m(HINT: the colored squares represent the type of area)\\e[0m"
            echo -e "\\e[33m(HINT: the ? symbol appears over areas that have yet to be explored)\\e[0m"
        fi
        ;;
    "PARTY_MENU")
        value=$(bash src/data/core/read-byte.sh data/help-menu-data.bin 4)
        if [ $value -eq 0 ]; then
            value=$(bash src/data/core/write-byte.sh data/help-menu-data.bin 1 4)
            echo
            echo -e "\\e[33m(HINT: this is where you can view your party and information about characters in your party)\\e[0m"
        fi
        ;;
    "INDIVIDUAL_STAT_CHECK")
        value=$(bash src/data/core/read-byte.sh data/help-menu-data.bin 5)
        if [ $value -eq 0 ]; then
            value=$(bash src/data/core/write-byte.sh data/help-menu-data.bin 1 5)
            echo
            echo -e "\\e[33m(HINT: during some quests and encounters, a character will have to make an individual stat check)\\e[0m"
            echo -e "\\e[33m(HINT: only the single character displayed next to each stat will be tested in the check)\\e[0m"
            echo -e "\\e[33m(HINT: the higher the characters value in a particular stat, the more likely they are to pass the check)\\e[0m"
        fi
        ;;
    "COMPOUND_STAT_CHECK")
        value=$(bash src/data/core/read-byte.sh data/help-menu-data.bin 6)
        if [ $value -eq 0 ]; then
            value=$(bash src/data/core/write-byte.sh data/help-menu-data.bin 1 6)
            echo
            echo -e "\\e[33m(HINT: during some quests and encounters, the party will have to make a group stat check)\\e[0m"
            echo -e "\\e[33m(HINT: every character in the party will be tested in the check)\\e[0m"
            echo -e "\\e[33m(HINT: the higher the parties combined value in a particular stat, the more likely they are to pass the check)\\e[0m"
        fi
        ;;
    "LEVEL_UP")
        value=$(bash src/data/core/read-byte.sh data/help-menu-data.bin 7)
        if [ $value -eq 0 ]; then
            value=$(bash src/data/core/write-byte.sh data/help-menu-data.bin 1 7)
            echo
            echo -e "\\e[33m(HINT: characters in your party level up once they have gained enough experience)\\e[0m"
            echo -e "\\e[33m(HINT: each level, a character can increment one of their stats)\\e[0m"
        fi
        ;;
    "MARKET")
        value=$(bash src/data/core/read-byte.sh data/help-menu-data.bin 8)
        if [ $value -eq 0 ]; then
            value=$(bash src/data/core/write-byte.sh data/help-menu-data.bin 1 8)
            echo
            echo -e "\\e[33m(HINT: this is where you can buy equipment from the current town or vendor, and sell equipment from your inventory)\\e[0m"
        fi
        ;;
    "TAVERN")
        value=$(bash src/data/core/read-byte.sh data/help-menu-data.bin 9)
        if [ $value -eq 0 ]; then
            value=$(bash src/data/core/write-byte.sh data/help-menu-data.bin 1 9)
            echo
            echo -e "\\e[33m(HINT: this is where you can add or swap unlocked characters in your party)\\e[0m"
        fi
        ;;
    "COMBAT_INFO")
        value=$(bash src/data/core/read-byte.sh data/help-menu-data.bin 10)
        if [ $value -eq 0 ]; then
            value=$(bash src/data/core/write-byte.sh data/help-menu-data.bin 1 10)
            echo
            echo -e "\\e[33m(HINT: the yellow highlight displays whos turn it is)\\e[0m"
        fi
        ;;
    "COMBAT_STRENGTH")
        value=$(bash src/data/core/read-byte.sh data/help-menu-data.bin 11)
        if [ $value -eq 0 ]; then
            value=$(bash src/data/core/write-byte.sh data/help-menu-data.bin 1 11)
            echo
            echo -e "\\e[33m(HINT: occasionally, an attack will critical hit, dealing double the base damage)\\e[0m"
            echo -e "\\e[33m(HINT: a higher STRENGTH increases the chance to critical hit)\\e[0m"
        fi
        ;;
    "COMBAT_DEXTERITY")
        value=$(bash src/data/core/read-byte.sh data/help-menu-data.bin 12)
        if [ $value -eq 0 ]; then
            value=$(bash src/data/core/write-byte.sh data/help-menu-data.bin 1 12)
            echo
            echo -e "\\e[33m(HINT: occasionally, a combatant will dodge and attack entirely)\\e[0m"
            echo -e "\\e[33m(HINT: a higher DEXTERITY increases the chance to dodge)\\e[0m"
        fi
        ;;
    "COMBAT_INTELLIGENCE")
        value=$(bash src/data/core/read-byte.sh data/help-menu-data.bin 13)
        if [ $value -eq 0 ]; then
            value=$(bash src/data/core/write-byte.sh data/help-menu-data.bin 1 13)
            echo
            echo -e "\\e[33m(HINT: the order of combat is decided by how mentally quick each combatant is)\\e[0m"
            echo -e "\\e[33m(HINT: a higher INTELLIGENCE allows a combatant to act sooner in combat)\\e[0m"
        fi
        ;;
    "COMBAT_CHARISMA")
        value=$(bash src/data/core/read-byte.sh data/help-menu-data.bin 14)
        if [ $value -eq 0 ]; then
            value=$(bash src/data/core/write-byte.sh data/help-menu-data.bin 1 14)
            echo
            echo -e "\\e[33m(HINT: occasionally, a combatant will be gifted a second turn)\\e[0m"
            echo -e "\\e[33m(HINT: a second turn cannot be given more than once in a row (no third turn))\\e[0m"
            echo -e "\\e[33m(HINT: a higher CHARISMA increases the chance of a second turn)\\e[0m"
        fi
        ;;
    "COMBAT_LUCK")
        value=$(bash src/data/core/read-byte.sh data/help-menu-data.bin 15)
        if [ $value -eq 0 ]; then
            value=$(bash src/data/core/write-byte.sh data/help-menu-data.bin 1 15)
            echo
            echo -e "\\e[33m(HINT: occasionally, a combatant will heal additional health when mending themselves)\\e[0m"
            echo -e "\\e[33m(HINT: a higher LUCK increases the chance of additional healing)\\e[0m"
        fi
        ;;
    "COMBAT_RESIST")
        value=$(bash src/data/core/read-byte.sh data/help-menu-data.bin 16)
        if [ $value -eq 0 ]; then
            value=$(bash src/data/core/write-byte.sh data/help-menu-data.bin 1 16)
            echo
            echo -e "\\e[33m(HINT: less damage is dealt if a defender has armor that resists the attack type of the attacker)\\e[0m"
        fi
        ;;
esac 