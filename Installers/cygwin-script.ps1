$command0 = "cd C:\"
$command1 = "cygwin64\bin\bash.exe"

Write-Host "----------------------------------------------"
Write-Host "I Tried To Open Cygwin64 Terminal In This Terminal, So Try To Run The Commands Down Here,"
Write-Host "If It Didnt work Then Try To Manually Open Cygwin64 Terminal Manually from your Desktop or This Folder."
Write-Host "----------------------------------------------"
Write-Host "Please Run This:"
Write-Host " "
Write-Host "cd $($args[1])"
Write-Host "----------------------------------------------"
Write-Host "Then Run This:"
Write-Host " "
Write-Host "$($args[2]) -v ArduCopter --map --console"

Invoke-Expression $command0
Invoke-Expression $command1
Read-Host
