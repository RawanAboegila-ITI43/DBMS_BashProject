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

FieldSep=":"
RecordSep="\n"

((numberOfChoices=$(ls LocalDBs/$1 | grep -c  '._meta.db$') + 1 ))

select TB_Name in $(ls LocalDBs/$1 | grep  '._meta.db$' | cut -d "_" -f1) "Exit"; do

	if [[ $TB_Name != "Exit" ]] && (($REPLY <= $numberOfChoices ))
	then
	echo $TB_Name
	break
	elif [[ $TB_Name == "Exit" ]]
	then
	break
	else
	echo -e "\nInvalid Choice!\n Choose A Valid One!\n"
	fi
done


ColNum=$(awk 'END{print NR-1}' "LocalDBs"/$1/$TB_Name"_meta.db")
NumberOfRecords=$(awk 'END{print NR}' "LocalDBs"/$1/$TB_Name".db") 

for (( i = 1; i <= ColNum ; i++))
do
	
	
	ColName=$(awk 'BEGIN{FS=":"}{if(NR==(('$i' + 1))) print $1}' "LocalDBs"/$1/$TB_Name"_meta.db")
	ColType=$(awk 'BEGIN{FS=":"}{if(NR==(('$i'+ 1))) print $2}' "LocalDBs"/$1/$TB_Name"_meta.db")
	ColPK=$(awk 'BEGIN{FS=":"}{if(NR==(('$i'+ 1))) print $3}' "LocalDBs"/$1/$TB_Name"_meta.db")
	
	
	echo -e "Please Enter Coloumn Value: \n"
	echo -e "$ColName ( $ColType ) >> \c "
	read ColValue	
	echo -e "\n"

	if [[ $ColType == "int" ]]
	then
		while ! [[ $ColValue =~ ^[0-9]*$ ]]
		do
			echo -e "Invalid Data Type!\nPlease Enter an Integer!\n"
			echo -e ">> \c"
			read ColValue
		done
	fi

	if [[ $ColPK == "1" ]] && (( $NumberOfRecords > 0 ))
	then
		while true
		do
			if [[ $ColValue =~ ^[`awk 'BEGIN{FS=":"; ORS=" "}{print $'$i'}' "LocalDBs"/$1/$TB_Name".db"`]$ ]]
			then
			echo -e "Value Already Exists!\nPlease Enter A Unique Value!\n"
			echo -e ">> \c"
			read ColValue
			else 
			break
			fi
			
		done
	fi

	if [[ $i == $ColNum ]]
	then
	record=$record$ColValue$RecordSep
	else
	record=$record$ColValue$FieldSep
	fi
done
echo -e "$record\c" >> "LocalDBs"/$1/$TB_Name".db"

if [[ $? == 0 ]]
then
	echo "Row Inserted Succesfully!"
else
	echo "Error Inserting Data Into Table $TB_Name"
fi
row=""
# tables Menu
}

function DeleteFromTable {
FieldSep=":"
RecordSep="\n"

((numberOfChoices=$(ls LocalDBs/$1 | grep -c  '._meta.db$') + 1 ))

while true
do
	echo -e "\nChoose Table \n"
	select TB_Name in $(ls LocalDBs/$1 | grep  '._meta.db$' | cut -d "_" -f1) "Exit"; do

		if [[ $TB_Name != "Exit" ]] && (( $REPLY <= $numberOfChoices )) 
		then
		break 2
		elif [[ $TB_Name == "Exit" ]]
		then
		break 2
		else
		echo -e "\nInvalid Choice!\n Choose A Valid One!\n"
		fi
	done
done

ColNum=$(awk 'END{print NR-1}' "LocalDBs"/$1/$TB_Name"_meta.db")
while true
do
	echo -e "Choose Condition Coloumn \n"
	select Col_Name in $(awk '{if (NR > 1) print $0}' "LocalDBs"/$1/$TB_Name"_meta.db"|cut -d "$FieldSep" -f1) "Exit"; do

		if [[ $Col_Name != "Exit" ]] && (( $REPLY <= $ColNum ))
		then
		echo $Col_Name
		break 2
		elif [[ $Col_Name == "Exit" ]]
		then
		break 2
		else
		echo -e "\nInvalid Choice!\n Choose A Valid One!\n"
		fi
	done
done


(( fieldNum=$(awk 'BEGIN{FS="'$FieldSep'"}{for(i=1;i<=NF;i++){if($i=="'$Col_Name'"){ print NR}}}' "LocalDBs"/$1/$TB_Name"_meta.db") - 1 ))

echo -e "Enter Condition Value >> \c"
read ConditionValue

oldValue=$(awk 'BEGIN{FS="'$FieldSep'"}{if($'$fieldNum'=="'$ConditionValue'") print NR}' "LocalDBs"/$1/$TB_Name".db")

if [[ -z $oldValue ]]

then
	echo -e "value not found!\n"

else 
	sed -i ''$oldValue'd' "LocalDBs"/$1/$TB_Name".db"
	if [[ $? == 0 ]]
		then echo -e "Record Deleted Succesfully!"
	else 
		echo "Failed!"
	fi
fi


}


