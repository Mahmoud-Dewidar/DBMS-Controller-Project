#! /bin/bash

# using sourcing
. ./allFunctions.sh

answer=$(zenity --question --text="Are you sure you want to drop [$2]?")
declare -i zero=0

if [[ $? == 1 ]]; then
    startMenu
    else
        zenity --info --width="200" --text="All Data Of [$2] Deleted Successfully"

fi

sed -i d MyOwnDBs/$1/$2

tableMenu $1 $2

