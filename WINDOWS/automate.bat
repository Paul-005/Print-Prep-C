@echo off
setlocal enabledelayedexpansion

:: Collect student information
echo Enter Student Name:
set /p name=
echo Enter Class:
set /p class=
echo Enter Roll No:
set /p roll_no=

:: Select C file
echo Drag and drop the C file here and press Enter:
set /p file=

if not exist "!file!" (
    echo No file selected. Exiting...
    exit /b
)

:: Create output folder
set output_folder=PRINT_FOLDER
mkdir "!output_folder!" 2>nul

:: Extract filename without extension
for %%F in ("!file!") do set filename=%%~nF

:: Prompt for program title
echo Enter title for "!filename!.c":
set /p program_title=

:: Create output file
set output_file=!output_folder!\!filename!.txt

:: Write student info
(
echo ####################
echo Program Title: !program_title!
echo Student Name: !name!
echo Class: !class!
echo Roll No: !roll_no!
echo ####################
echo.
) > "!output_file!"

:: Append source code to text file
type "!file!" >> "!output_file!"

:: Compile the C file (requires MinGW)
gcc "!file!" -o temp_prog.exe 2> error.log
if exist temp_prog.exe (
    echo OUTPUT >> "!output_file!"
    temp_prog.exe >> "!output_file!"
    del temp_prog.exe
) else (
    echo Compilation Failed! Check error.log for details. >> "!output_file!"
)

echo Processing complete! Text files saved in "!output_folder!".
pause

