#! /bin/bash

# Using Sourcing....
. ./allFunctions.sh


if [ -z "$(ls MyOwnDBs)" ]; then
        zenity --error --width="200" --text="No Database found"
        startMenu
    else
        ls -l MyOwnDBs | grep "^d" | awk -F ' ' '{print $9}' | zenity --list --height="250" --width="300" --title="Database List" --text="Select your database" --column="Database name" --cancel-label="Back" 2>>.errorlog
        startMenu
    fi
