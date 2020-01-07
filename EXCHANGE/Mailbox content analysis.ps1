$a = Get-mailbox -database db-equity-partners01
$b = Get-mailbox -database db-equity-partners02
$c = $a+$b
foreach($user in $c)

{
	$name = $user.alias
	$folderstat = Get-MailboxFolderStatistics -Identity $user #| where {$_.folderpath -like "*inbox*" } 
	Foreach ($folder in $folderstat)

	{
		$psobj = new-object PSObject
		$psobj | add-member -membertype noteproperty -name Name -value $name
		$psobj | add-member -membertype noteproperty -name Folder -value $folder.name
		$psobj | add-member -membertype noteproperty -name items -value $folder.itemsinfolder
		$psobj | add-member -membertype noteproperty -name size -value $folder.foldersize
		$psobj | select Name, Folder, Items, Size | export-csv c:\users\odonir\desktop\folderstat.csv -append -notypeinformation

	}

}
