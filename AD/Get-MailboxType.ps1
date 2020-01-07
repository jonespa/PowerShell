$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://hf-ex01/PowerShell/ -Authentication Kerberos
Import-PSSession $Session

## To get the list of options available for the Select-Object switch, run Get-MailboxStatistics on a single mailbox (e.g. horwichfarrelly\bentleya) in a variable then run the variable and pipe to Format-List (| FL)

Get-Mailbox * -ResultSize Unlimited | Get-mailboxStatistics | Select-Object DisplayName, MailboxTypeDetail | Sort MailboxTypeDetail | Export-Csv [path]