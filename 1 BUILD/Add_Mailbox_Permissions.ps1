Set-ExecutionPolicy RemoteSigned
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking

$shared = read-host "Enter Shared Mailbox Name"
$User = read-host "Enter Full Name of User";

Add-MailboxPermission -identity "$Shared" -User "$User" -AccessRights FullAccess -InheritanceType all