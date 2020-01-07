##This script identifies which groups listed within a csv file have members and which do not.
Import-Module ActiveDirectory
$list = Import-Csv C:\users\bentleya\Documents\groups-Coop.csv
$HasMem = @()
$NoMem = @()
ForEach($l in $list) {
    $Group = Get-ADGroup -identity $l.group 
    $GroupMem = Get-ADGroupMember -Identity $Group  
    IF ($GroupMem -eq $null) {
    Write-Host "$($Group.Name) has no members"
    $NoMem += $Group.Name
    }
    ELSE {
    Write-Host "$($Group.Name) DOES have members"
    $HasMem += $Group.Name
    }

}
