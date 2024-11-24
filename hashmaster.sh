#!/bin/bash
#clean up files for re-use
rm download_list1.txt 2>/dev/null
rm download_list2.txt 2>/dev/null
#set text color variables
RED='\033[0;31m'
GRN='\033[0;32m'
MAG='\033[0;35m'
NC='\033[0m'

#clear the screen
clear
#get username

user_name=`whoami`

#have user paste in checksum from the website

echo please paste SHA256 checksum from website:  


#save the first checksum as variable sum1

read sum1


#give user a numbered list of files in the dowloads folder for them to choose from

dl_directory="/home/$user_name/Downloads"

ls $dl_directory -1 >> download_list1.txt

awk '{print NR,$0}' download_list1.txt > download_list2.txt

cat download_list2.txt

echo -n "Choose the file you would like to check by typing in the corresponding number:  "

read selection
# set var as selection from list 
var=( $(ls $dl_directory) ) 
check=${var[$selection-1]}
echo ""
echo -e "${MAG}checking file integrity of $check${NC}"
echo ""

#set variable sum2 to --> run shasum on selected file

sum2=$(shasum -a 256 $dl_directory/$check | awk '{print $1}') 
#echo $sum2 | awk '{print $1}'


#check if sum1 and sum2 are equal

echo "SHA 256 checksum  of  file from website: $sum1"
echo "SHA 256 checksum of file you downloaded: $sum2"
echo""
if [ "$sum1" == "$sum2" ]; then
	echo -e "${GRN}YOUR CHECKSUMS MATCH!\n${NC}File inegrity verified."

else
	echo -e "${RED}!!!!!!!!!!WARNING!!!!!!!!!!\n${NC}These checksums do not match!\nFile integrity cannot be verified."
fi
