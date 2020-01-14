#Set-ExecutionPolicy RemoteSigned
#$UserCredential = Get-Credential
#$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
#Import-PSSession $Session -DisableNameChecking

#$shared = read-host "Enter Shared Mailbox Name"
#$User = read-host "Enter Full Name of User";

# https://www.business.com/articles/powershell-interactive-menu/

function Show-Menu
{
     param (
           [string]$Title = 'My Menu'
     )
     Clear-Host
     Write-Host "================ $Title ================"
    
     Write-Host "1: Press '1' for Full Access."
     Write-Host "2: Press '2' for Send As."
     Write-Host "3: Press '3' for Send on Behalf of."
     Write-Host "Q: Press 'Q' to quit."
}

do
{
     Show-Menu
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
           '1' {
                Clear-Host 
                $confirm = Read-Host "Do you want to grant $User Full access permission on $Shared Mailbox? (Y/N)" 
                if ($confirm -eq "Y"){Add-MailboxPermission -identity "$Shared" -User "$User" -AccessRights FullAccess -InheritanceType all}
                elseif ($confirm -eq "N"){return}
                return
                 

           }

           '2' {
                Clear-Host
                Read-Host "Do you want to grant $User Send-As permission on $Shared Mailbox?" | Add-MailboxPermission -identity "$Shared" -User "$User" -AccessRights Send-As -InheritanceType all
           } 
           
           '3' {
                Clear-Host
                Read-Host "Do you want to grant $User Send on Behalf of permission on $Shared Mailbox?" | Add-MailboxPermission -identity "$Shared" -User "$User" -AccessRights Send-As -InheritanceType all
           } 'q' {
                return
           }
     }
     pause
}
until ($input -eq 'q')



Add-MailboxPermission -identity "$Shared" -User "$User" -AccessRights FullAccess -InheritanceType all