#! /bin/bash +x

# Using Sourcing....
. ./allFunctions.sh

cName=$(awk -F '|' '{print $1}' MyOwnDBs/$1/.metadata/$2.meta)
cDataType=$(awk -F '|' '{print $2}' MyOwnDBs/$1/.metadata/$2.meta)
cPK=$(awk -F '|' '{print $3}' MyOwnDBs/$1/.metadata/$2.meta)

cPkIndex=$(grep -n "PK" MyOwnDBs/$1/.metadata/$2.meta | cut -d ':' -f1)
echo "$cPK"
echo "-----"
echo "$cName"
echo "-----"
echo "$cDataType"
echo "-----"
echo "$cPkIndex"

declare -i x=0
declare -i y=0
declare -i z=0
declare -i o=0
declare -a arrDataType=()
declare -a arrPK=()
declare -a arrCName=()

for i in $cName; do
    arrCName[$o]=$i
    let o=$o+1
done

for i in $cDataType; do
    arrDataType[$x]=$i
    let x=$x+1
done

for i in $cPK; do
    arrPK[$z]=$i
    let z=$z+1
done

echo "-----"
echo "${arrPK[0]} ${arrPK[1]} ${arrPK[2]}"

for i in "${arrDataType[@]}"; do
    while true; do
        insertedData=$(zenity --entry \
            --height="150" \
            --width="350" \
            --cancel-label="Back" \
            --title="Enter $cName" \
            --text="Insert ${arrCName[y]}" \
            --entry-text "Your-Value")
        case $i in
        "Integer")
            if [[ ! $insertedData =~ ^[0-9]+$ ]]; then
                zenity --error --width="300" --text="Integer DataType must be integer numbers"
            elif [[ "${arrPK[y]}" == "PK" ]] && uniqeValue "$insertedData" "$1" "$2" "$cPkIndex"; then
                zenity --error --width="300" --text="Primary Key column must have unique values"
            else
                y=$(($y + 1))
                break
            fi
            ;;
        "String")
            if validSpecialCharacters "$insertedData"; then
                zenity --error --width="300" --text="String DataType must be characters without spaces and special characters"
            elif [[ "${arrPK[y]}" == "PK" ]] && uniqeValue "$insertedData" "$1" "$2" "$cPkIndex"; then
                zenity --error --width="300" --text="Primary Key column must have unique values"
            else
                y=$(($y + 1))
                break
            fi
            ;;
        *)
            zenity --error --width="300" --text="Error happened while inserting data" 
            tableMenu $1 $2
            ;;
        esac
    done

    if (($y != "$(cat MyOwnDBs/$1/.metadata/$2.meta | wc -l)")); then
        echo -e "$insertedData|\c" >>MyOwnDBs/$1/$2
        # ((y = $y + 1))
        echo "$y"
    else
        echo -e "$insertedData" >>MyOwnDBs/$1/$2
    fi
done
echo "$y"
tableMenu $1 $2
