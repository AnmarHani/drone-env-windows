$command0 = "cd $($args[0]):\"
$command1 = "cygwin64\bin\bash.exe"

Invoke-Expression $command0
Invoke-Expression $command1
