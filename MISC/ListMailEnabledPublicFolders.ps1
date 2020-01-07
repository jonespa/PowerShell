$resultsarray = @()

$mailpub = Get-MailPublicFolder -ResultSize unlimited
foreach ($folder in $mailpub) {
  $email      = $folder.primarysmtpaddress.local + "@" + $folder.primarysmtpaddress.domain
  $pubfolder  = Get-PublicFolder -Identity $folder.identity
  $folderpath = $pubfolder.parentpath + "\" + $pubfolder.name

  # Create a new object for the purpose of exporting as a CSV
  $pubObject = new-object PSObject
  $pubObject | add-member -membertype NoteProperty -name "Email" -Value $email
  $pubObject | add-member -membertype NoteProperty -name "FolderPath" -Value $folderpath


  # Append this iteration of our for loop to our results array.
  $resultsarray += $pubObject
}

# Finally we want export our results to a CSV:
$resultsarray | export-csv -Path $env:userprofile\Desktop\mail-enabled-public-folders.csv