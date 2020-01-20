$Domain = "pisolicitors.com"
$RemoveSMTPDomain = "smtp:*@$Domain"
 
 
Get-Mailbox | Where-Object {$_.EmailAddresses -clike $RemoveSMTPDomain} | Export-Csv c:\temp\psolicitors.csv
 
<# 
ForEach ($Mailbox in $AllMailboxes)
{
 
       
   $AllEmailAddress  = $Mailbox.EmailAddresses -cnotlike $RemoveSMTPDomain
   $RemovedEmailAddress = $Mailbox.EmailAddresses -clike $RemoveDomainsmtp
   $MailboxID = $Mailbox.PrimarySmtpAddress 
   $MailboxID | Set-Mailbox -EmailAddresses $AllEmailAddress #-whatif
 
   Write-Host "The follwoing E-mail address where removed $RemovedEmailAddress from $MailboxID Mailbox "
   
 
} 
#>