function UpdateTable
{

	FieldSep=":"
	RecordSep="\n"

	((numberOfChoices=$(ls LocalDBs/$1 | grep -c  '._meta.db$') + 1 ))

	select TB_Name in $(ls LocalDBs/$1 | grep  '.meta.db$' | cut -d "_" -f1) "Exit"; do

		if [[ $TB_Name != "Exit" ]] && (( $REPLY <= $numberOfChoices ))
		then
		echo $TB_Name
		break
		elif [[ $TB_Name == "Exit" ]]
		then
		break
		else
		echo -e "\nInvalid Choice!\n Choose A Valid One!\n"
		fi
	done
	ColNum=$(awk 'END{print NR-1}' "LocalDBs"/$1/$TB_Name"_meta.db")
	NumberOfRecords=$(awk 'END{print NR}' "LocalDBs"/$1/$TB_Name".db") 
	ColNum=$(awk 'END{print NR-1}' "LocalDBs"/$1/$TB_Name"_meta.db")

## Changing Coloumn

	while true
	do
		echo -e "Please Select Coloumn Value To be Updated: \n"
		select Col_Name in $(awk '{if (NR > 1) print $0}' "LocalDBs"/$1/$TB_Name"_meta.db"|cut -d "$FieldSep" -f1) "Exit"; do

			if [[ $Col_Name != "Exit" ]] && (( $REPLY <= $ColNum ))
			then
			echo $Col_Name
			break 2
			elif [[ $Col_Name == "Exit" ]]
			then
			break 2
			else
			echo -e "\nInvalid Choice!\n Choose A Valid One!\n"
			fi
		done
	done



	(( changing_fieldNum=$(awk 'BEGIN{FS="'$FieldSep'"}{for(i=1;i<=NF;i++){if($i=="'$Col_Name'"){ print NR}}}' "LocalDBs"/$1/$TB_Name"_meta.db") - 1 ))

	echo -e "Enter New Value >> \c"
	read newValue


### Condition ###
#Chosing Condition	
	while true
	do
	echo -e "Choose Condition Coloumn \n"
		select Col_Name in $(awk '{if (NR > 1) print $0}' "LocalDBs"/$1/$TB_Name"_meta.db"|cut -d "$FieldSep" -f1) "Exit"; do

			if [[ $Col_Name != "Exit" ]] && (( $REPLY <= $ColNum ))
			then
			echo $Col_Name
			break 2
			elif [[ $Col_Name == "Exit" ]]
			then
			break 2
			else
			echo -e "\nInvalid Choice!\n Choose A Valid One!\n"
			fi
		done
	done

#Getting Condition Coloumn Field Number and Reading Condition Value
	(( condition_fieldNum=$(awk 'BEGIN{FS="'$FieldSep'"}{for(i=1;i<=NF;i++){if($i=="'$Col_Name'"){ print NR}}}' "LocalDBs"/$1/$TB_Name"_meta.db") - 1 ))
	echo -e "Enter Condition Value >> \c"
	read ConditionValue
	

#Updating Value in Table 
#	awk 'BEGIN{FS="'$FieldSep'"}{for(i=1;i<=NF;i++){if($'$condition_fieldNum'=="'$ConditionValue'")
#{$'$changing_fieldNum'="'$newValue'"}}}' "LocalDBs"/$1/$TB_Name".db"

#touch $TB_Name"_temp.db"

updatedData=$(awk 'BEGIN{FS="'$FieldSep'"; ORS="\n";}{for(i=1;i<=NF;i++){if($'$condition_fieldNum'=="'$ConditionValue'"){gsub($'$changing_fieldNum',"'$newValue'");}} print $0}' "LocalDBs"/$1/$TB_Name".db") 
# cat "LocalDBs"/$1/$TB_Name"_temp.db" > "LocalDBs"/$1/$TB_Name".db"	
echo $updatedData > "LocalDBs"/$1/$TB_Name".db"
	if [[ $? == 0 ]]
	then echo -e "\nUpdated Succesfully!"
	else 
	echo -e"\nUpdate Failed!"
	fi 

}


function SelectFromTable {
select choice in "1- Query With Where Condition" "2- Query Without Where Condition" "Exit"
do 
case $choice in
1 )
	case $REPLY in
	1 ) SelectAll_withCondition | column -t -s ':'

	break
	;;
	2 ) SelectCol_withCondition | column -t -s ':'

	break
	;;
        * ) echo -e "Invalid Choice \c"
        break
        ;;
        esac
