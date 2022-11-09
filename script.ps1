#$simulator = Read-Host "Please enter your age"
$path = Get-Location

Write-Host "Please Download & Setup Python From This URL:"
Write-Host "https://www.python.org/ftp/python/3.11.0/python-3.11.0-amd64.exe"
Read-Host "Please enter continue"

Write-Host "Please Download & Setup GIT From This URL:"
Write-Host "https://github.com/git-for-windows/git/releases/download/v2.38.1.windows.1/Git-2.38.1-64-bit.exe"
Read-Host "Please enter continue"

Write-Host "Please Restart Your Computer"
Restart-Computer
