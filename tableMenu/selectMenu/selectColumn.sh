#! /bin/bash
# Using Sourcing....
. ./allFunctions.sh

cName=$(awk -F '|' '{print $1}' MyOwnDBs/$1/.metadata/$2.meta | zenity --list --height="250" --width="300" --title="Table $table Columns" --text="Select Your Choosen Column" --column="Columns" 2>>.errorlog)
cIndex=$(grep -n "$cName" MyOwnDBs/$1/.metadata/$2.meta | cut -d ':' -f1)
cValue="$(awk "NR" MyOwnDBs/$1/$2 | cut -d "|" -f$(($cIndex)) | zenity --list --cancel-label="Back" --height="250" --width="300" --title="Table $table --cancel-label="Back" Column [$cName]" --text="Select $cNameFrom $table"  --column="$cName" 2>>.errorlog)"

if [[ $? == 1 ]]; then
    tableMenu $1 $2
fi