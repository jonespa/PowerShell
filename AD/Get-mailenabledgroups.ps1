$RootDN = [ADSI] ''
$Searcher = New-Object System.DirectoryServices.DirectorySearcher($RootDN)

$Searcher.Filter = "(&(objectClass=group)(mail=*))"

$MeGroups = $searcher.FindAll()

Write-Host "There are" $MeGroups.Count "mail enabled groups (Security & Distribution)"


ForEach ($Group in $MeGroups) {

 $GroupDN = [ADSI]$Group.Path
 Write-Host $GroupDN.displayName "("$GroupDN.mail")"

 ForEach ($Member in $GroupDN.member) {
 
 $Member = $Member.ToString()
 $Entry = $Member.Split(",")
 $Entry = $Entry[0] -replace("CN=","")
 
 Write-Host `t $Entry
 
 }
 
 Write-Host `r`n

}