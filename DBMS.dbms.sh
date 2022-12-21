#! /bin/bash

### Colors ##
ESC=$(printf '\033') RESET="${ESC}[0m" BLACK="${ESC}[30m" RED="${ESC}[31m"
GREEN="${ESC}[32m" YELLOW="${ESC}[33m" BLUE="${ESC}[34m" MAGENTA="${ESC}[35m"
CYAN="${ESC}[36m" WHITE="${ESC}[37m" DEFAULT="${ESC}[39m"

### Color Functions ##

greenprint() { printf "${GREEN}%s${RESET}\n" "$1"; }
blueprint() { printf "${BLUE}%s${RESET}\n" "$1"; }
redprint() { printf "${RED}%s${RESET}\n" "$1"; }
yellowprint() { printf "${YELLOW}%s${RESET}\n" "$1"; }
magentaprint() { printf "${MAGENTA}%s${RESET}\n" "$1"; }
cyanprint() { printf "${CYAN}%s${RESET}\n" "$1"; }


### Menu Welcome And Exit Functions ###


#Running header file
source ./header.dbms.sh

#Global Variables
DB_Name=""

function DatabaseMenu{




}
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
