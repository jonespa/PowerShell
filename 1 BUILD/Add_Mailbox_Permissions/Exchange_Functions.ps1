function connect_local_exchange

{
    Set-ExecutionPolicy RemoteSigned
    $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://hf-ex01/PowerShell/ -Authentication Kerberos
    Import-PSSession $Session
}

Function connect_EOL
{
    Set-ExecutionPolicy RemoteSigned
    $UserCredential = Get-Credential
    $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
    Import-PSSession $Session -DisableNameChecking
}