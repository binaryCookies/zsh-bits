
# Stop tracking local files in Git. 
# Suitable for not sharing local files such as environmen configuration files
# Usage example:
# assumeUnchanged "public/js/model/http.config.js"

# mySript.sh assumeUnchanged 
# arg: path/to/local/file/you/want/to/git/to/ignore

#!/bin/zsh

# Function to display help information
showHelp() {
    cat << EOF
# basename gives name of script without path
Usage: $(basename "$0") [options]

Options:
  -l                List available Git scripts.
  -h <script>       Print help for the specified script.

Examples:
  $(basename "$0") -l
  $(basename "$0") -h assumeUnchanged

Description:
  This script provides various Git utilities to manage local files and configurations.
EOF
}

# Example usage of the showHelp function
showHelp
assumeUnchanged() {
local path="$1"

if [! -f "$path"]; then
	echo "Error: File '$path' does not exist."
fi

git update-index --assume-unchanged public/js/model/http.config.js

# Check if the command was successful
if [ $? -eq 0 ]; then
        echo "Successfully marked '$path' as assume-unchanged."
    else
        echo "Error: Failed to mark '$path' as assume-unchanged."
        return 1
 fi
}

# git checkout -b branch-name
# git commit --allow-empty -m "Updated index to stop tracking changes to http.config.js"
