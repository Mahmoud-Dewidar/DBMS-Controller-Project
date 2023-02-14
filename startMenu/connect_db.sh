#! /bin/bash
# Using Sourcing....
. ./allFunctions.sh

dbName=$(ls -l MyOwnDBs | grep "^d" | awk -F ' ' '{print $9}' | zenity --list --height="250" --width="300" --title="Database List" --text="Select your database" --column="Database name" --cancel-label="Back" 2>>.errorlog)

if [[ $? == 1 ]]; then
    startMenu
else
    if [ -z $dbName ]; then
        
        zenity --error --width="200" --text="Please Select Database"
        ./startMenuOptions/connect_db.sh
    else
        zenity --info --width="200" --text="Connected to [$dbName] succefully"
        dataBaseMenu "$dbName"
    fi
fi
