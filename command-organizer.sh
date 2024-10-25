#!/bin/zsh

# Commands to be stored in json format with text files to be added as an option
# Functionality: 
#	Add command
#	List commands
#	Search commands
#	Remove commands
# Script Outline:
#	Initialization: check if storage file exists if not create it
#	Menu: Provide a menu for user to choose actions (list, search, add, ...)
# Error handling:
#	Handle invalid inputs, missing file...

# TODO - Remove and search for commands

# COMMAND_FILE="commands.json"
COMMAND_FILE="commands.txt"

# Initialize the command file if it doesn't exist
if [ ! -f "${COMMAND_FILE}" ]; then
	echo "[]" > "${COMMAND_FILE}"

# TODO: To write to the file with some  Getting started docs 
# replace string with default header text
# cat << EOF > "${COMMAND_FILE}"
# []
# EOF
fi 

# Function to add a command
add_command(){
echo "Create a command name:"
read command_name
echo "command directive path options"
echo "Enter command:"
read command
echo "Enter directive:"
read directive
echo "Enter path:"
read path
echo "Enter options (comma-separted):"
read cmd_options
echo "Enter description:"
read description

# Write the command details to the command file
echo "command name: ${command_name}" >> "$COMMAND_FILE"
echo "command: $command" >> "$COMMAND_FILE"
echo "directive: $directive" >> "$COMMAND_FILE"
echo "path: $path" >> "$COMMAND_FILE"
echo "options: $cmd_options" >> "$COMMAND_FILE"
echo "description: $description" >> "$COMMAND_FILE"
echo "---" >> "$COMMAND_FILE"  # Separator for readability

# BUG: Add command to the JSON file
# jq --arg cmd "$command" --arg desc "$description" --arg opts "$options" \
# '. += [{"command": $cmd, "description": $desc, "options": $opts}]' \
# "$COMMAND_FILE" > tmp.$$.json &&  mv tmp.$$.json "$COMMAND_FILE"



echo "Command added successfully"

}


# List all commands
list_commands(){
jq -r --arg term "$term" '.[] | select(.command | contains($term)) | "\(.command): \(.description) [\(.options)]"' "$COMMAND_FILE"

}


# Main menu
while true; do
    echo "Choose an option:"
    echo "1. Add Command"
    echo "2. List Commands"
    echo "3. Search Command"
    echo "4. Exit"
    read choice

    case $choice in
        1) add_command ;;
        2) list_commands ;;
        3) search_command ;;
        4) exit 0 ;;
        *) echo "Invalid option. Please try again." ;;
    esac
done














