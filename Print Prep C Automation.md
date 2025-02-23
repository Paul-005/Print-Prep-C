# Print Prep C Automation Script - README

This script automates the process of adding student information, program titles, and compilation/execution output to text copies of your C source files.

## Usage

1.  **Download the script:** Download the `automate.c.sh` script to a directory on your system.
2.  **Open Terminal:** Open your terminal and navigate to the directory where you downloaded the script.
3.  **Make the script executable:** Run the following command:

    ```bash
    chmod +x automate.c.sh
    ```

4.  **Run the script:** Execute the script using:

    ```bash
    ./automate.c.sh
    ```

5.  **Provide Student Information:**
    * The script will prompt you to enter the student's name, class, and roll number using `zenity` dialog boxes.
    * It will then ask you to confirm the entered information.
    * If the information is incorrect, you can re-enter it.
6.  **Select C Files:**
    * A file selection dialog will appear, allowing you to choose one or more C source files (`.c`).
    * You can select multiple files using the appropriate selection method for your file manager.
7.  **Enter Program Titles:**
    * For each selected C file, you will be prompted to enter a program title.
    * If you don't enter anything the title will be "Untitled Program".
8.  **Processing:**
    * The script will create a folder named `PRINT_FOLDER` in the same directory as the script.
    * For each selected C file, it will:
        * Create a text copy of the C file in the `PRINT_FOLDER` directory, with the `.txt` extension.
        * Add the student information and program title as comments at the beginning of the text file.
        * Compile the C program using `gcc`.
        * Run the compiled program and capture its output, including any user input/output.
        * Add the compilation and execution commands, along with the captured output, as comments to the text file.
        * If the C file does not compile the script will still add the student information, and program title, but the output section of the file will contain only the attempted gcc command.
9.  **Completion:**
    * A `zenity` dialog will indicate that the processing is complete.
    * You can find the converted text files in the `PRINT_FOLDER` directory.
    * You can then view and edit these text files as needed.

## Example Output (Inside the .txt file)
