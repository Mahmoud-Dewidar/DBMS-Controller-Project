#! /bin/bash
# Using Sourcing....
. ./allFunctions.sh

# Update [Table] set {Column = oldValue} where {Column = Newvalue}

# Choose the Column....
cName=$(awk -F '|' '{print $1}' MyOwnDBs/$1/.metadata/$2.meta | zenity --list --height="250" --width="300" --title="Table $table Columns" --text="Select Your Choosen Column" --column="Columns" 2>>.errorlog)
cIndex=$(grep -n "$cName" MyOwnDBs/$1/.metadata/$2.meta | cut -d ':' -f1)
cDataType=$(grep -n "$cName" MyOwnDBs/$1/.metadata/$2.meta | cut -d '|' -f2)
cPK=$(grep -n "$cName" MyOwnDBs/$1/.metadata/$2.meta | cut -d '|' -f3)
cPkIndex=$(grep -n "PK" MyOwnDBs/$1/.metadata/$2.meta | cut -d ':' -f1)

# Get the where value
while true; do
    oldValue=$(zenity --entry --width="200" --title="Enter The key $cName Value" --text="Update $table set $cName =  " --entry-text "")
    case $cDataType in
    "Integer")
        if [[ ! $oldValue =~ ^[0-9]+$ ]] ; then
            zenity --error --width="300" --text="Integer DataType must be integer numbers Or Value not found"
        else
            if ! checkValue "$oldValue" $1 $2 "$cPkIndex"; then
                zenity --error --width="300" --text="Value not found"
                echo "Error"
            else
                break
                echo "valid"
            fi
        fi
        ;;
    "String")
        if validSpecialCharacters "$oldValue" && checkValue "$oldValue" $1 $2 "$cPkIndex"; then
            zenity --error --width="300" --text="Field can't be empty and String DataType must be characters without spaces and special characters"
        else
            break
        fi
        ;;
    esac
done

# Get the set value

while true; do
    newValue=$(zenity --entry --width="200" --title="Enter The key $cName Value" --text="Update $table set $cName = {VALUE} where $cName = $oldValue " --entry-text "")
    case $cDataType in
    "Integer")
        if [[ ! $newValue =~ ^[0-9]+$ ]]; then
            zenity --error --width="300" --text="Integer DataType must be integer numbers"
        elif [[ $cPK == "PK" ]] && uniqeValue "$newValue" $1 $2 "$cPkIndex"; then
            zenity --error --width="300" --text="Primary Key column must have unique values"
        else
            break
        fi
        ;;
    "String")
        if validSpecialCharacters "$newValue"; then
            zenity --error --width="300" --text="Field can't be empty and String DataType must be characters without spaces and special characters"
        elif [[ $cPK == "PK" ]] && uniqeValue "$newValue" $1 $2 "$cPkIndex"; then
            zenity --error --width="300" --text="Primary Key column must have unique values"
        else
            break
        fi
        ;;
    esac
done
########################################################################
# Find the record of the entered value then update it with the new value.......

recordNo=$(awk -F "|" -v value="$oldValue" -v coIndex="$cIndex" '{if($colindex==value) print NR}' MyOwnDBs/$1/$2)
sed -i ''"$recordNo"'s/'"$oldValue"'/'"$newValue"'/g' MyOwnDBs/$1/$2 2>>./.error.log
