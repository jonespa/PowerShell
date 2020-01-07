$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://hfexch01/PowerShell/ -Authentication Kerberos
Import-PSSession $Session

$targetMailboxes = Get-Mailbox -ResultSize unlimited # -Identity "rashidz" # comment out -identity bit when searching across all mailboxes
$targetMailboxes | Search-Mailbox -SearchQuery "Received:02/21/2019..02/21/2019 AND subject:'Ignore this email22' AND from:ross.lyons@h-f.co.uk" -EstimateResultOnly # -DeleteContent -Confirm:$false

Remove-PSSession $Session