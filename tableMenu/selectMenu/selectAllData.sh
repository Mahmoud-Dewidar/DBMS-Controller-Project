#! /bin/bash

# Using Sourcing....
. ./allFunctions.sh

cName=$(awk -F '|' '{print $1}' MyOwnDBs/$1/.metadata/$2.meta)
noOfColumns=$(wc -l MyOwnDBs/$1/.metadata/$2.meta | cut -d " " -f1)

declare -a arrCName=()
declare -a rows=()
declare -i o=0

for i in $cName; do
  arrCName[$o]="--column=$i"
  ((o += 1))
done
function prepare() {
  local IFS="~"
  for irow in $(cat MyOwnDBs/$1/$2); do
    for ((i = 1; i <= $noOfColumns; i++)); do
      row=$(echo $irow | cut -d '|' -f$i)
      rows+=($row)
    done
  done
}
prepare $1 $2

zenity --list --cancel-label="Back" --title="Table $2 Records" --width="350" --height="370" "${arrCName[@]}" "${rows[@]}"

tableMenu $1 $2
