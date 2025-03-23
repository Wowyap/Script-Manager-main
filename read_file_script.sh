#!/bin/bash

line_count=0
word_count=0

while IFS= read -r line; do
        echo "line $((line_count + 1)): $line"

        words_in_line=$(echo "$line" | wc -w)
        word_count=$((word_count + words_in_line))

        echo "Number of words in this line: $words_in_line"
        line_count=$((line_count + 1))

done < "$1"

file_size=$(du -hs)

echo "Total line number is: $line_count"
echo "Total word number is: $word_count"
echo "Total file size is: $file_size"

if [[ -n "$2" ]]; then
    echo "Searching for: $2"
    grep -n "$2" "$1" | while IFS=: read -r line_num content; do
        word_pos=$(echo "$content" | awk -v word="$2" '
        {
            for (i=1; i<=NF; i++)
                if ($i == word) print i
        }')

        if [[ -n "$word_pos" ]]; then
            echo "Found at line $line_num, word position(s): $word_pos"
        fi
    done
fi

echo "  "
echo "1) Utilitiy Script"
echo "2) Read file script.sh"
echo "3) Delete Script"
echo "4) Quit"
