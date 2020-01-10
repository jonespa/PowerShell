#get a list of computers from the following file
$computers = Get-Content "\\horwichfarrelly.com\teams$\IT\Teams\INFRASTRUCTURE\Team\Projects\Citrix\citrix_hosts.txt"
#this is the path to the file we will be copying
$sourcefile = "\\horwichfarrelly.com\teams$\IT\Teams\INFRASTRUCTURE\Team\Projects\Citrix\New Caseplan v2.13 - Solicitor Version.xlsm"
#This is the destination which is appended to each hotname from the computers list
$destination = '\c$\Users\Public\Desktop'
#This sets recurses through the computer list, combining the hostname (\\$_) with the destination path ($destination)
$computers | foreach {copy-item -path $sourcefile -destination \\$_$Destination}

