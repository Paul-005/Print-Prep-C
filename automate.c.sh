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
    comment+="Student Name: $name\n"
    comment+="Class: $class\n"
    comment+="Roll No: $roll_no\n"
    comment+="#################### \n\n"
    comment+="#### ${program_title:-"Untitled Program"} ####\n\n"

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


# Function to get student details with validation and ability to edit specific field
get_student_details() {
    local name class roll_no

    # Initial collection of details
    while true; do
        name=$(zenity --entry --title="Student Info" --text="Enter student name:" --width=300)
        class=$(zenity --entry --title="Student Info" --text="Enter class:" --width=300)
        roll_no=$(zenity --entry --title="Student Info" --text="Enter roll number:" --width=300)

        # If any field is empty, show error message
        if [ -z "$name" ] || [ -z "$class" ] || [ -z "$roll_no" ]; then
            zenity --error --text="All fields are required!"
        else
            break
        fi
    done

    # Allow the user to confirm or edit specific fields
    while true; do
        confirmation=$(zenity --question --title="Confirm Details" --text="Student Name: $name\nClass: $class\nRoll No: $roll_no\nIs this correct?" --width=300 --ok-label="Yes" --cancel-label="Edit Details")

        if [ $? -eq 0 ]; then
            break  # Proceed if everything is correct
        else
            # Allow the user to choose which field to edit
            edit_choice=$(zenity --list --title="Edit Information" --text="Select a field to edit:" --radiolist --column="Select" --column="Field" TRUE "Name" FALSE "Class" FALSE "Roll No")

            case $edit_choice in
                "Name")
                    name=$(zenity --entry --title="Edit Student Name" --text="Enter new student name:" --width=300)
                    ;;
                "Class")
                    class=$(zenity --entry --title="Edit Class" --text="Enter new class:" --width=300)
                    ;;
                "Roll No")
                    roll_no=$(zenity --entry --title="Edit Roll Number" --text="Enter new roll number:" --width=300)
                    ;;
                *)
                    continue
                    ;;
            esac
        fi
    done

    echo "$name $class $roll_no"
}

# Select C files
files=$(zenity --file-selection --title="Select C files" --file-filter="*.c" --multiple --separator="|")
if [ -z "$files" ]; then
    zenity --error --text="No files selected!"
    exit 1
fi

# Create output folder for text files
output_folder="PRINT_FOLDER"
mkdir -p "$output_folder"

# Get student details with the new function
student_details=$(get_student_details)
name=$(echo $student_details | cut -d ' ' -f 1)
class=$(echo $student_details | cut -d ' ' -f 2)
roll_no=$(echo $student_details | cut -d ' ' -f 3)

# Process each file
IFS="|"
for file in $files; do
    # Get program title for this file
    program_title=$(zenity --entry --title="Program Title" --text="Enter title for $(basename "$file"):" --width=300)
    
    # First create the text copy
    output_file="$output_folder/$(basename "${file%.*}").txt"
    cp "$file" "$output_file"
    
    echo
    echo "executing $(basename "$file"):.." 
    echo
    
    # Then add student info and program output only to the text copy
    add_student_info "$output_file" "$name" "$class" "$roll_no" "$program_title" "$file"
    echo
    echo
done


zenity --info --text="Processing complete!\n\nText copies with student info and program output are in the '$output_folder' folder. \nPlease ensure all generated texts are correct before using.\n\nContributors: <a href=\"https://github.com/Paul-005\">PAUL</a> and <a href=\"https://github.com/OpjeTrinity\">VIVEK</a>\n\nIf you encounter any issues or bugs, please report them on GitHub: <a href=\"https://github.com/Paul-005/Print-Prep-C/issues\">Report Issues Here</a>"
