## Script produces a csv listing folder stats for all mailboxes in a DB 


$a = Get-mailbox -database db-fee-earners01 -resultsize unlimited

foreach($user in $a)

{
$name = $user.alias
$b = Get-MailboxFolderStatistics -Identity $user | where {$_.folderpath -like "*inbox*" } 
Foreach ($folder in $b)

    {
    $psobj = new-object PSObject
    $psobj | add-member -membertype noteproperty -name Name -value $name
    $psobj | add-member -membertype noteproperty -name Folder -value $folder.name
    $psobj | add-member -membertype noteproperty -name items -value $folder.itemsinfolder
    $psobj | select Name, Folder, Items | export-csv c:\users\odonir\desktop\testme.csv -append -notypeinformation

    }

}
