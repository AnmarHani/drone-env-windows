# todo
#download mission planner
#download visual studio code and build tools c++
#download needed python packages
#download vscode  if theres not
#run sitl
#open misionplanner
#open vscode with a simple script
#download pymavlink or whatever

$path = Get-Location
$downloads_counter = 0

if (!(Test-Path "$path\Installers")){
  New-Item -Path $path -Name "Installers" -ItemType "directory"
}

if (!(Test-Path "$path\ardupilot")){
  git clone https://github.com/ArduPilot/ardupilot.git
}

cd Installers
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
Read-Host "Continue to Open Simulator?"
C:\cygwin\bin\bash -c "command here"
Write-Host "If Nothing Happened or Error, please open cygwin terminal and write:"
Write-Host "cd /cygdrive/c"
Write-Host "cd /cygdrive/c"
