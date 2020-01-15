Set-ExecutionPolicy RemoteSigned
# dot sourcing https://mcpmag.com/articles/2017/02/02/exploring-dot-sourcing-in-powershell.aspx 
# This line of code allows the use of functions from the references ps1 file
. .\Exchange_Functions.ps1

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
                connect_EOL
                
                #return
               }


           '2' {
               Clear-Host 
               connect_local_exchange
               
               #return
              }
           
           
           'q' {
                #return
           }
     }
     pause
}
until ($input -eq '1,2,q')

$shared = read-host "Enter Shared Mailbox Name"
$User = read-host "Enter Full Name of User";
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