#! /bin/bash

# shellcheck disable=SC2034
# shellcheck disable=SC1091
# shellcheck disable=SC2154
# shellcheck disable=SC2086

#---------------------------
# Using Sourcing....
. ./allFunctions.sh

#---------------------------------------------------------

# Start Of The Code......

zenity --info --width="200" --title="Welcome"  --text="  Welcome to our DBMS Controller Project \n\nCreated By [Mahmoud Dewidar | Zyad ElAlfy]\n\n\t\t\t   THANK YOU"

mkdir  MyOwnDBs 2>>.errorlog
drawTelecom
startMenu





