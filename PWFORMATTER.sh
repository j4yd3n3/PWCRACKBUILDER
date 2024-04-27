#!/bin/bash

# This script is used to take in a word list
# and output the same files contents in a 
# format that most people use for their passwords
# This script will also remove dupplicate words

# EX Input:  I love computers
# EX Output: i love computers
#	     i_love_computers
#	     ilovecomputers


# Notice how all of the outputted formats are
# lowercase. It is expected that the user will
# apply some sort of toggle rules in 
# conjunction with rules of their choice

# Check if an input filename is provided
if [ $# -eq 0 ]; then
  echo "No arguments provided. Please provide a filename."
  exit 1
fi

input_filename=$1
output_filename=$2
temp_file=$(mktemp)

totalLines=$(cat $input_filename| wc -l)
uniqueLines=$(sort $input_filename | uniq | wc -l)
linesDeleted=$(($totalLines-uniqueLines))
#The follolwing 2 lines are mostly used for debugging purposes but will display the # of deleted lines and the # of unique lines
#echo "Lines Deleted: $linesDeleted"
#echo "Unique lines: $uniqueLines"

uniq $input_filename | awk 'BEGIN {FS=" "; OFS="_"} {for(i=1;i<=NF;i++) $i=$i; print}' > temp_file
uniq $input_filename >> temp_file
uniq $input_filename | tr -d ' ' >> temp_file

sort temp_file | tr '[:upper:]' '[:lower:]' | uniq

rm "$temp_file"
