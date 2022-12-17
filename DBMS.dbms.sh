#! /bin/bash
#Running header file
source ./header.dbms.sh

echo -e "Enter DB Name >> \c"
read DBName
CreateDB $DBName
CreateTable $DBName
DropTable $DBName
DeleteDB
