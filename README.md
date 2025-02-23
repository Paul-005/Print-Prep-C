# **Codestamp**

"CodeStamp is a script that processes program files by adding student information as a block comment, detects the programming language, renames files if needed, and converts them to .txt format. It uses a user-friendly GUI with zenity for file selection, input, and language choice, simplifying file management."

In Latest Update:

This Bash script automates the process of adding student details to C program files, compiling them, running them, and saving the output along with the program code in a text file.

This repository provides **Bash, PowerShell, and Batch scripts** to:
- Collect **student information** via GUI or CLI.
- Add student details as **comments** in C source files.
- Compile and run C programs, saving the **output** to a text file.

## **Supported Platforms**
| Script | OS Compatibility | GUI Support | Requires GCC |
|--------|-----------------|-------------|-------------|
| **Bash (`automate.sh`)** | Linux, Mac (WSL on Windows) | ✅ Yes (Zenity) | ✅ Yes |
| **PowerShell (`automate.ps1`)** | Windows | ✅ Yes (Forms) | ✅ Yes |
| **Batch (`automate.bat`)** | Windows | ❌ No (CLI) | ✅ Yes |

---

## **Prerequisites**
### 🔹 **For Windows Users (PowerShell & Batch)**
1. **Install `gcc` (MinGW-w64)**
   - Download: [MinGW-w64](https://www.mingw-w64.org/)
   - Add `C:\MinGW\bin` (or equivalent) to **System PATH**.
2. **(PowerShell Only) Enable Script Execution**
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force
   ```

### 🔹 **For Linux/Mac Users (Bash)**
- Install `gcc` and `zenity` (if not already installed):
  ```bash
  sudo apt install gcc zenity  # Debian/Ubuntu
  sudo yum install gcc zenity  # CentOS/RHEL
  brew install gcc             # macOS (Homebrew)
  ```

---

## **Usage**
### **1️⃣ Bash (`automate.sh`) – Linux/Mac**
#### **Run the script**
```bash
bash automate.sh
```
#### **How it works:**
1. A **GUI** (Zenity) collects **student details**.
2. Select **C files** to process.
3. It **compiles, runs** the program, and saves the output in `PRINT_FOLDER`.

---

### **2️⃣ PowerShell (`automate.ps1`) – Windows**
#### **Run the script**
```powershell
powershell -ExecutionPolicy Bypass -File automate.ps1
```
#### **How it works:**
1. A **GUI** (Windows Forms) collects **student details**.
2. Select **C files** through a file dialog.
3. It **compiles, runs** the program, and saves the output in `PRINT_FOLDER`.

---

### **3️⃣ Batch (`automate.bat`) – Windows (CLI)**
#### **Run the script**
1. **Double-click** `automate.bat` or run:
   ```cmd
   automate.bat
   ```
2. Enter **student details** manually.
3. Drag & drop a `.c` file into the terminal when prompted.
4. The script **compiles, runs** the program, and saves the output in `PRINT_FOLDER`.

---

## **Output Format**
Each processed file (`PRINT_FOLDER/program.txt`) contains:
```txt
####################
Program Title: [Your Title]
Student Name: John Doe
Class: CS101
Roll No: 12345
####################

[Original C Code]

OUTPUT
[Program Execution Output]
```

---

## **Contributors**
- **[OpjeTrinity](https://github.com/OpjeTrinity)**
- **[Paul-005](https://github.com/Paul-005)**

## **Report Issues**
🔗 **Submit Issues or Feature Requests:**  
[GitHub Issues](https://github.com/Paul-005/Print-Prep-C/issues)
[GitHub Issues](https://github.com/OpjeTrinity/Codestamp/issues)