break
;;
2 ) 
	case $REPLY in
	1 ) SelectAllTable
	break
	;;
	2 ) SelectCol
	break
	;;
	* ) echo -e "Invalid Choice \c"
	break
	;;
	esac
break
;;
3 ) #tablemenu
break
;;
* ) echo -e "Invalid Choice \c"
;;
esac
done

}
function SelectAllTable
{

cat "LocalDBs"/$1/$2".db" | column -t -s ':'

}
function SelectCol
{

        FieldSep=":"
	RecordSep="\n"

	ColNum=$(awk 'END{print NR-1}' "LocalDBs"/$1/$2"_meta.db")

## Changing Coloumn

	while true
	do
		echo -e "Please Select Coloumn Value To be Updated: \n"
		select Col_Name in $(awk '{if (NR > 1) print $0}' "LocalDBs"/$1/$2"_meta.db"|cut -d "$FieldSep" -f1) "Exit"; do

			if [[ $Col_Name != "Exit" ]] && (( $REPLY <= $ColNum ))
			then
			echo $Col_Name
			break 2
			elif [[ $Col_Name == "Exit" ]]
			then
			break 2
			else
			echo -e "\nInvalid Choice!\n Choose A Valid One!\n"
			fi
		done
	done

	(( FieldNum=$(awk 'BEGIN{FS="'$FieldSep'"}{for(i=1;i<=NF;i++){if($i=="'$Col_Name'"){ print NR}}}' "LocalDBs"/$1/$2"_meta.db") - 1 ))

cat "LocalDBs"/$1/$2".db" | cut -d":" -f'$FieldNum' | column -t

}

function SelectCol_withCondition
{
        FieldSep=":"
	RecordSep="\n"
        
	ColNum=$(awk 'END{print NR-1}' "LocalDBs"/$1/$2"_meta.db")

## Changing Coloumn

	while true
	do
		echo -e "Please Select Coloumn Value To be Updated: \n"
		select Col_Name in $(awk '{if (NR > 1) print $0}' "LocalDBs"/$1/$2"_meta.db"|cut -d "$FieldSep" -f1) "Exit"; do

			if [[ $Col_Name != "Exit" ]] && (( $REPLY <= $ColNum ))
			then
			echo $Col_Name
			break 2
			elif [[ $Col_Name == "Exit" ]]
			then
			break 2
			else
			echo -e "\nInvalid Choice!\n Choose A Valid One!\n"
			fi
		done
	done



	(( FieldNum=$(awk 'BEGIN{FS="'$FieldSep'"}{for(i=1;i<=NF;i++){if($i=="'$Col_Name'"){ print NR}}}' "LocalDBs"/$1/$2"_meta.db") - 1 ))

SelectAll_withCondition | cut -d":" -f'$FieldNum' 
}
function SelectAll_withCondition
{
        FieldSep=":"
	RecordSep="\n"
        
	ColNum=$(awk 'END{print NR-1}' "LocalDBs"/$1/$2"_meta.db")

## Changing Coloumn

	while true
	do
		echo -e "Please Select Coloumn Value To be Updated: \n"
		select Col_Name in $(awk '{if (NR > 1) print $0}' "LocalDBs"/$1/$2"_meta.db"|cut -d "$FieldSep" -f1) "Exit"; do

			if [[ $Col_Name != "Exit" ]] && (( $REPLY <= $ColNum ))
			then
			echo $Col_Name
			break 2
			elif [[ $Col_Name == "Exit" ]]
			then
			break 2
			else
			echo -e "\nInvalid Choice!\n Choose A Valid One!\n"
			fi
		done
	done



	(( FieldNum=$(awk 'BEGIN{FS="'$FieldSep'"}{for(i=1;i<=NF;i++){if($i=="'$Col_Name'"){ print NR}}}' "LocalDBs"/$1/$2"_meta.db") - 1 ))


    echo -e "\nSupported Operators: [==, !=, >, <, >=, <=] \nSelect OPERATOR: \c"
    read op
    if [[ $op == "==" ]] || [[ $op == "!=" ]] || [[ $op == ">" ]] || [[ $op == "<" ]] || [[ $op == ">=" ]] || [[ $op == "<=" ]]
    then
      echo -e "\nEnter required VALUE: \c"
      read val
      res=$(awk 'BEGIN{FS="|"; ORS="\n"}{if ($'$FieldNum$op$val') print $'$FieldNum'}' "LocalDBs"/$1/$2"_meta.db" | column -t -s '|')
      if [[ $res == "" ]]
      then
        echo "Value Not Found"
        #selectCon
      else
    #awk 'BEGIN{FS="|"; ORS="\n"}{if ($'$FieldNum$op$val') print $'$FieldNum'}' "LocalDBs"/$1/$2"_meta.db" |  column -t -s '|'
    echo $res
      fi
    else
      echo "Unsupported Operator\n"
  
    fi
  fi

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
