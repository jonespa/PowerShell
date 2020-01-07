##This script (page 227 of "learn powershell in a month of lunches") looks at the bios details of a remote machine. It prompts for the machine first and bombs out if the localhost (local machine name) is used.
$read = Read-Host "Enter Computer Name" ##text prompt within the shell for the computer name to run the WMI command against
IF ($read -eq "lt102616") {
    Write-Host "Dont use local machine!"             ##The if statement is checking for the name (originally entered as "localhost" but changed to my laptop name just to check it works
}
ELSE {
    Get-WmiObject -Class Win32_BIOS -ComputerName $read  ##The ELSE statement is where the wmi request is run from against the computername held within the $read variable
}