### Command-Line organizer Script Overview
The script uses `jq`, a command-line JSON processor, to add a new command entry to a JSON file. The new entry includes a command, description, and options. After updating the JSON file, it prints a success message.

### Detailed Explanation

1. **Setting Variables with `jq`**:
   ```sh
   jq --arg cmd "$command" --arg desc "$description" --arg opts "$options" \
   ```
   - `--arg cmd "$command"`: This sets a variable `$cmd` in `jq` with the value of the shell variable `$command`.
   - `--arg desc "$description"`: This sets a variable `$desc` in `jq` with the value of the shell variable `$description`.
   - `--arg opts "$options"`: This sets a variable `$opts` in `jq` with the value of the shell variable `$options`.

2. **Appending to JSON Array**:
   ```sh
   '. += [{"command": $cmd, "description": $desc, "options": $opts}]' \
   ```
   - `'. += ...'`: This is a `jq` filter that appends to the existing JSON array.
   - `[{"command": $cmd, "description": $desc, "options": $opts}]`: This creates a new JSON object with the fields `command`, `description`, and `options`, using the values of the `jq` variables `$cmd`, `$desc`, and `$opts`.

3. **Specifying the Input File**:
   ```sh
   "$COMMAND_FILE" > tmp.$$.json
   ```
   - `"$COMMAND_FILE"`: This specifies the input JSON file to be processed by `jq`.
   - `> tmp.$$.json`: This redirects the output of `jq` to a temporary file named `tmp.$$.json`. The `$$` is a special variable in shell scripting that represents the process ID of the current shell, ensuring a unique temporary file name.

4. **Moving the Temporary File**:
   ```sh
   && mv tmp.$$.json "$COMMAND_FILE"
   ```
   - `&&`: This ensures that the next command (`mv`) is only executed if the previous command (`jq`) succeeds.
   - `mv tmp.$$.json "$COMMAND_FILE"`: This moves (renames) the temporary file to the original file, effectively updating the original file with the new JSON content.

5. **Printing Success Message**:
   ```sh
   echo "Command added successfully!"
   ```
   - This prints a message to the terminal indicating that the command was added successfully.

### Full Script with Comments
Here is the full script with comments for clarity:

```sh
# Use jq to add a new command entry to the JSON file
jq --arg cmd "$command" --arg desc "$description" --arg opts "$options" \
   '. += [{"command": $cmd, "description": $desc, "options": $opts}]' \
   "$COMMAND_FILE" > tmp.$$.json && mv tmp.$$.json "$COMMAND_FILE"

# Print success message
echo "Command added successfully!"
```

### Summary
- **`jq --arg`**: Sets variables in `jq` with values from shell variables.
- **`'. += ...'`**: Appends a new JSON object to an existing JSON array.
- **`"$COMMAND_FILE" > tmp.$$.json`**: Redirects the output to a temporary file.
- **`mv tmp.$$.json "$COMMAND_FILE"`**: Replaces the original file with the updated content.
- **`echo "Command added successfully!"`**: Prints a success message.

