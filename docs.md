# GitGuard: Commit Message Verification Script

## Overview

GitGuard is a Python script designed to verify the format and adherence to conventions of Git commit messages. It ensures that commit messages follow a predefined pattern, helping maintain consistency and clarity within a development team.

## Components

1. **Color Codes**:
   - Defines ANSI escape sequences for colorizing output in the terminal.
   - Includes constants for various colors and styles used for printing error messages.

2. **`print_error(commit_msg, error_pos, error_msg, style)` Function**:
   - Prints an error message indicating an issue with the commit message.
   - Parameters:
     - `commit_msg`: The commit message being validated.
     - `error_pos`: The position in the commit message where the error occurred.
     - `error_msg`: The error message to display.
     - `style`: The style to apply to the error message (using color codes).

3. **`validate_commit_message(commit_msg)` Function**:
   - Validates the format of a commit message against predefined conventions.
   - Checks if the commit message follows a specific pattern, including prefix, scope (optional), and message body.
   - Returns `True` if the commit message is valid; otherwise, prints an error message using `print_error()` and returns `False`.

4. **`read_file(file_path)` Function**:
   - Reads the content of a file and returns it as a string.
   - Parameter:
     - `file_path`: The path to the file to be read.

5. **`get_commit_message(file_path)` Function**:
   - Retrieves the commit message from a file, validates it using `validate_commit_message()`, and returns it if valid.
   - Raises a `ValueError` with an error message if the commit message is invalid.
   - Parameter:
     - `file_path`: The path to the file containing the commit message.

6. **Main Block**:
   - Verifies the commit message provided as a command-line argument.
   - Prints a message indicating that the commit message is being verified.
   - Calls `get_commit_message()` with the file path provided as a command-line argument.
   - If the commit message is valid, prints a success message; otherwise, catches the `ValueError`, prints the error message, and exits with a status code of 1.
