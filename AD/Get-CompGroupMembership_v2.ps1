Import-Module ActiveDirectory
$Computers = Import-Csv C:\USR\BIN\CompList2_08052019.csv
$ComputerName = $Computers.Name

ForEach ($Computer in $ComputerName) {
    
  $GC = Get-ADComputer $Computer -Properties MemberOf, Name
  
  IF ($GC.MemberOf -eq "CN=ROL_COMP_CLIENT,OU=CLIENT ROLE GROUPS,OU=COMPUTER ROLE GROUPS,OU=Role Groups,OU=Groups,OU=Horwich Farrelly - Proposed New Structure,DC=horwichfarrelly,DC=com") {
  Write-Host "$($GC.Name) is a member"
  }
  
  ELSE {
  Write-Host "$($GC.Name) is NOT a member"
  }

 }



#$2 = Get-ADComputer -Filter * -SearchBase "OU=Manchester,OU=CLIENT,OU=Computers,OU=Horwich Farrelly - Proposed New Structure,DC=horwichfarrelly,DC=com" -Properties Name, Memberof | Where-Object {$_.MemberOf -notlike 'CN=ROL_COMP_CLIENT'} | Select-Object Name

#$3 = Get-ADComputer -Filter * -SearchBase "OU=Manchester,OU=CLIENT,OU=Computers,OU=Horwich Farrelly - Proposed New Structure,DC=horwichfarrelly,DC=com" -Properties Name, Memberof | Select-Object Name, MemberOf
#$4 = $3 | Where-Object {$_.MemberOf -notmatch "ROL_COMP_CLIENT"} | Select-Object Name

#Get-ADComputer -Filter * -SearchBase "OU=Manchester,OU=CLIENT,OU=Computers,OU=Horwich Farrelly
#- Proposed New Structure,DC=horwichfarrelly,DC=com" -Properties DNSHostName, Memberof | Where-Object {$_.MemberOf -match 'CN=ROL_COMP_CLIENT'} | Select-Object DNSHostName