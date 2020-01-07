Test-Connection lt102893 | gm ipv4address | Format-list

##$iphost = [System.Net.NetworkInformation]::PingTest("lt102893")

$ping = New-Object System.Net.NetworkInformation.Ping