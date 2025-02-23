Add-Type -AssemblyName System.Windows.Forms

function Get-StudentInfo {
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Student Info"
    $form.Size = New-Object System.Drawing.Size(300,250)
    $form.StartPosition = "CenterScreen"

    $lblName = New-Object System.Windows.Forms.Label
    $lblName.Text = "Student Name:"
    $lblName.Location = New-Object System.Drawing.Point(10,20)
    $form.Controls.Add($lblName)

    $txtName = New-Object System.Windows.Forms.TextBox
    $txtName.Location = New-Object System.Drawing.Point(120,20)
    $form.Controls.Add($txtName)

    $lblClass = New-Object System.Windows.Forms.Label
    $lblClass.Text = "Class:"
    $lblClass.Location = New-Object System.Drawing.Point(10,60)
    $form.Controls.Add($lblClass)

    $txtClass = New-Object System.Windows.Forms.TextBox
    $txtClass.Location = New-Object System.Drawing.Point(120,60)
    $form.Controls.Add($txtClass)

    $lblRoll = New-Object System.Windows.Forms.Label
    $lblRoll.Text = "Roll No:"
    $lblRoll.Location = New-Object System.Drawing.Point(10,100)
    $form.Controls.Add($lblRoll)

    $txtRoll = New-Object System.Windows.Forms.TextBox
    $txtRoll.Location = New-Object System.Drawing.Point(120,100)
    $form.Controls.Add($txtRoll)

    $btnOK = New-Object System.Windows.Forms.Button
    $btnOK.Text = "OK"
    $btnOK.Location = New-Object System.Drawing.Point(100,150)
    $btnOK.Add_Click({ $form.DialogResult = [System.Windows.Forms.DialogResult]::OK })
    $form.Controls.Add($btnOK)

    if ($form.ShowDialog() -eq "OK") {
        return @($txtName.Text, $txtClass.Text, $txtRoll.Text)
    } else {
        return $null
    }
}

# Get student info
$student = Get-StudentInfo
if ($student -eq $null) {
    Write-Host "No input provided. Exiting..."
    exit
}

$name = $student[0]
$class = $student[1]
$roll_no = $student[2]

# Select C file
$dialog = New-Object System.Windows.Forms.OpenFileDialog
$dialog.Filter = "C Files (*.c)|*.c"
$dialog.Multiselect = $true

if ($dialog.ShowDialog() -eq "OK") {
    $files = $dialog.FileNames
} else {
    Write-Host "No files selected. Exiting..."
    exit
}

# Create output folder
$output_folder = "PRINT_FOLDER"
New-Item -ItemType Directory -Force -Path $output_folder | Out-Null

foreach ($file in $files) {
    $program_title = Read-Host "Enter title for $(Split-Path $file -Leaf)"
    $output_file = "$output_folder\$(Split-Path $file -Leaf).txt"

    # Add student info to the file
    $comment = @"
####################
Program Title: $program_title
Student Name: $name
Class: $class
Roll No: $roll_no
####################

"@
    Set-Content -Path $output_file -Value $comment
    Add-Content -Path $output_file -Value (Get-Content $file)

    # Compile & Run the C program
    gcc $file -o temp_prog.exe
    if (Test-Path temp_prog.exe) {
        $output = .\temp_prog.exe
        Add-Content -Path $output_file -Value "`nOUTPUT`n$($output)"
        Remove-Item temp_prog.exe
    }
}

[System.Windows.Forms.MessageBox]::Show("Processing complete! Text files saved in $output_folder.", "Done", 0, 64)

