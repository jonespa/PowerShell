Set-ExecutionPolicy RemoteSigned
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://hf-ex01/PowerShell/ -Authentication Kerberos
Import-PSSession $Session