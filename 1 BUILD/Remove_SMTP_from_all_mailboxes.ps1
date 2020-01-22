$Domain = "zestlegal.co.uk"
$RemoveSMTPDomain = "smtp:*@$Domain"
 
 
$AllMailboxes = Get-Mailbox -resultsize unlimited | Where-Object {$_.EmailAddresses -like $RemoveSMTPDomain} #| Export-Csv c:\temp\pisolicitors.com.csv 
 
#<# 
ForEach ($Mailbox in $AllMailboxes)
{
 
       
   $AllEmailAddress  = $Mailbox.EmailAddresses -notlike $RemoveSMTPDomain
   $RemovedEmailAddress = $Mailbox.EmailAddresses -like $RemoveDomainsmtp
   $MailboxID = $Mailbox.PrimarySmtpAddress 
   $MailboxID | Set-Mailbox -EmailAddresses $AllEmailAddress #-whatif
 
   Write-Host "The follwoing E-mail address where removed $RemovedEmailAddress from $MailboxID Mailbox "
   
 
} 
#>