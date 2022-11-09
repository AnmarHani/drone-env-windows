# todo
#download needed python packages
#download pymavlink or whatever

$path = Get-Location
$downloads_counter = 0

if (!(Test-Path "$path\Installers")){
  New-Item -Path $path -Name "Installers" -ItemType "directory"
}

if (!(Test-Path "$path\ardupilot")){
  git clone https://github.com/ArduPilot/ardupilot.git
}

$have_vscode = Read-Host "Do u have vscode? 0 for no"
if($have_vstudio -eq 0){
  Write-Host "Download It From Here:"
  Write-Host "https://code.visualstudio.com/download#"
  Read-Host "Continue?"
}

cd Scripts
pip freeze > requirements.txt
pip install -r requirements.txt

cd ..

cd Installers
$have_vstudio = Read-Host "Do u have visual studio community? 0 for no, 1 for yes"

if($have_vstudio -eq 1){
  Write-Host "Please Download C++ Build Tools"
  Invoke-WebRequest "https://aka.ms/vs/17/release/vs_BuildTools.exe" -OutFile "$path\Installers\vs_BuildTools.exe"
  .\"vs_BuildTools.exe"
}
if($have_vstudio -eq 0){
  Write-Host "Download It From Here:"
  Write-Host "https://visualstudio.microsoft.com/downloads/"
  Write-Host "Please Rerun This File And Choose Yes"
  Exit
}

if (!(Test-Path "$path\Installers\MissionPlanner-latest.msi")){
  New-Item -Path $path -Name "missionplanner" -ItemType "directory"
  Write-Host "Please Download It Under $path/missionplanner/"
  Invoke-WebRequest "https://firmware.ardupilot.org/Tools/MissionPlanner/MissionPlanner-latest.msi" -OutFile "$path\Installers\MissionPlanner-latest.msi"
  .\"MissionPlanner-latest.msi"
}

if (!(Test-Path "$path\Installers\python-3.11.0-amd64.exe")){
  Invoke-WebRequest "https://www.python.org/ftp/python/3.11.0/python-3.11.0-amd64.exe" -OutFile "$path\Installers\python-3.11.0-amd64.exe"
  .\"python-3.11.0-amd64.exe"
  $downloads_counter++
}
if (!(Test-Path "$path\Installers\Git-2.38.1-64-bit.exe")){
  Invoke-WebRequest "https://github.com/git-for-windows/git/releases/download/v2.38.1.windows.1/Git-2.38.1-64-bit.exe" -OutFile "$path\Installers\Git-2.38.1-64-bit.exe"
  .\"Git-2.38.1-64-bit.exe"
  $downloads_counter++
}

if($downloads_counter -eq 2){
  Read-Host "Your Computer Will Be Restarted, Press Enter, or Cancel with exiting terminal"
  Restart-Computer
}

if (!(Test-Path "$path\Installers\MAVProxySetup-latest.exe")){
  Write-Output "Starting Downloads"

  Write-Output "Downloading MAVProxy (1/7)"
  Start-BitsTransfer -Source "https://firmware.ardupilot.org/Tools/MAVProxy/MAVProxySetup-latest.exe" -Destination "$PSScriptRoot\MAVProxySetup-latest.exe"

  Write-Output "Downloading Cygwin x64 (2/7)"
  Start-BitsTransfer -Source "https://cygwin.com/setup-x86_64.exe" -Destination "$PSScriptRoot\setup-x86_64.exe"

  Write-Output "Downloading ARM GCC Compiler 10-2020-Q4-Major (3/7)"
  Start-BitsTransfer -Source "https://firmware.ardupilot.org/Tools/STM32-tools/gcc-arm-none-eabi-10-2020-q4-major-win32.exe" -Destination "$PSScriptRoot\gcc-arm-none-eabi-10-2020-q4-major-win32.exe"

  Write-Output "Installing Cygwin x64 (4/7)"
  Start-Process -wait -FilePath $PSScriptRoot\setup-x86_64.exe -ArgumentList "--root=C:\cygwin64 --no-startmenu --local-package-dir=$env:USERPROFILE\Downloads --site=http://cygwin.mirror.constant.com --packages autoconf,automake,ccache,cygwin32-gcc-g++,gcc-g++=7.4.0-1,libgcc1=7.4.0.1,gcc-core=7.4.0-1,git,libtool,make,gawk,libexpat-devel,libxml2-devel,python37,python37-future,python37-lxml,python37-pip,libxslt-devel,python37-devel,procps-ng,zip,gdb,ddd,xterm --quiet-mode"
  Start-Process -wait -FilePath "C:\cygwin64\bin\bash" -ArgumentList "--login -i -c 'ln -sf /usr/bin/python3.7 /usr/bin/python'"
  Start-Process -wait -FilePath "C:\cygwin64\bin\bash" -ArgumentList "--login -i -c 'ln -sf /usr/bin/pip3.7 /usr/bin/pip'"

  Write-Output "Downloading extra Python packages (5/7)"
  Start-Process -wait -FilePath "C:\cygwin64\bin\bash" -ArgumentList "--login -i -c 'pip install empy pyserial pymavlink intelhex dronecan pexpect'"

  Write-Output "Installing ARM GCC Compiler 10-2020-Q4-Major (6/7)"
  & $PSScriptRoot\gcc-arm-none-eabi-10-2020-q4-major-win32.exe /S /P /R

  Write-Output "Installing MAVProxy (7/7)"
  & $PSScriptRoot\MAVProxySetup-latest.exe /SILENT | Out-Null

  Write-Host "Finished. Press any key to continue ..."
  $x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

cd ..
cd ardupilot
git submodule update --init --recursive

Read-Host "Continue to Open Simulator?"
Write-Host "Please open cygwin terminal and write:"
$drive = Read-Host "Desktop in C or D or E disk?, or Write The Name of disk"
Write-Host "cd /cygdrive/$drive/$env:UserName/$path/ardupilot"
Write-Host "./Tools/autotest/sim_vehicle.py --map --console"

Read-Host "Continue With Ground Station?"
cd ..
cd missionplanner
.\"MissionPlanner.exe"

Read-Host "Please Connect Ground Station With SITL and Continue"

Read-Host "Continue and Open Python Script?"
cd ..
cd Scripts
code .
