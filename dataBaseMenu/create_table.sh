#! /bin/bash

# Using Sourcing....
. ./allFunctions.sh

while true; do
    tableName=$(zenity --entry \
        --title="Add new table" \
        --cancel-label="Back" \
        --text="Enter Table Name:" \
        --entry-text "Table-Name")

    if valid $tableName; then
        zenity --error --width="300" --text="Table Name cannot be empty or starts with numbers, speacial characters and spaces"
    else
        if tableExistence "$tableName"; then
            zenity --error --width="300" --text="[$tableName] is already exist"
        else
            createTable "$tableName"
            if [[ $? == 1 ]]; then
                zenity --error --width="200" --text="Error occured during creating the table"
            else
                zenity --info --width="200" --text="Table [$tableName] created succefully"
                break
            fi
        fi
    fi
done

dataBaseMenu "$1"
