#!/bin/bash

#fucntion to delete file
delete_file(){
	echo "hi there, you are in the delete file function, trying to delete $1"
	rm $1
	echo deleted file: $1 
}

#fucntion to delete directory
delete_directory(){
	echo "hi there, you are in the delete directory function, trying to delete $1"
	#delete all contents of folder (specify how many files will be deleted, and total disk usage
	file_count=$(find $1 -type f | wc -l)
	echo "you are about to delete the folder $1, which has $file_count files in it"
	total_disk_usage=$(du $1 | grep "$1$" | awk '{print $1}')
	echo "the contents that you are about to delete take up $total_disk_usage bytes of disk storage"
	rm -r $1
	echo deleted directory: $1
}

#function to delete file or directory
delete_file_or_directory(){
	read -p "are you sure you want to delete $1? (y/n): " answer
	if [[ $answer == "n" ]]; then
		echo you answered no and so nothing is deleted
	elif [[ -e $1 ]]; then #if it exists
		if [[ -d $1 ]]; then #if directory, call on function to delete directory
			echo you chose to delete the following directory: $1
			delete_directory $1
		elif [[ -f $1 ]]; then #if file, call on function to delete file
			echo you chose to delete the following file: $1
			delete_file $1
		else
			echo you did not give a file or directory. Nothing deleted
		fi
	else #it doesnt exists
		echo "you gave a path that does not exists"
	fi
}

read -p "would you like to delete something? (y/n): " choice
while [[ $choice == "y" ]]; do
	echo "you chose to delete something, yay" 
	read -p "which file or directory would you like to delete?" path
	delete_file_or_directory $path
	read -p "would you like to delete something else?" choice
done

echo "you chose not to delete anything. good bye"

echo "  "
echo "1) Utilitiy Script"
echo "2) Read file script.sh"
echo "3) Delete Script"
echo "4) Quit"
