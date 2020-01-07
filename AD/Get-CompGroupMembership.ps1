#Import-Module ActiveDirectory
$CompList = Get-ADComputer -Filter * -Properties * -SearchBase "OU=Manchester,OU=CLIENT,OU=Computers,OU=Horwich Farrelly - Proposed New Structure,DC=horwichfarrelly,DC=com"

Import-Module ActiveDirectory
$CompList = Import-Csv C:\USR\BIN\CompList2_08052019.csv
$Computernm = $CompList.name
$GroupMem = Get-ADG

Get-ADComputer "mycomp" -Properties MemberOf | %{if ($_.MemberOf -like "*group name*") {Write-Host "found"} }

$g=Get-ADGroupMember -Identity "CN=myADgroup,OU=myOU,DC=corp,DC=com" -server corp.com
foreach($mbr in $g) {if($name.MemberOf -like "*mycomp*" -eq $true) {Write-Host "found"}}