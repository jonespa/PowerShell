

#get a list of computers from the following file
$computers = Get-Content "\\horwichfarrelly.com\teams$\IT\Teams\INFRASTRUCTURE\Team\Projects\Citrix\citrix_hosts.txt" 

#this is the path to the file that is appended to the hostname
$FileToDelete = "\c$\Users\Public\Desktop\New Caseplan v2.13 - Solicitor Version.xlsm"

#this combines the hostnames friom the 1st line with the rest of the file path and recurses through the list
$computers | foreach {remove-item -path \\$_$FileToDelete}
