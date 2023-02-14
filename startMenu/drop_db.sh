#! /bin/bash

# Using Sourcing....
. ./allFunctions.sh

if [ -z "$(ls MyOwnDBs)" ]; then
        zenity --error --width="200" --text="No Database found"
        startMenu
    else
        dbName=$(ls -l MyOwnDBs | grep "^d" | awk -F ' ' '{print $9}' | zenity --list --height="250" --width="300" --title="Database List" --text="Select your database" --column="Database name" --cancel-label="Back" 2>>.errorlog)
        if [[ $? == 1 ]]; then
            startMenu
        else
            if ! dbExistence $dbName; then
                zenity --error --width="300" --text="Database does not exist"
            else
                answer=$(zenity --question --text="Are you sure you want to drop [$dbName]?")
                if [[ $? == 1 ]]; then
                    startMenu
                else
                    rm -r MyOwnDBs/"$dbName"
                    zenity --info --width="200" --text="[$dbName] Deleted succefully"
                    startMenu
                fi
            fi
        fi
    fi