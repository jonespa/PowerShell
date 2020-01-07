Import-Module ActiveDirectory
$computers = Import-Csv C:\USR\BIN\2ndFl_AH_Computers.csv
$Computernm = $computers.name | Where-Object {($_ -like "WIN*") -or ($_ -like "LT*")}
$Servers = $computers.name | Where-Object {($_ -notlike "WIN*") -and ($_ -notlike "LT*")} 
$On = @()
$Off = @()
Foreach ($c in $computernm) {
IF (Test-Connection -BufferSize 32 -Count 1 -ComputerName $c -Quiet) {
        Write-Host "The remote computer " $c " is Online"
        $On += $C
} 
ELSE {
        Write-Host "The remote computer " $c " is Offline"
        $Off += $C
    }     

}

$On | Stop-Computer -Force

Start-Sleep -Seconds 600

Foreach ($c in $computernm) {
IF (Test-Connection -BufferSize 32 -Count 1 -ComputerName $c -Quiet) {
        Write-Host "The remote computer " $c " is Online"
        $On += $C
} 
ELSE {
        Write-Host "The remote computer " $c " is Offline"
        $Off += $C
    }     

}

$On | Stop-Computer -Force

