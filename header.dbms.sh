#! /bin/bash
function createTable {
	echo -e "Enter Tablename: \c"
	read tableName

	if [ -f "LocalDBs"/$1/$tableName ]
	then
		echo "Table already exist"
		#callmenufun
	else
		echo -e "Enter number of columns: \c"
		read ColNum
		FieldSep=":"
		RecordSep="\n"
		PK=""
		meta="Field"$FieldSep"Type"$FieldSep"Key"
		for ((i=1;i<=$ColNum;i++))

			do
				echo -e  "Enter Column Name: \c"
				read colName
				echo "Enter Column Type: "
				while true
					do
					select choice in "int" "varchar"
					do
						case $REPLY in
						1) colType="int"
							break
							;;
						2) colType="varchar"
							break
							;;
						*) echo "invalid choice"
							;;
					esac
					done
		                done
				





			done



		fi
}
