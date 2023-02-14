#! /bin/bash

# using sourcing
. ./allFunctions.sh

cPkIndex=$(grep -n "PK" MyOwnDBs/$1/.metadata/$2.meta | cut -d ':' -f1)
cName=$(grep -n "PK" MyOwnDBs/$1/.metadata/$2.meta | cut -d '|' -f1 | cut -d ':' -f2)
cDataType=$(grep -n "$cName" MyOwnDBs/$1/.metadata/$2.meta | cut -d '|' -f2)

while true; do
    rowDeleteByPK=$(zenity --entry \
        --height="150" \
        --width="350" \
        --cancel-label="Back" \
        --title="Delete Row" \
        --text="Enter [$cName] To Delete" \
        --entry-text "Your-Value")

    if [[ -z $rowDeleteByPK ]]; then
        zenity --error --width="300" --text="Field can't be empty Please enter Value "
        continue
    fi

    case $cDataType in
    "Integer")
        if [[ ! $rowDeleteByPK =~ ^[1-9]+[0-9]*$ ]]; then
            zenity --error --width="300" --text="Integer DataType must be integer numbers"
        else
            if uniqeValue "$rowDeleteByPK" "$1" "$2" "$cPkIndex"; then
                break
            else
                zenity --error --width="300" --text="Data Not Found"
            fi
        fi
        ;;
    "String")
        if validSpecialCharacters "$rowDeleteByPK"; then
            zenity --error --width="300" --text="Field can't be empty and String DataType must be characters"
        else
            if uniqeValue "$rowDeleteByPK" "$1" "$2" "$cPkIndex"; then
                break
            else
                zenity --error --width="300" --text="Data Not Found"
            fi
        fi
        ;;
        *)
    esac

done

deleteIndex=$(awk -v cPIndx="$cPkIndex" -F"|" '{if ($cPIndx =="'$rowDeleteByPK'") print NR}' ./MyOwnDBs/$1/$2)
echo "$deleteIndex"
sed -i "${deleteIndex}d" MyOwnDBs/$1/$2

if [ $? -eq 0 ]; then
    zenity --info --width="200" --text="Row deleted Successfully"
else
    zenity --error --width="200" --text="Something went wrong"
fi
tableMenu $1 $2
