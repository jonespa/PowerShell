##Script to clear down the access logs on the 3 servers within the Exchange environment
Get-ChildItem "\\hf-ex01\logs" -Recurse | Where-Object {-not $_.PsIsContainer} | Where{$_.CreationTime -lt (Get-Date).AddDays(-7)} | Remove-Item
Get-ChildItem "\\hf-ex01\Mapi" -Recurse | Where-Object {-not $_.PsIsContainer} | Where{$_.CreationTime -lt (Get-Date).AddDays(-7)} | Remove-Item
Get-ChildItem "\\hf-ex01\MapiHttp" -Recurse | Where-Object {-not $_.PsIsContainer} | Where{$_.CreationTime -lt (Get-Date).AddDays(-7)} | Remove-Item

Get-ChildItem "\\hf-ex02\logs" -Recurse | Where-Object {-not $_.PsIsContainer} | Where{$_.CreationTime -lt (Get-Date).AddDays(-7)} | Remove-Item
Get-ChildItem "\\hf-ex02\Mapi" -Recurse | Where-Object {-not $_.PsIsContainer} | Where{$_.CreationTime -lt (Get-Date).AddDays(-7)} | Remove-Item
Get-ChildItem "\\hf-ex02\MapiHttp" -Recurse | Where-Object {-not $_.PsIsContainer} | Where{$_.CreationTime -lt (Get-Date).AddDays(-7)} | Remove-Item

#Get-ChildItem "\\dr-ex03\c$\inetpub\logs" -Recurse | Where-Object {-not $_.PsIsContainer} | Where{$_.CreationTime -lt (Get-Date).AddDays(-7)}
#Get-ChildItem "\\dr-ex03\c$\Program Files\Microsoft\Exchange Server\V15\Logging\HttpProxy\Mapi" -Recurse | Where-Object {-not $_.PsIsContainer} | Where{$_.CreationTime -lt (Get-Date).AddDays(-7)}
#Get-ChildItem "\\dr-ex03\c$\Program Files\Microsoft\Exchange Server\V15\Logging\MapiHttp" -Recurse | Where-Object {-not $_.PsIsContainer} | Where{$_.CreationTime -lt (Get-Date).AddDays(-7)}