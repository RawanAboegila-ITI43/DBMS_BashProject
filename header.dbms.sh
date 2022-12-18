#! /bin/bash
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
							echo "in 1 case "
							;;
						2 ) ColType="varchar";
							break 2
							echo "in 1 case "
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

function DeleteDB {
	echo -e "Enter DB Name To be Deleted: \c"
	read dbName
	if [ -d "LocalDBs"/$dbName ]
	then
		rm -r "LocalDBs"/$dbName
		rid=$(awk '{for(i=1;i<=NR;i++){if($i=="'$dbName'") print i}}' ~/DBMS/local_DBMS.dbms)
		sed -i "$rid d" ~/DBMS/local_DBMS.dbms
	else
		echo "DB doesn't exist"
	fi	
}













