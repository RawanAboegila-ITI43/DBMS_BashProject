#! /bin/bash

#########################################################################################
#					Table Functions					#
#########################################################################################

function CreateTable {
	echo -e "Enter Tablename: \c"
	read tableName

	if [ -f "LocalDBs"/$1/$tableName"_meta.db" ]
	then
		echo "Table already exist"
		#callmenufun
	else 
	touch "LocalDBs"/$1/$tableName"_meta.db"
	touch "LocalDBs"/$1/$tableName".db" 
		echo -e "Enter Number of Columns: \c"
		read ColNum
		FieldSep=":"
		RecordSep="\n"
		PK=""
		meta="Field"$FieldSep"Type"$FieldSep"Key"
		ColType=""
		for ((i=1;i<=$ColNum;i++))

			do
				echo -e  "\n\nEnter Column #$i Name: \c"
				read ColName
				echo -e "\nEnter Column Type: "
				while true
				
					do
					select choice in "int" "varchar"
					do
						case $REPLY in
						1 ) ColType="int"
							break 2
							;;

						2 ) ColType="varchar";
							break 2
							;;

						* ) echo "invalid choice"
							;;
					esac
					done
		                done
			
			if  [[ -z $PK || $PK == "0" ]]  
			then

			echo  -e "\nIs it Primary Key?"

			while true
			do
			echo -e " 1 : YES , 2 : No >> \c"			
			read choice
				case $choice in
				1) PK="1"
				   meta=$meta$RecordSep$ColName$FieldSep$ColType$FieldSep"1"
				   break 		;;
				2) PK="0"
				   meta=$meta$RecordSep$ColName$FieldSep$ColType$FieldSep"0"
				   break 
							;;
				*) echo "invalid choice"
							;;
				esac
			done		

			else
			meta=$meta$RecordSep$ColName$FieldSep$ColType$FieldSep"0"
			fi

		done
		
		echo -e "\n Printing data!"

		echo -e $meta >> "LocalDBs"/$1/$tableName"_meta.db"

	fi
#displayMenu
}

function DropTable {
echo -e "Enter Table Name To Be Deleted: \c"
read tableName
if [ -f "LocalDBs"/$1/$tableName"_meta.db" ]
then
rm -i "LocalDBs"/$1/$tableName"_meta.db"
rm -i "LocalDBs"/$1/$tableName".db"
else
	echo "Table doesn't exist"


fi
}

function InsertIntoTable {

}


#########################################################################################
#					Database Functions				#
#########################################################################################



function CreateDB {
#while true
#do
if [ -d "LocalDBs"/$1 ]
then
	echo "DB already exists"
	#echo -e "Exit? [y|N]\c"
	#read choice
#echo $choice
#elif [ $choice == y ] 
#then
	#echo ineflif
	#break
else
mkdir "LocalDBs"/$1
echo $1 >> local_DBMS.dbms
#break
fi
#done
}


function SelectDB {

echo -e "\nChoose A Database or Create A New One: \n"

DB_Name=""

select DB_Name in $(awk '{print}' local_DBMS.dbms) "New" "Exit"; do

	if [[ $DB_Name != "Exit" && $DB_Name != "New" ]]
	then
	echo -e "Connected To $DB_Name\n"
	break
	elif [[ $DB_Name == "New" ]]
	then
	clear
	echo "Enter DB  Name"
	read DB_Name
	CreateDB $DB_Name
	break
	elif [[ $DB_Name == "Exit" ]]
	then	
	break
	else
	echo -e "Invalid Choice!\n Choose A Valid One!\n"
	fi
done

export DB_Name
}



function RenameDB {

echo -e "\nChoose A Database: \n"

DB_Name=""

select DB_Name in $(awk '{print}' local_DBMS.dbms) "Exit"; do

	if [[ $DB_Name != "Exit" ]]
	then
	echo -e "Enter New Name >> \c"
	read newName
	mv LocalDBs/$DB_Name LocalDBs/$newName
	sed -i "s/$DB_Name/$newName/" "local_DBMS.dbms"
	break
	elif [[ $DB_Name == "Exit" ]]
	then	
	break
	else
	echo -e "Invalid Choice!\n Choose A Valid One!\n"
	fi
done
}



function DropDB {
	echo -e "Enter DB Name To be Deleted: \c"
	read dbName
	if [ -d "LocalDBs"/$dbName ]
	then
		rm -r "LocalDBs"/$dbName
		sed -i "/$dbName/d" "local_DBMS.dbms"
	else
		echo "DB doesn't exist"
	fi	
}



function ShowDBs {
echo -e "\nLocal Databases: \n"
awk  '{print NR "-",$0}' local_DBMS.dbms
echo -e "\n"
}














