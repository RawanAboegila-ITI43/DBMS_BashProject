#! /bin/bash

#Running header files
source ./style.dbms.sh
source ./header.dbms.sh

#Global Variables
DB_Name=""

### Menu Welcome And Exit Functions ###
function WelcomeMessage {
    styleOutput $YELLOW $BLACK "Welcome To Our DBMS!\n"

}

function ExitMessage {
    #rmcup
    clear
    MiddlePrint 0 0
    styleOutput $YELLOW $BLACK "It's Been Fun ;)"
    MiddlePrint 1 0
    styleOutput $YELLOW $BLACK "BYE BYE!"
}

function DatabaseMenu {
    rmcup
    clear
    MiddlePrint -15 -15
    styleOutput 0 $YELLOW "____________________________________________"
    MiddlePrint -12 0
    WelcomeMessage
    MiddlePrint -10 -15
    styleOutput 0 $YELLOW "____________________________________________"

    MiddlePrint -7 -2
    styleOutput $YELLOW $DEFAULT_BK "1: List Databases"
    MiddlePrint -6 -2
    styleOutput $YELLOW $DEFAULT_BK "2: Create Database"
    MiddlePrint -5 -2
    styleOutput $YELLOW $DEFAULT_BK "3: Connect Database"
    MiddlePrint -4 -2
    styleOutput $YELLOW $DEFAULT_BK "4: Rename Database"
    MiddlePrint -3 -2
    styleOutput $YELLOW $DEFAULT_BK "5: Drop Database"
    MiddlePrint -2 -2
    styleOutput $YELLOW $DEFAULT_BK "6: Exit"
    MiddlePrint 1 -2
    styleOutput $BLUE $WHITE ">> \c"
    tput setab $BLUE
    tput setaf $WHITE
    read MainMenuChoice
    tput sgr0

    case $MainMenuChoice in
    1)
        clear
        ShowDBs
        ;;
    2)
        clear
        CreateDB
        ;;

    3)
        clear
        SelectDB
        ;;

    4)
        clear
        RenameDB
        ;;

    5)
        clear
        DropDB
        ;;

    6)
        ExitMessage
        exit 0
        ;;

    esac

}

DatabaseMenu

#DB_Name="SecondDB"
#SelectDB
#clear
#SelectFromTable $DB_Name
#UpdateTable $DB_Name
#InsertIntoTable $DB_Name
#DeleteFromTable $DB_Name
#echo -e "Enter DB Name >> \c"
#read DB_Name
#CreateTable $DB_Name
#DropTable $DB_Name
#CreateDB $DB_Name
#SelectDB
#echo $DB_Name
#DropDB
#RenameDB
#ShowDBs
#SelectFromTable $DB_Name
#SelectWithCondition $DB_Name
#SelectCol $DB_Name
