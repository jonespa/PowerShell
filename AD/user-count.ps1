Import-Module ActiveDirectory
(Get-ADUser -Filter *).Count
2201
(Get-ADUser -Filter * | Where {$_.Enabled -eq "True"}).count
1554
(Get-ADUser -Filter * | Where {$_.Enabled -eq "True"}) & 
(Get-ADGroupMember -Identity "Domain Users").Count


Get-ADUser -Filter * | Where {($_.Enabled -eq "True") 

(Get-ADUser -Filter {mail -ne "*"}).Count

$users = (Get-ADUser -Filter * | Where {$_.Enabled -eq "True"})
$users | -filter