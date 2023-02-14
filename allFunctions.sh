#! /bin/bash
# shellcheck disable=SC2034

Green='\033[1;32m'   # Green Color Green
ColorReset='\033[0m' # No Color Code

function drawTelecom() {
    echo -e "${Green}"
    cat <<"EOF"
                        
                            __________  ________  __       ________  ________  ______   ___  ___         
                           |___    ___||   _____||  |     |   _____||   ____/ /  __  \ |   \/   |                      
                               |  |    |  /_____ |  |     |  /_____ |  |     |  |  |  ||  \  /  |    
                               |  |    |   _____||  |     |   _____||  |     |  |  |  ||  |\/|  |   
                               |  |    |  /_____ |  |____ |  /_____ |  |_____|  |__|  ||  |  |  |                    
                               |__|    |________||_______||________||_______/ \______/ |__|  |__| 
 
EOF
    echo -e "${ColorReset}"
}

function startMenu() {
    choice=$(zenity --list \
        --height="255" \
        --width="350" \
        --cancel-label="Exit" \
        --title="Main Menu" \
        --column="Option" \
        "Create Database" \
        "Rename Database" \
        "List Database" \
        "Connect To Database" \
        "Drop Database")

    case $choice in
    "Create Database") ./startMenu/create_db.sh ;;
    "Rename Database") ./startMenu/rename_db.sh ;;
    "List Database") ./startMenu/list_db.sh ;;
    "Connect To Database") ./startMenu/connect_db.sh ;;
    "Drop Database") ./startMenu/drop_db.sh ;;
    *) return ;;
    esac
}

function empty() {

    if [[ -z $1 ]]; then
        # 0 = true
        return 0
    else
        # 1 = false
        return 1
    fi
}

function dbExistence() {

    if [[ -d ./MyOwnDBs/$1 ]]; then

        return 0
    else

        return 1
    fi
}

function tableExistence() {

    if [[ -f ./MyOwnDBs/$dbName/$1 ]]; then

        return 0
    else

        return 1
    fi
}

function valid() {
    if empty "$1" || [[ ! $1 =~ ^[a-zA-Z]+[a-zA-Z0-9]*$ ]]; then

        return 0
    else

        return 1
    fi
}

function validSpecialCharacters() {
    if empty "$1" || [[ ! $1 =~ ^[a-zA-Z0-9\&!@\#$%^./\\\;'"'\<\>\ \|\,\:\\*]*$ ]]; then

        return 0
    else

        return 1
    fi
}

function createDatabase() {
    mkdir ./MyOwnDBs/"$1"
    mkdir ./MyOwnDBs/"$1"/.metadata
}

function createTable() {
    touch MyOwnDBs/$dbName/$1
    touch MyOwnDBs/$dbName/.metadata/$1.meta
    createColumns MyOwnDBs/$dbName/$1 MyOwnDBs/$dbName/.metadata/$1.meta
}

# function checkDatabases() {
#     if [ -z "$(ls MyOwnDBs)" ]; then
#         zenity --error --width="200" --text="No Database found"
#         startMenu
#     else
#         ls -l MyOwnDBs | grep "^d" | awk -F ' ' '{print $9}' | zenity --list --height="250" --width="300" --title="Database List" --text="Select your database" --column="Database name" --cancel-label="Back" 2>>.errorlog
#         startMenu
#     fi
# }

function dataBaseMenu() {
    choice=$(zenity --list \
        --height="200" \
        --width="350" \
        --cancel-label="Exit" \
        --title="Database $1 Menu" \
        --column="Option" \
        "Create Table" \
        "List Tables" \
        "Main Menu")

    case $choice in
    "Create Table") . ./dataBaseMenu/create_table.sh $1 ;;
    "List Tables") . ./dataBaseMenu/list_tables.sh $1 ;;
    "Main Menu") startMenu ;;
    *) return ;;
    esac
}

