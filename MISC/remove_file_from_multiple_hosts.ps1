$computers = Get-Content "\\horwichfarrelly.com\teams$\IT\Teams\INFRASTRUCTURE\Team\Projects\Citrix\citrix_hosts.txt"
$FileToDelete = "\c$\Users\Public\Desktop\New Caseplan v2.13 - Solicitor Version.xlsm"


$computers | foreach {remove-item -path \\$_$FileToDelete}
