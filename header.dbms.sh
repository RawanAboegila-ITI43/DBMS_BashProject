#! /bin/bash
function CreateTable {
	echo -e "Enter Tablename: \c"
	read tableName

	if [ -f "LocalDBs"/$1/$tableName"_meta.db"]
	then
		echo "Table already exist"
		#callmenufun
	else 
	touch "LocalDBs"/$1/$tableName"_meta.db"
	touch "LocalDBs"/$1/$tableName".db" 
		echo -e "Enter number of columns: \c"
		read ColNum
		FieldSep=":"
		RecordSep="\n"
		PK=""
		meta="Field"$FieldSep"Type"$FieldSep"Key"
		for ((i=1;i<=$ColNum;i++))

			do
				echo -e  "Enter Column Name: \c"
				read ColName
				echo "Enter Column Type: "
				while true
					do
					select choice in "int" "varchar"
					do
						case $REPLY in
						1) ColType="int"
							break
							;;
						2) ColType="varchar"
							break
							;;
						*) echo "invalid choice"
							;;
					esac
					done
		                done
 			if [ $PK="" ] || [ $PK -eq 0 ]
			then
			echo  "Is it Primary Key?"
			while true
			do
			echo -e " 1 : YES , 2 : No \c"			
			read 
				case $REPLY in
				1) PK=1
				   meta=$meta$RecordSep$ColName$FieldSep$ColType"1"      						break		;;
				2) PK=0
				   meta=$meta$RecordSep$ColName$FieldSep$ColType"0"
					break
							;;
				*) echo "invalid choice"
							;;
				esac
			done		

			else
			meta=$meta$RecordSep$ColName$FieldSep$ColType"0"
			fi



		done
		
		echo -e $meta >> "LocalDBs"/$1/$tableName"_meta.db"

	fi
#displayMenu
}

function CreateDB {
while true
do
if [ -d "LocalDBs"/$1 ]
then
echo "DB already exists"
echo -e "Exit? [y|N]\c "
elif [ $REPLY = "y" ] 
then
break
else
mkdir "LocalDBs"/$1
echo $1 >> local_DBMS.dbms
break
fi
done
}
















