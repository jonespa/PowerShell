Import-Module ActiveDirectory
$Date = Get-Date
$Users = Get-ADUser -Properties * -Filter {AccountExpirationDate -lt $Date} | Where-Object {($_.DistinguishedName -notlike '*OU=Users,OU=Retired,OU=Horwich Farrelly - Proposed New Structure,DC=horwichfarrelly,DC=com') -and ($_.Name -notlike "*Do not delete*")}
$UserList = $Users.Name
$UserList2 = $Users.samAccountName
$Names = $UserList | Out-String
$SMTPServer = "hf-ex01"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://hfexch01/PowerShell/ -Authentication Kerberos
Import-PSSession $Session

ForEach ($user in $Users) {
Disable-ADAccount -Identity $user.samAccountName
Move-ADObject $users -TargetPath 'OU=Users,OU=Retired,OU=Horwich Farrelly - Proposed New Structure,DC=horwichfarrelly,DC=com' 
$Manager = Get-ADUser $User.Manager
Get-ChildItem -Path \\hfsan01\profiles\xenapp65 | Where-Object {$_.Name -like "$($user.SamAccountName)*"} | Remove-Item -Force
Move-Item -Path "\\HFFS01\Userdata$\$($user.SamAccountName)" -Destination "\\HFFS01\Userdata$\0 Leavers Archive"
$mailbox = Get-Mailbox -Identity $user.samAccountName
Set-Mailbox -HiddenFromAddressListsEnabled $true -Identity $mailbox 
Set-Mailbox $Mailbox -ForwardingAddress $Manager.mail -DeliverToMailboxAndForward $false
New-MoveRequest –Identity $Mailbox -TargetDatabase HF-DAG1-LEAVERS   
}           


