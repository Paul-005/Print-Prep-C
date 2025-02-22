#!/bin/bash

# Function to add student information and program output as comments
add_student_info() {
    local file=$1
    local name=$2
    local class=$3
    local roll_no=$4
    local program_title=$5
    local c_file=$6

    # Create the comment block
    comment="#################### \n"
    comment+="Program Title: ${program_title:-"Untitled Program"}\n"
    comment+="Student Name: $name\n"
    comment+="Class: $class\n"
    comment+="Roll No: $roll_no\n"
    comment+="#################### \n\n"

    # Create a temporary file with comment and content
    temp_file=$(mktemp)
    echo -e "$comment" > "$temp_file"
    cat "$file" >> "$temp_file"
    
    # Compile and run the C program, capture output
    echo -e "\nOUTPUT\n" >> "$temp_file"
    current_path="$(whoami)@$(hostname):$(dirname $(realpath "$c_file"))"
    echo -e "$current_path$ gcc $(basename "$c_file")" >> "$temp_file"
    
    # Compile the program
    gcc "$c_file" -o temp_prog
    
    if [ -f temp_prog ]; then
        echo -e "$current_path$ ./temp_prog" >> "$temp_file"
        # Run the program and capture complete interaction
        (script -f -q /dev/null -c "./temp_prog" | tee -a "$temp_file") 2>&1
        rm temp_prog
    fi

    mv "$temp_file" "$file"
}

# Get student details
name=$(zenity --entry --title="Student Info" --text="Enter student name:" --width=300)
class=$(zenity --entry --title="Student Info" --text="Enter class:" --width=300)
roll_no=$(zenity --entry --title="Student Info" --text="Enter roll number:" --width=300)

# Check if all fields are filled
if [ -z "$name" ] || [ -z "$class" ] || [ -z "$roll_no" ]; then
    zenity --error --text="All fields are required!"
    exit 1
fi

# Select C files
files=$(zenity --file-selection --title="Select C files" --file-filter="*.c" --multiple --separator="|")
if [ -z "$files" ]; then
    zenity --error --text="No files selected!"
    exit 1
fi

# Create output folder for text files
output_folder="PRINT_FOLDER"
mkdir -p "$output_folder"

# Process each file
IFS="|"
for file in $files; do
    # Get program title for this file
    program_title=$(zenity --entry --title="Program Title" --text="Enter title for $(basename "$file"):" --width=300)
    
    # First create the text copy
    output_file="$output_folder/$(basename "${file%.*}").txt"
    cp "$file" "$output_file"
    
    # Then add student info and program output only to the text copy
    add_student_info "$output_file" "$name" "$class" "$roll_no" "$program_title" "$file"
done

zenity --info --text="Processing complete!\nText copies with student info and program output are in the '$output_folder' folder.\nOriginal C files remain unchanged."