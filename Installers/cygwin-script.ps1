$command0 = "cd $($args[0]):\"
$command1 = "cygwin64\bin\bash.exe"

Write-Host "----------------------------------------------"
Write-Host "Please Run This:"
Write-Host " "
Write-Host "cd $($args[1])"
Write-Host "----------------------------------------------"
Write-Host "Then Run This:"
Write-Host " "
Write-Host "$($args[2])"

Invoke-Expression $command0
Invoke-Expression $command1
