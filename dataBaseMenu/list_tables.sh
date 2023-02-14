#! /bin/bash

# Using Sourcing....
. ./allFunctions.sh

table="$(ls -l MyOwnDBs/$dbName | grep "^[-]" | awk -F ' ' '{print $9}' | zenity --list --cancel-label="Back" --height="250" --width="300" --title="Tables List of [$dbName]" --text="Select your table" --column="Table Name" 2>>.errorlog)"

if [ $? -eq 1 ]; then
    dataBaseMenu $dbName
fi

tableMenu $dbName $table
