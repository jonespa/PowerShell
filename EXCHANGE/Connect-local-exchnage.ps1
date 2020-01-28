Set-ExecutionPolicy RemoteSigned
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://mail.horwichfarrelly.co.uk/PowerShell/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking
