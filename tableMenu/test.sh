#! /bin/bash
# Using Sourcing....
. ./allFunctions.sh


# cName=$(awk -F '|' '{print $1}' MyOwnDBs/TELECOM/.metadata/Students.meta | zenity --list --height="250" --width="300" --title="Table $table Columns" --text="Select Your Choosen Column" --column="Columns" 2>>.errorlog)
# cIndex=$(grep -n "$cName" MyOwnDBs/TELECOM/.metadata/Students.meta | cut -d ':' -f1)
# cDataType=$(grep -n "$cName" MyOwnDBs/TELECOM/.metadata/Students.meta | cut -d '|' -f2)
# cPK=$(grep -n "$cName" MyOwnDBs/TELECOM/.metadata/Students.meta | cut -d '|' -f3)
# cPkIndex=$(grep -n "PK" MyOwnDBs/TELECOM/.metadata/Students.meta | cut -d ':' -f1)


# awk -F '|' -v value=2102 -v colindex=$(($cIndex)) '{if($colindex==value){print}}' MyOwnDBs/TELECOM/Students




# ana=101
# hh=1

# awk -F '|' '$1=='$ana' {print $'$hh'}' MyOwnDBs/TELECOM/Students

# irow=$(cat MyOwnDBs/TELECOM/Students)
# echo "$irow"

declare -a arr
# noOfColumns=$(wc -l MyOwnDBs/TELECOM/.metadata/Students.meta | cut -d " " -f1)
# echo "$noOfColumns"
# arr+=($noOfColumns)
# echo "$arr"

# for irow in $(cat MyOwnDBs/TELECOM/Students); do
#   for ((i = 1; i <= 3; i++)); do
#     row=$(echo $irow | cut -d '|' -f$i)
#     echo "$row"
#     arr+=($row)
#   done
# done


# irow="5|Zyad Elalfy|26"
# IFS="&"
# for((i=1;i<=3;i++));do
#     row=$(echo $irow | cut -d '|' -f$i)
#     echo "$row"
#     arr+=($row)
# done
# echo "${arr[1]}"

# my_variable="First word Second word"
# zenity --list --column="Column Title" "$(echo ${my_variable} )"
# # row=$(echo $irow | cut -d '|' -f$i)
# #     echo "$row"
# #     arr+=($row)


# cName=$(awk -F '|' '{print TELECOM}' MyOwnDBs/TELECOM/.metadata/Students.meta)

# declare -a arrCName=()
# declare -i o=0

# for i in $cName; do
#     arrCName[$o]="--column=$i"
#     ((o+=1))
# done

# no_of_columns=$(wc -l MyOwnDBs/TELECOM/.metadata/Students.meta | cut -d " " -f1)

# # columns=()
# rows=()

# for irow in $(cat MyOwnDBs/TELECOM/Students); do

#   for ((i = 1; i <= $no_of_columns; i++)); do
#     row=$(echo $irow | cut -d '|' -f$i)
#     rows+=($row)
#   done
# done
# zenity --list --cancel-label="Back" --title="Table Students Records" --width="350" --height="370" "${arrCName[@]}" "${rows[@]}"

# done
# grep -n "ID" MyOwnDBs/TELECOM/.metadata/Students.meta
# cPK=$(grep -n "ID" MyOwnDBs/TELECOM/.metadata/Students.meta | cut -d '|' -f3)
# echo "$cPK"
# cPkIndex=$(grep -n "PK" MyOwnDBs/TELECOM/.metadata/Students.meta | cut -d ':' -f1)
# echo "$cPkIndex"


# if uniqeValue 50 TELECOM Name 2;then
# echo "Duplicated"
# else 
# echo "Good"
# fi

# deleteIndex=$(awk -F"|" '{if (TELECOM=="'44'") print NR}' ./MyOwnDBs/TELECOM/Students)
# sed -i "${deleteIndex}d" MyOwnDBs/TELECOM/Students



# echo "${x}"
# cDataType=$(awk -F '|' '{print Students}' MyOwnDBs/TELECOM/.metadata/Students.meta)
# cPK=$(awk "NR==1" MyOwnDBs/TELECOM/.metadata/Students.meta | awk -F '|' '{print Students}' )
# cPK=$(awk "NR==1" MyOwnDBs/TELECOM/.metadata/Students.meta)

# column_type=$(grep -n "$column" MyOwnDBs/TELECOM/.metadata/Students.meta | cut -d ':' -f2 | cut -d ';' -f2)
# echo "$column_type"

# column_index=$(grep -n "$column" MyOwnDBs/TELECOM/.metadata/Students.meta | cut -d ':' -f1)
# echo "$column_index"
updateID=20

# cDataType=$(grep -n "ID" MyOwnDBs/TELECOM/.metadata/Students.meta | cut -d '|' -f2 )
# echo "$cDataType"

# line=$(awk -F "|" -v value="nnn" -v colindex=4 '{if($colindex==value) print NR}' MyOwnDBs/TELECOM/Students)
# echo "$line"

# awk -F"|" '{if (TELECOM=="'$updateID'") print NR}' MyOwnDBs/TELECOM/Students

# awk  'BEGIN{FS="|"} {if (TELECOM=="'$updateID'") print $0}' MyOwnDBs/TELECOM/Students | tr -d "|"

# awk "NR==1" MyOwnDBs/TELECOM/.metadata/Students.meta | awk -F '|' '{print Students}'

# fid=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$updateID'") print i}}}' MyOwnDBs/TELECOM/Students)
# awk 'BEGIN{FS="|"}{if ($'$fid'=="'$updateID'") print $'$fid'}' MyOwnDBs/TELECOM/Students
# | zenity --list --height="250" --width="300" --title="Table Students Columns" --text="Select Your Choosen Column"  --column="Columns"
# awk -F "|" '{if (TELECOM=="'$updateID'") print NR}' MyOwnDBs/TELECOM/Students | awk "NR"  | cut -d ';' -f1
# declare -i x=0
# declare -i y=0
# declare -i z=0
# declare -a arrDataType=()
# declare -a arrPK=()

# for i in $cDataType; do
#     arrDataType[$x]=$i
#     let x=$x+1
# done

# for i in $cPK; do
#     arrPK[$z]=$i
#     let z=$z+1
# done
# # echo "${arrPK[0]}"
# # echo "${arrPK[1]}"
# # echo "${arrPK[2]}"

# y=1
# # if [[ "${arrPK[y - 1]}" == "PK" ]]; then
# #     echo "PK"
# # else
# #     echo "None"
# # fi
# insertedData=55

# if [[ "${arrPK[y - 1]}" == "PK" ]] && uniqeValue "$insertedData" TELECOM Students; then
#     echo "Data Duplicated"
# else
#     echo "Good Data"
# fi

# # uniqeValue "$insertedData" TELECOM Students

# # let y=1

# # if [[ $insertedData == $(awk -F "|" -v y=$y '{print $y}' MyOwnDBs/TELECOM/Students)  ]]; then
# #     echo "found"
# #     else
# #     echo "not found"
# # fi

# # function uniqeValue() {
# #     uniqe=1
# #     for i in $(cut -f1 -d'|' MyOwnDBs/TELECOM/Students); do
# #         if [[ $i = TELECOM ]]; then
# #             uniqe=0
# #             break
# #         fi
# #     done
# #     return $uniqe
# # }
# # uniqeValue $insertedData

# for i in $cName; do
#     arrCName[$o]=$i
#     let o=$o+1
# done

# insertedData=$(zenity --entry \
#     --height="250" \
#     --width="350" \
#     --cancel-label="Back" \
#     --title="Enter $cName" \
#     --text="Insert here:" \
#     --entry-text "Your-Value")

# for i in "${arrDataType[@]}"; do
#     while true; do
#         case $i in
#         "Integer")
#             insertedData=$(zenity --entry \
#                 --height="250" \
#                 --width="350" \
#                 --cancel-label="Back" \
#                 --title="Enter $cName" \
#                 --text="Insert ${arrCName[y]}" \
#                 --entry-text "Your-Value")

#             if [[ ! $insertedData =~ ^[0-9]+$ ]]; then
#                 zenity --error --width="300" --text="Integer DataType must be integer numbers"
#             elif [[ "${arrPK[y]}" == "PK" ]] && uniqeValue "$insertedData" TELECOM Students; then
#                 zenity --error --width="300" --text="Primary Key column must have unique values"
#             else
#                 y=$(($y + 1))
#                 break
#             fi
#             ;;
#         "String")
#             insertedData=$(zenity --entry \
#                 --height="250" \
#                 --width="350" \
#                 --cancel-label="Back" \
#                 --title="Enter $cName" \
#                 --text="Insert ${arrCName[y]}" \
#                 --entry-text "Your-Value")
#             if valid "$insertedData"; then
#                 zenity --error --width="300" --text="String DataType must be characters without spaces and special characters"
#             else
#                 y=$(($y + 1))
#                 break
#             fi

#             ;;
#         *)
#             echo "unknown"
#             ;;
#         esac
#         done

#         if [[ $i =~ Integer ]]; then
#             if [[ ! $insertedData =~ ^[0-9]+$ ]]; then
#                 zenity --error --width="300" --text="Integer DataType must be integer numbers"
#             else
#                 # y=$(($y + 1))
#                 echo "$y"
#                 if [[ "${arrPK[y - 1]}" == "PK" ]] && uniqeValue "$insertedData" TELECOM Students; then
#                     zenity --error --width="300" --text="Primary Key column must have unique values"
#                 else
#                     echo "break"
#                     break
#                 fi
#                 echo "$y"
#             fi
#         elif [[ $i =~ String ]]; then
#             if valid "$insertedData"; then
#                 zenity --error --width="300" --text="String DataType must be characters without spaces and special characters"
#             else
#                 y=$(($y + 1))
#                 break
#             fi
#         fi
#     done

#     if (($y != "$(cat MyOwnDBs/TELECOM/.metadata/Students.meta | wc -l)")); then
#         echo -e "$insertedData|\c" >>MyOwnDBs/TELECOM/Students
#         # ((y = $y + 1))
#         echo "$y"
#     else
#         echo -e "$insertedData" >>MyOwnDBs/TELECOM/Students
#     fi
# done
# tableMenu TELECOM Students


rowIndex=3; 

# awk -F "|" -v ind=$rowIndex '{print $'ind'}' MyOwnDBs/TELECOM/Students


awk -v cPIndx="2" -F "|" '{if ($cPIndx == "jj") print NR}' MyOwnDBs/TELECOM/Students


# awk -v cPIndx="$cPkIndex" -F"|" '{if ($cPIndx =="'$rowDeleteByPK'") print NR' MyOwnDBs/TELECOM/Students


# awk -F"|" '{if (TELECOM=="'8'") print NR}' ./MyOwnDBs/TELECOM/Students


# awk -F ';' -v value=$column_value -v colindex=$(($column_index)) '{if($colindex==value){print $0}}' Database/$dbName/$table






# awk -F '|' -v value="jj" -v colindex=1 '{if($colindex==value){print}}' MyOwnDBs/TELECOM/Students




# awk -F "|" -v ind="1" -v value="30" '{if($ind==value) {print}}' MyOwnDBs/$1/$2

# awk -F ';' -v value=$column_value -v colindex=$(($column_index)) '{if($colindex==value){print $0}}' Database/$dbName/$table


awk -F "|" -v ind=1 -v value=30 '{if($ind==value) {print}}' MyOwnDBs/TELECOM/Emp