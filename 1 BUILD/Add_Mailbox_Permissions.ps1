#Set-ExecutionPolicy RemoteSigned
#$UserCredential = Get-Credential
#$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
#Import-PSSession $Session -DisableNameChecking

#$shared = read-host "Enter Shared Mailbox Name"
#$User = read-host "Enter Full Name of User";

function Show-Menu
{
     param (
           [string]$Title = 'Permission level'
     )
     cls
     Write-Host "================ $Title ================"
    
     Write-Host "1: Press '1' for Full Access."
     Write-Host "2: Press '2' for Send As."
     Write-Host "3: Press '3' for Send on Behalf of."
     Write-Host "Q: Press 'Q' to quit."
}



#Add-MailboxPermission -identity "$Shared" -User "$User" -AccessRights FullAccess -InheritanceType all