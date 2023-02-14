#! /bin/bash

columnsName=$(awk -F '|' '{print $1}' MyOwnDBs/$1/.metadata/$2.meta)
cPkIndex=$(grep -n "PK" MyOwnDBs/$1/.metadata/$2.meta | cut -d ':' -f1)
cName=$(grep -n "PK" MyOwnDBs/$1/.metadata/$2.meta | cut -d '|' -f1 | cut -d ':' -f2)
cDataType=$(grep -n "$cName" MyOwnDBs/$1/.metadata/$2.meta | cut -d '|' -f2)
noOfColumns=$(wc -l MyOwnDBs/$1/.metadata/$2.meta | cut -d " " -f1)

while true; do
    rowSelectByPK=$(zenity --entry \
        --height="150" \
        --width="350" \
        --cancel-label="Back" \
        --title="Select Row" \
        --text="Enter [$cName] To Select" \
        --entry-text "Your-Value")

    if [[ -z $rowSelectByPK ]]; then
        zenity --error --width="300" --text="Field can't be empty Please enter Value "
        continue
    fi

    case $cDataType in
    "Integer")
        if [[ ! $rowSelectByPK =~ ^[1-9]+[0-9]*$ ]]; then
            zenity --error --width="300" --text="Integer DataType must be integer numbers"
        else
            if uniqeValue "$rowSelectByPK" "$1" "$2" "$cPkIndex"; then
                break
            else
                zenity --error --width="300" --text="Data Not Found"
            fi
        fi
        ;;
    "String")
        if validSpecialCharacters "$rowSelectByPK"; then
            zenity --error --width="300" --text="Field can't be empty and String DataType must be characters"
        else
            if uniqeValue "$rowSelectByPK" "$1" "$2" "$cPkIndex"; then
                break
            else
                zenity --error --width="300" --text="Data Not Found"
            fi
        fi
        ;;
    *) ;;
    esac
done

declare -a arrCName=()
declare -a rows=()
for i in $columnsName; do
    arrCName[$o]="--column=$i"
    ((o += 1))
done


function prepare() {
    local IFS="~"
    for irow in $(awk -F "|" -v ind=$cPkIndex -v value=$rowSelectByPK '{if($ind==value) {print}}' MyOwnDBs/$1/$2); do
        for ((i = 1; i <= $noOfColumns; i++)); do
            row=$(echo $irow | cut -d '|' -f$i)
            rows+=($row)

        done
    done
}
prepare $1 $2

zenity --list --cancel-label="Back" --title="Table $2 Records" --width="350" --height="100" "${arrCName[@]}" "${rows[@]}"

tableMenu $1 $2