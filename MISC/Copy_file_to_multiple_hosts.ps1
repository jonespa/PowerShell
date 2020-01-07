$computers = Get-Content "\\horwichfarrelly.com\teams$\IT\Teams\INFRASTRUCTURE\Team\Projects\Citrix\citrix_hosts.txt"
$sourcefile = "\\horwichfarrelly.com\teams$\IT\Teams\INFRASTRUCTURE\Team\Projects\Citrix\New Caseplan v2.13 - Solicitor Version.xlsm"
$destination = '\c$\Users\Public\Desktop'

$computers | foreach {copy-item -path $sourcefile -destination \\$_$Destination}

