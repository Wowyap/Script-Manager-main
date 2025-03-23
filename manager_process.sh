#!/bin/bash

options=("Utility script" "Read file script" "Delete script" "Quit")

select script in "${options[@]}"; do
        case $script in
                "Utility script")
                        ./utility_script.sh
                        ;;
                "Read file script")
                         read -p "Enter file name: " file_name
			 read -p "Enter word for search(or press Enter): " srch_word
                        ./read_file_script.sh $file_name $srch_word
                        ;;
                "Delete script") 
                        ./delete_script.sh
                        ;;
                "Quit")
                        echo "Exiting.."
                        break
                        ;;
                *)
                        echo "Invalid option"
                        ;;
        esac
done
