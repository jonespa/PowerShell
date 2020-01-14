#Set-ExecutionPolicy RemoteSigned
#$UserCredential = Get-Credential
#$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
#Import-PSSession $Session -DisableNameChecking

#$shared = read-host "Enter Shared Mailbox Name"
#$User = read-host "Enter Full Name of User";

# https://www.business.com/articles/powershell-interactive-menu/

function Show-pickconnection
{
     param (
           [string]$Title = 'My Menu'
     )
     Clear-Host
     Write-Host "================ $Title ================"
    
     Write-Host "1: Press '1' for EOL."
     Write-Host "2: Press '2' for Local."
     Write-Host "Q: Press 'Q' to quit."
}

do
{
     Show-pickconnection
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
           '1' {
                Clear-Host 
                $confirm = Read-Host "Is the mailbox in the cloud? (Y/N)" 
                if ($confirm -eq "Y"){Add-MailboxPermission -identity "$Shared" -User "$User" -AccessRights FullAccess -InheritanceType all}
                elseif ($confirm -eq "N"){return}
                return
               }


           '2' {
               Clear-Host 
               $confirm = Read-Host "Is the Mailbox local? (Y/N)" 
               if ($confirm -eq "Y"){Add-MailboxPermission -identity "$Shared" -User "$User" -AccessRights sendas -InheritanceType all}
               elseif ($confirm -eq "N"){return}
               return
              }
           
           
           'q' {
                return
           }
     }
     pause
}
until ($input -eq 'q')


function Show-Menu
{
     param (
           [string]$Title = 'My Menu'
     )
     Clear-Host
     Write-Host "================ $Title ================"
    
     Write-Host "1: Press '1' for Full Access."
     Write-Host "2: Press '2' for Send As."
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
                $confirm = Read-Host "Do you want to grant $User 'Full Access' permission on $Shared Mailbox? (Y/N)" 
                if ($confirm -eq "Y"){Add-MailboxPermission -identity "$Shared" -User "$User" -AccessRights FullAccess -InheritanceType all}
                elseif ($confirm -eq "N"){return}
                return
               }


           '2' {
               Clear-Host 
               $confirm = Read-Host "Do you want to grant $User 'Send As' permission on $Shared Mailbox? (Y/N)" 
               if ($confirm -eq "Y"){Add-MailboxPermission -identity "$Shared" -User "$User" -AccessRights sendas -InheritanceType all}
               elseif ($confirm -eq "N"){return}
               return
              }
           
           
           'q' {
                return
           }
     }
     pause
}
until ($input -eq 'q')