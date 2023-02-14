#! /bin/bash

# Using Sourcing....
. ./allFunctions.sh

while true; do

    dbName=$(zenity --entry \
        --title="Rename DataBase" \
        --text="Enter database name:" \
        --entry-text "")
    if [[ $? == 1 ]]; then
        startMenu
        break
    fi

    if ! dbExistence "$dbName"; then
        zenity --error --width="300" --text="Database does not exist"
    else
        newDbName=$(zenity --entry \
            --title="Rename DataBase" \
            --text="Enter new database name:" \
            --entry-text "")
        if valid "$newDbName"; then
            zenity --error --width="300" --text="Database Name cannot be empty or starts with numbers, speacial characters and spaces"
        else
            mv ./MyOwnDBs/"$dbName" ./MyOwnDBs/"$newDbName"
            if [ $? -eq 0 ]; then
                zenity --info --width="200" --text="[$dbName] Renamed succefully to [$newDbName]"
                break
            else
                zenity --error --width="200" --text="Error happened while renaming the DataBase"

            fi

        fi

    fi

done
startMenu
