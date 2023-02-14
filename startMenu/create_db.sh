#! /bin/bash

# Using Sourcing....
. ./allFunctions.sh

while true; do

  dbName=$(zenity --entry \
    --title="Add new database" \
    --text="Enter database name:" \
    --entry-text "TELECOM")


  if valid "$dbName"; then
    zenity --error --width="300" --text="Database Name cannot be empty or starts with numbers, speacial characters and spaces"
  else
    if dbExistence "$dbName"; then
      zenity --error --width="300" --text="[$dbName] is already exist"

    else
      createDatabase "$dbName"
      # If the last command done successfully $? will return 0
      if [ $? -eq 0 ]; then

        zenity --info --width="200" --text="[$dbName] Created succefully"
        break
      else
        zenity --error --width="200" --text="Error happened while creating the DataBase"
      fi
    fi
  fi
done

startMenu
