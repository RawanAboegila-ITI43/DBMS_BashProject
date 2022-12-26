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
function tableMenuHeader {
    styleOutput $YELLOW $BLACK "Table Menu!\n"

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

    while true; do
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
        styleOutput $BLUE $WHITE " >> \c"
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
        *)
            MiddlePrint 3 -2
            styleOutput $RED $BLACK "Invalid Input!\n"
            echo $st_Standout

            ;;

        esac

        MiddlePrint 4 -2
        styleOutput $RED $BLACK "Enter Any Key To Continue!\n"
        echo $end_Standout
        echo -e "\n\n"
        read
    done

}

function TableMenu {

    while true; do
        rmcup
        clear
        MiddlePrint -15 -15
        styleOutput 0 $YELLOW "____________________________________________"
        MiddlePrint -12 0
        tableMenuHeader
        MiddlePrint -10 -15
        styleOutput 0 $YELLOW "____________________________________________"

        MiddlePrint -7 -2
        styleOutput $YELLOW $DEFAULT_BK "1: List Tables"
        MiddlePrint -6 -2
        styleOutput $YELLOW $DEFAULT_BK "2: Create Table"
        MiddlePrint -5 -2
        styleOutput $YELLOW $DEFAULT_BK "3: Insert Table"
        MiddlePrint -4 -2
        styleOutput $YELLOW $DEFAULT_BK "4: Update Table"
        MiddlePrint -3 -2
        styleOutput $YELLOW $DEFAULT_BK "5: Select Queries"
        MiddlePrint -2 -2
        styleOutput $YELLOW $DEFAULT_BK "6: Delete From Table"
        MiddlePrint -1 -2
        styleOutput $YELLOW $DEFAULT_BK "7: Drop Table"
        MiddlePrint 0 -2
        styleOutput $YELLOW $DEFAULT_BK "8: Go Back"
        MiddlePrint 2 -2
        styleOutput $BLUE $WHITE " >> \c"
        tput setab $BLUE
        tput setaf $WHITE
        read MainMenuChoice
        tput sgr0

        case $MainMenuChoice in
        1)
            clear
            ShowTables $DB_Name
            ;;
        2)
            clear
            CreateTable $DB_Name
            ;;

        3)
            clear
            InsertIntoTable $DB_Name
            ;;

        4)
            clear
            UpdateTable $DB_Name
            ;;

        5)
            clear
            SelectFromTable $DB_Name
            ;;

        6)
            clear
            DeleteFromTable $DB_Name
            ;;

        7)
            clear
            DropTable $DB_Name
            ;;

        8)
            DatabaseMenu
            ;;

        *)
            MiddlePrint 5 -2
            styleOutput $RED $BLACK "Invalid Input!\n"
            echo $st_Standout

            ;;

        esac

        MiddlePrint 6 -2
        styleOutput $RED $BLACK "Enter Any Key To Continue!\n"
        echo $end_Standout
        echo -e "\n\n"
        read
    done

}

export -f DatabaseMenu
export -f TableMenu

DatabaseMenu
