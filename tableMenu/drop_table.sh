#! /bin/bash

# Using Sourcing....
. ./allFunctions.sh

answer=$(zenity --question --text="Are you sure you want to drop [$table]?")
if [ $? -eq 1 ]; then
    dataBaseMenu "$dbName"
else
    rm MyOwnDBs/"$dbName"/"$table"
    rm MyOwnDBs/$dbName/.metadata/$table.meta
    dataBaseMenu "$dbName"
fi
