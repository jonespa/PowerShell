Import-Module ActiveDirectory
$Computers = Import-Csv C:\USR\BIN\CompList2_08052019.csv
$ComputerName = $Computers.Name

ForEach ($Computer in $ComputerName) {
    
  $GC = Get-ADComputer $Computer -Properties MemberOf, Name
  
  IF ($GC.MemberOf -eq "CN=ROL_COMP_CLIENT,OU=CLIENT ROLE GROUPS,OU=COMPUTER ROLE GROUPS,OU=Role Groups,OU=Groups,OU=Horwich Farrelly - Proposed New Structure,DC=horwichfarrelly,DC=com") {
  Write-Host "$($GC.Name) is a member"
  Out-File -InputObject $GC.Name -FilePath C:\usr\BIN\IsAMember.txt -Append
  }
  
  ELSE {
  Write-Host "$($GC.Name) is NOT a member"
  Out-File -InputObject $GC.Name -FilePath C:\usr\BIN\IsNotAMember.txt -Append
  }

 }