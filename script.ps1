#$simulator = Read-Host "Please enter your age"
$path = Get-Location

if (!(Test-Path "$path\Installers")){
  New-Item -Path $path -Name "Installers" -ItemType "directory"
}

cd Installers
if (!(Test-Path "$path\Installers\python-3.11.0-amd64.exe")){
  Invoke-WebRequest "https://www.python.org/ftp/python/3.11.0/python-3.11.0-amd64.exe" -OutFile "$path\Installers\python-3.11.0-amd64.exe"
  .\"python-3.11.0-amd64.exe"
  Read-Host "Continue If Finished"
}
if (!(Test-Path "$path\Installers\Git-2.38.1-64-bit.exe")){
  Invoke-WebRequest "https://github.com/git-for-windows/git/releases/download/v2.38.1.windows.1/Git-2.38.1-64-bit.exe" -OutFile "$path\Installers\Git-2.38.1-64-bit.exe"
  .\"Git-2.38.1-64-bit.exe"
  Read-Host "Continue If Finished"
}

[System.Windows.MessageBox]::Show("Please Restart Your Computer!", "IMPORTANT MESSAGE", "OK", "Warning")



# Invoke-WebRequest $myDownloadUrl -OutFile c:\file.ext
# if (!(Test-Path -path $exactadminfile)){
  
# }