function createColumns() {
    pk="No"
    flag=0
    while true; do
        num=$(zenity --entry \
            --title="No. Of Columns" \
            --cancel-label="Back" \
            --text="Enter the number of columns")
    
        ################################################################
        # Check if num is a number && Start taking table Specifications.....
        if [[ $num =~ ^[1-9]+[0-9]*$ ]] && [[ ! -z $num ]]; then
            for ((i = 1; i <= $num; i++)); do
                while true; do
                    columnName=$(zenity --entry \
                        --title="Column Name" \
                        --cancel-label="Back" \
                        --text="Enter Column Number [$i] Name")

                    if valid "$columnName"; then
                        zenity --error --width="300" --text="Column Name cannot be empty or starts with numbers, speacial characters and spaces"
                    else
                        break
                    fi
                done
                ################################################################
                # Primary Key Check.....
                if [[ $flag == 0 ]]; then
                    answer=$(zenity --question --text="Do you want [$columnName] as a Primary Key ?")
                    if [[ $? == 1 ]]; then
                        pk="No"
                    else
                        pk="PK"
                        flag=1
                    fi
                fi
                ################################################################
                # Data type of each column.....
                while true; do
                    cDataType=$(zenity --list \
                        --height="169" \
                        --width="250" \
                        --cancel-label="Exit" \
                        --title="$columnName DataType" \
                        --column="Option" \
                        "Integer" \
                        "String")
                    if [ -z "$cDataType" ]; then
                        zenity --error --width="150" --text="Choose a Data Type"
                    else
                        break
                    fi
                done
                ################################################################
                # insert table specifications in the Metadata file
                if (($i == $num)); then
                    echo -e "$columnName|$cDataType|$pk" >>$2

                elif (($i < $num)); then
                    echo -e "$columnName|$cDataType|$pk" >>$2
                fi
                ################################################################
                # If we had a primary key then make pk variable empty [only one primary key for each table]
                if [[ $pk == "PK" ]]; then
                    pk="No"
                fi
                
            done
            break
        else
            zenity --error --width="300" --text="Column number can not be empty or starts with speacial characters or spaces"
        fi
    done
}

function tableMenu() {

    choice=$(zenity --list \
        --height="310" \
        --width="350" \
        --cancel-label="Back" \
        --title="Table $2 Menu" \
        --column="Option" \
        "Insert Into [$2]" \
        "Select From [$2]" \
        "Update [$2]" \
        "Delete From [$2]" \
        "Drop [$2]" \
        "Main Menu" \
        "Exit")

    if [ $? -eq 1 ]; then
        dataBaseMenu "$dbName"
    fi

    case $choice in
    "Insert Into [$2]") . ./tableMenu/insert_into_table.sh $1 $2 ;;
    "Select From [$2]") selectMenu $1 $2 ;;
    "Update [$2]") updateMenu $1 $2 ;;
    "Delete From [$2]") deleteMenu $1 $2 ;;
    "Drop [$2]") . ./tableMenu/drop_table.sh $1 $2 ;;
    "Main Menu") startMenu ;;
    "Exit") exit ;;
    *) startMenu ;;
    esac
}

function updateMenu() {
    choice=$(zenity --list \
        --width="350" \
        --cancel-label="Back" \
        --title="$2 Update Menu" \
        --column="Option" \
        "Update By Column")

    case $choice in
    "Update By Column") . ./tableMenu/updateMenu/updateByColumn.sh $1 $2 ;;
    *) tableMenu $1 $2 ;;
    esac
}

function selectMenu() {
    choice=$(zenity --list \
        --height="200" \
        --width="350" \
        --cancel-label="Back" \
        --title="$2 Select Menu" \
        --column="Option" \
        "Select All Data Of [$2]" \
        "Select Data Of Column" \
        "Select Data Of Record")

    case $choice in
    "Select All Data Of [$2]") . ./tableMenu/selectMenu/selectAllData.sh $1 $2 ;;
    "Select Data Of Column") . ./tableMenu/selectMenu/selectColumn.sh $1 $2 ;;
    "Select Data Of Record") . ./tableMenu/selectMenu/selectRow.sh $1 $2 ;;
    *) tableMenu $1 $2 ;;
    esac
}

function deleteMenu() {
    choice=$(zenity --list \
        --height="168" \
        --width="350" \
        --cancel-label="Back" \
        --title="[$2] Delete Menu" \
        --column="Option" \
        "Truncate All Data Of [$2]" \
        "Delete Data Of Record")

    case $choice in
    "Truncate All Data Of [$2]") . ./tableMenu/deleteMenu/deleteAllData.sh $1 $2 ;;
    "Delete Record Of Data") . ./tableMenu/deleteMenu/deleteRow.sh $1 $2 ;;
    *) tableMenu $1 $2 ;;
    esac
}

function uniqeValue() {
    l=1
    for n in $(cut -f $4 -d '|' MyOwnDBs/$2/$3); do
        if [[ $n = "$1" ]]; then
            l=0
            break
        fi
    done
    return "$l"
}

function checkValue() {
    l=1
    for n in $(cut -f $4 -d '|' MyOwnDBs/$2/$3); do
        if [[ $n = $1 ]]; then
            l=0
            break
        fi
    done
    return "$l"
}
