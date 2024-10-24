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


COMMAND_FILE="commands.json"

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
echo "command structure: cmd description options"
echo "Enter command:"
read command
echo "Enter description:"
read description
echo "Enter options (comma-separted):"
read options

# Add command to the JSON file
jq --arg cmd "$command" --arg desc "$description" --arg opts "$options" \
'. += [{"command": $cmd, "description": $desc, "options": $opts}]' \
"$COMMAND_FILE" > tmp.$$.json &&  mv tmp.$$.json "$COMMAND_FILE"

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














